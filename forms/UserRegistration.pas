unit UserRegistration;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.StdCtrls, FMX.Ani,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, System.IOUtils, System.Threading, IdURI, FMX.Layouts, FMX.TreeView,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, System.JSON, FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.DBScope;

type
  TRegForm = class(TForm)
    RectangleMain: TRectangle;
    NameEdit: TEdit;
    LnameEdit: TEdit;
    EmailEdit: TEdit;
    FloatAnimationEmailReg: TFloatAnimation;
    PhoneEdit: TEdit;
    PasswordEdit: TEdit;
    CPasswordEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    LabelAppName: TLabel;
    RectanglePreloader: TRectangle;
    RESTResponseDataSetAdapterReg: TRESTResponseDataSetAdapter;
    FDMemTableReg: TFDMemTable;
    LabelLoading: TLabel;
    ProgressBar1: TProgressBar;
    FloatAnimationPreloader: TFloatAnimation;
    procedure RegButtonClick(Sender: TObject);
    procedure RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    v_detailRequestId: integer;
    locationsSL, locationsSLDetails: TStringList;
    procedure initForm;
  end;

var
  RegForm: TRegForm;

implementation

{$R *.fmx}

uses DataModule, Main, UserLocations;

procedure TRegForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TRegForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TRegForm.initForm;
begin
  self.Show;
end;

procedure TRegForm.RegButtonClick(Sender: TObject);
var
  password: string;
  aTask: ITask;
begin
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          { if self.checkEmailPass(EmailEdit.Text, password, 'signup') = False then
            exit;

            if self.equalPassword(PasswordEdit.Text, CPasswordEdit.Text) = True then
            password := PasswordEdit.Text
            else
            exit; }
          RESTRequestReg.Params.Clear;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'user_type_id';
            Value := '2'
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'name';
            Value := TIdURI.ParamsEncode(NameEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'lname';
            Value := TIdURI.ParamsEncode(LnameEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'email';
            Value := TIdURI.ParamsEncode(EmailEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'phone';
            Value := PhoneEdit.Text;
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'password';
            Value := password;
          end;
          RESTRequestReg.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TRegForm.RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

procedure TRegForm.RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
begin
  if FDMemTableReg.FieldByName('loginstatus').AsInteger = 1 then
  begin

    DModule.id := FDMemTableReg.FieldByName('id').AsInteger;
    DModule.user_type_id := FDMemTableReg.FieldByName('user_type_id').AsInteger;
    DModule.fname := FDMemTableReg.FieldByName('fname').AsString;
    DModule.lname := FDMemTableReg.FieldByName('lname').AsString;
    DModule.phone := FDMemTableReg.FieldByName('phone').AsString;
    DModule.email := FDMemTableReg.FieldByName('email').AsString;
    DModule.sesskey := FDMemTableReg.FieldByName('sesskey').AsString;
    MainForm.DoAuthenticate;
    if (FDMemTableReg.FieldByName('isSetLocations').AsInteger = 0) and (DModule.user_type_id = 2) then
    begin
      with TUserLocationsForm.Create(Application) do
      begin
        initForm;
      end;
    end;
    self.RectangleMain.Visible := False;
  end;
end;

end.
