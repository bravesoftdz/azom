unit UserRegistration;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.StdCtrls, FMX.Ani,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, System.IOUtils, System.Threading, IdURI, FMX.Layouts, FMX.TreeView, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, System.JSON, FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
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
    Rectangle1: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    RESTRequestLocation: TRESTRequest;
    RESTResponseLocation: TRESTResponse;
    RESTResponseDataSetAdapterL: TRESTResponseDataSetAdapter;
    FDMemTableL: TFDMemTable;
    ListBoxLocationsMaster: TListBox;
    FDMemTableLid: TWideStringField;
    FDMemTableLpid: TWideStringField;
    FDMemTableLtitle: TWideStringField;
    FDMemTableLmap_title: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    RectangleDetail: TRectangle;
    FloatAnimation3: TFloatAnimation;
    ListBox1: TListBox;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTableDetails: TFDMemTable;
    procedure RegButtonClick(Sender: TObject);
    procedure ListBoxLocationsMasterItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  RegForm: TRegForm;

implementation

{$R *.fmx}

uses DataModule, Main;

procedure TRegForm.initForm;
begin
  self.Show;
  self.RESTRequestLocation.Execute;
end;

procedure TRegForm.ListBoxLocationsMasterItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
begin
  RectangleDetail.Visible := True;
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
            Value := LnameEdit.Text;
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

end.
