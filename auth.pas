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
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, REST.JSON, System.Threading,
  Inifiles,
  System.IOUtils, FMX.Layouts, FMX.LoadingIndicator, Header;

type
  TauthForm = class(TForm)
    EditAuthEmail: TEdit;
    EditAuthPassword: TEdit;
    ButtonAuth: TButton;
    Rectangle2: TRectangle;
    TabControl1: TTabControl;
    TabItemAuth: TTabItem;
    TabItemReg: TTabItem;
    FullNameEdit: TEdit;
    CPasswordEdit: TEdit;
    PasswordEdit: TEdit;
    EmailEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    PhoneEdit: TEdit;
    RESTRequestAuth: TRESTRequest;
    RESTResponseAuth: TRESTResponse;
    RESTResponseDataSetAdapterAuth: TRESTResponseDataSetAdapter;
    FDMemTableAuth: TFDMemTable;
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
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    Timer2: TTimer;
    RectanglePreloader: TRectangle;
    RectangleHeder: TRectangle;
    Button4: TButton;
    Label2: TLabel;
    FDMemTableAuthid: TWideStringField;
    FDMemTableAuthuser_type_id: TWideStringField;
    FDMemTableAuthuser_status_id: TWideStringField;
    FDMemTableAuthfull_name: TWideStringField;
    FDMemTableAuthphone: TWideStringField;
    FDMemTableAuthemail: TWideStringField;
    FDMemTableAuthcreate_date: TWideStringField;
    FDMemTableAuthmodify_date: TWideStringField;
    FDMemTableAuthregipaddr: TWideStringField;
    FDMemTableAuthsesskey: TWideStringField;
    FDMemTableAuthloginstatus: TWideStringField;
    FDMemTableAuthisSetLocations: TWideStringField;
    FDMemTableAuthnotifications: TWideStringField;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    Image1: TImage;
    HeaderFrame1: THeaderFrame;
    procedure RegButtonClick(Sender: TObject);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonAuthClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure ButtonPasswordRecoveryClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure RESTRequestAuthAfterExecute(Sender: TCustomRESTRequest);
    procedure Timer2Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    function equalPassword(pass1, pass2: string): boolean;
    function checkEmailPass(EmailAddress, password, op: string): boolean;
    function setUserFields: boolean;
    { Private declarations }
  public
    { Public declarations }
    closeAfterReg: boolean;
    procedure initForm;
    function consoleAuth(AuthEmail, AuthPassword: string): TFDMemTable;
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
            Value := '1';
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

procedure TauthForm.RESTRequestAuthAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
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
var
  Ini: TIniFile;
begin
  Timer2.Enabled := False;
  if FDMemTableAuth.FieldByName('loginstatus').AsInteger = 1 then
  begin
    DModule.id := FDMemTableAuth.FieldByName('id').AsInteger;
    DModule.user_type_id := FDMemTableAuth.FieldByName('user_type_id').AsInteger;
    DModule.full_name := FDMemTableAuth.FieldByName('full_name').AsString;
    DModule.phone := FDMemTableAuth.FieldByName('phone').AsString;
    DModule.email := FDMemTableAuth.FieldByName('email').AsString;
    DModule.sesskey := FDMemTableAuth.FieldByName('sesskey').AsString;
    DModule.notifications := FDMemTableAuth.FieldByName('notifications').AsInteger;

    // ---------------
    Ini := TIniFile.Create(TPath.Combine(TPath.GetHomePath, DModule.AzomvaSettingsIniFile));
    try
      Ini.AutoSave := True;
      Ini.WriteInteger('auth', 'id', DModule.id);
      Ini.WriteInteger('auth', 'user_type_id', DModule.user_type_id);
      Ini.WriteString('auth', 'full_name', DModule.full_name);
      Ini.WriteString('auth', 'phone', DModule.phone);
      Ini.WriteString('auth', 'email', DModule.email);
      Ini.WriteString('auth', 'hash', DModule.sesskey);
      Ini.UpdateFile;
    finally
      Ini.Free;
    end;

    MainForm.DoAuthenticate;
    self.Close;
  end;
end;

procedure TauthForm.Button4Click(Sender: TObject);
begin
  self.PanelPasswordRecovery.Visible := False;
end;

function TauthForm.consoleAuth(AuthEmail, AuthPassword: string): TFDMemTable;
begin
  RESTRequestAuth.Params.Clear;
  with RESTRequestAuth.Params.AddItem do
  begin
    name := 'email';
    Value := AuthEmail;
  end;
  with RESTRequestAuth.Params.AddItem do
  begin
    name := 'password';
    Value := AuthPassword;
  end;
  with RESTRequestAuth.Params.AddItem do
  begin
    name := 'op';
    Value := 'login';
  end;
  RESTRequestAuth.Execute;
  Result := FDMemTableAuth;
end;

procedure TauthForm.ButtonAuthClick(Sender: TObject);
var
  aTask: ITask;
begin
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
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

procedure TauthForm.FormCreate(Sender: TObject);
begin
  self.closeAfterReg := False;
end;

procedure TauthForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
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
        DModule.full_name := (jv as TJSONObject).Get('full_name').JSONValue.ToString;
        DModule.phone := (jv as TJSONObject).Get('phone').JSONValue.ToString;
        DModule.email := (jv as TJSONObject).Get('email').JSONValue.ToString;
      end;
    end;
  finally
    JSONValue.Free;
  end;
end;

end.
