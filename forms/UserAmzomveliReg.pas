unit UserAmzomveliReg;

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
  FMX.Bind.Editors, Data.Bind.DBScope, Header, FMX.LoadingIndicator;

type
  TUserAmzomveliRegForm = class(TForm)
    RectangleMain: TRectangle;
    FullNameEdit: TEdit;
    EmailEdit: TEdit;
    FloatAnimationEmailReg: TFloatAnimation;
    PhoneEdit: TEdit;
    PasswordEdit: TEdit;
    CPasswordEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    RectanglePreloader: TRectangle;
    RESTResponseDataSetAdapterReg: TRESTResponseDataSetAdapter;
    FDMemTableReg: TFDMemTable;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    HeaderFrame1: THeaderFrame;
    procedure RegButtonClick(Sender: TObject);
    procedure RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    v_detailRequestId: integer;
    locationsSL, locationsSLDetails: TStringList;
    procedure initForm;
  end;

var
  UserAmzomveliRegForm: TUserAmzomveliRegForm;

implementation

{$R *.fmx}

uses DataModule, Main, UserLocations;

procedure TUserAmzomveliRegForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUserAmzomveliRegForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TUserAmzomveliRegForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUserAmzomveliRegForm.initForm;
begin
  self.Show;
  self.HeaderFrame1.LabelAppName.Text := 'ამზომველის რეგისტრაცია';
  // self.RectanglePreloader.Visible := True;
end;

procedure TUserAmzomveliRegForm.RegButtonClick(Sender: TObject);
var
  password: string;
  aTask: ITask;
begin
  self.RectanglePreloader.Visible := True;
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
            name := 'full_name';
            Value := TIdURI.ParamsEncode(FullNameEdit.Text);
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

procedure TUserAmzomveliRegForm.RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

procedure TUserAmzomveliRegForm.RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
begin
  if FDMemTableReg.FieldByName('loginstatus').AsInteger = 1 then
  begin

    DModule.id := FDMemTableReg.FieldByName('id').AsInteger;
    DModule.user_type_id := FDMemTableReg.FieldByName('user_type_id').AsInteger;
    DModule.full_name := FDMemTableReg.FieldByName('full_name').AsString;
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

