unit auth;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, FMX.TabControl, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, FMX.Ani,
  System.JSON, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, IdURI,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, REST.JSON, System.Threading;

type
  TauthForm = class(TForm)
    EditAuthEmail: TEdit;
    EditAuthPassword: TEdit;
    ButtonAuth: TButton;
    Rectangle2: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    NameEdit: TEdit;
    CPasswordEdit: TEdit;
    PasswordEdit: TEdit;
    EmailEdit: TEdit;
    LnameEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    PhoneEdit: TEdit;
    RESTRequestAuth: TRESTRequest;
    RESTResponseAuth: TRESTResponse;
    RESTResponseDataSetAdapterAuth: TRESTResponseDataSetAdapter;
    FDMemTableAuth: TFDMemTable;
    FDMemTableAuthresult: TWideStringField;
    FDMemTableAuthsesskey: TWideStringField;
    FDMemTableAuthloginstatus: TWideStringField;
    PanelPasswordRecovery: TPanel;
    EditPhoneNumberForActivation: TEdit;
    Button1: TButton;
    EditActivationCode: TEdit;
    Button2: TButton;
    FloatAnimation1: TFloatAnimation;
    ButtonPasswordRecovery: TButton;
    Button3: TButton;
    FloatAnimationEmailAuth: TFloatAnimation;
    Timer1: TTimer;
    FloatAnimationEmailReg: TFloatAnimation;
    RESTResponseDataSetAdapterUser: TRESTResponseDataSetAdapter;
    FDMemTableUser: TFDMemTable;
    FDMemTableUserid: TWideStringField;
    FDMemTableUseruser_type_id: TWideStringField;
    FDMemTableUserfname: TWideStringField;
    FDMemTableUserlname: TWideStringField;
    FDMemTableUserphone: TWideStringField;
    FDMemTableUseremail: TWideStringField;
    FDMemTableUsercreate_date: TWideStringField;
    FDMemTableUsermodify_date: TWideStringField;
    FDMemTableUserregipaddr: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Timer2: TTimer;
    RectangleUserType: TRectangle;
    SwitchUserType: TSwitch;
    LabelUserTypesText: TLabel;
    RectanglePreloader: TRectangle;
    AniIndicator1: TAniIndicator;
    RectangleHeder: TRectangle;
    Button4: TButton;
    Label2: TLabel;
    procedure RegButtonClick(Sender: TObject);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonAuthClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure ButtonPasswordRecoveryClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RESTRequestAuthAfterExecute(Sender: TCustomRESTRequest);
    procedure Timer2Timer(Sender: TObject);
  private
    function equalPassword(pass1, pass2: string): boolean;
    function checkEmailPass(EmailAddress, password, op: string): boolean;
    function setUserFields: boolean;
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  authForm: TauthForm;

implementation

{$R *.fmx}

uses DataModule, HelperUnit, Main;

procedure TauthForm.RegButtonClick(Sender: TObject);
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
            if SwitchUserType.IsChecked = True then
              Value := '2'
            else
              Value := '1';
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

procedure TauthForm.RESTRequestAuthAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := True;
  Timer2.Enabled := True;
  // self.setUserFields;
end;

procedure TauthForm.RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
begin
  ShowMessage(RESTResponseReg.Content);
end;

procedure TauthForm.Timer1Timer(Sender: TObject);
begin
  FloatAnimationEmailAuth.Enabled := False;
  FloatAnimationEmailReg.Enabled := False;
  EditAuthEmail.FontColor := TAlphaColors.Grey;
end;

procedure TauthForm.Timer2Timer(Sender: TObject);
begin
  Timer2.Enabled := False;
  if FDMemTableAuth.FieldByName('loginstatus').AsInteger = 1 then
  begin
    DModule.id := FDMemTableUser.FieldByName('id').AsInteger;
    DModule.user_type_id := FDMemTableUser.FieldByName('user_type_id').AsInteger;
    DModule.fname := FDMemTableUser.FieldByName('fname').AsString;
    DModule.lname := FDMemTableUser.FieldByName('lname').AsString;
    DModule.phone := FDMemTableUser.FieldByName('phone').AsString;
    DModule.email := FDMemTableUser.FieldByName('email').AsString;
    DModule.sesskey := FDMemTableAuth.FieldByName('sesskey').AsString;
    MainForm.DoAuthenticate;
    self.Close;
  end;
end;

procedure TauthForm.ButtonAuthClick(Sender: TObject);
var
  aTask: ITask;
begin
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          {
            if self.checkEmailPass(EditAuthEmail.Text, EditAuthPassword.Text, 'signin') = False then
            exit;
          }
          RESTRequestAuth.Params.Clear;
          with RESTRequestAuth.Params.AddItem do
          begin
            name := 'email';
            Value := EditAuthEmail.Text;
          end;
          with RESTRequestAuth.Params.AddItem do
          begin
            name := 'password';
            Value := EditAuthPassword.Text;
          end;
          with RESTRequestAuth.Params.AddItem do
          begin
            name := 'op';
            Value := 'login';
          end;
          RESTRequestAuth.Execute;
        end);
    end);
  aTask.Start;
end;

function TauthForm.checkEmailPass(EmailAddress, password, op: string): boolean;
var
  HelperUnit: THelperUnit;
begin
  HelperUnit := THelperUnit.Create;
  if HelperUnit.ValidEmail(EmailAddress) = False then
  begin
    if op = 'signin' then
      FloatAnimationEmailAuth.Enabled := True;
    if op = 'signup' then
      FloatAnimationEmailReg.Enabled := True;
    Result := False;
    Timer1.Enabled := True;
  end
  else
    Result := True;
end;

procedure TauthForm.ButtonPasswordRecoveryClick(Sender: TObject);
begin
  PanelPasswordRecovery.Visible := True;
end;

function TauthForm.equalPassword(pass1, pass2: string): boolean;
begin
  if pass1.Equals(pass2) then
  begin
    Result := True;
  end
  else
  begin
    PasswordEdit.FontColor := TAlphaColors.Red;
    Result := False;
  end;
end;

procedure TauthForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TauthForm.initForm;
begin
  self.Show;
end;

procedure TauthForm.Button2Click(Sender: TObject);
begin
  PanelPasswordRecovery.Visible := False;
end;

function TauthForm.setUserFields: boolean;
var
  jsonObject: TJSONObject;
  JSONValue, jv: TJsonValue;
  v_result: string;
begin
  jsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(self.RESTResponseAuth.Content), 0) as TJSONObject;
  v_result := jsonObject.GetValue('result').ToString;
  JSONValue := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(v_result), 0);
  try
    if JSONValue is TJSONArray then
    begin
      for jv in TJSONArray(JSONValue) do
      begin
        DModule.id := (jv as TJSONObject).Get('id').JSONValue.ToString.ToInteger;
        DModule.user_type_id := (jv as TJSONObject).Get('user_type_id').JSONValue.ToString.ToInteger;
        DModule.fname := (jv as TJSONObject).Get('fname').JSONValue.ToString;
        DModule.lname := (jv as TJSONObject).Get('lname').JSONValue.ToString;
        DModule.phone := (jv as TJSONObject).Get('phone').JSONValue.ToString;
        DModule.email := (jv as TJSONObject).Get('email').JSONValue.ToString;
      end;
    end;
  finally
    JSONValue.free;
  end;

end;

end.
