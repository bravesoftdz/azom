unit UserGanmcxadebeliReg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header,
  FMX.StdCtrls, FMX.Ani,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, System.Threading, IdURI, FireDAC.Comp.Client,
  REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Layouts, FMX.LoadingIndicator, System.JSON, Inifiles, System.IOUtils;

type
  TGanmcxadeblisRegForm = class(TForm)
    HeaderFrame1: THeaderFrame;
    RectangleMain: TRectangle;
    CPasswordEdit: TEdit;
    EmailEdit: TEdit;
    FloatAnimationEmailReg: TFloatAnimation;
    FullNameEdit: TEdit;
    PasswordEdit: TEdit;
    PhoneEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    RectanglePreloader: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    FDMemTableAuth: TFDMemTable;
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
    ButtonConfirmation: TButton;
    LabelConfirmation: TLabel;
    RectangleConfirmation: TRectangle;
    EditConfirmation: TEdit;
    RESTRequestActivation: TRESTRequest;
    RESTResponseActivation: TRESTResponse;
    RESTRequestAuth: TRESTRequest;
    RESTResponseAuth: TRESTResponse;
    RESTResponseDataSetAdapterAuth: TRESTResponseDataSetAdapter;
    Timer1: TTimer;
    RectangleAuth: TRectangle;
    EditAuthEmail: TEdit;
    FloatAnimationEmailAuth: TFloatAnimation;
    EditAuthPassword: TEdit;
    ButtonAuth: TButton;
    Image1: TImage;
    ButtonCloseAuth: TButton;
    Button1: TButton;
    procedure RegButtonClick(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonConfirmationClick(Sender: TObject);
    procedure RESTRequestActivationAfterExecute(Sender: TCustomRESTRequest);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonAuthClick(Sender: TObject);
    procedure ButtonCloseAuthClick(Sender: TObject);
    procedure Label1Tap(Sender: TObject; const Point: TPointF);
    procedure Button1Click(Sender: TObject);
  private
    function equalPassword(pass1, pass2: string): boolean;
    procedure consoleAuth(AuthEmail, AuthPassword: string);
    { Private declarations }
  public
    { Public declarations }
    closeAfterReg: boolean;
    procedure initForm;
  end;

var
  GanmcxadeblisRegForm: TGanmcxadeblisRegForm;

implementation

{$R *.fmx}

uses Main, DataModule, auth;
{ TForm1 }

procedure TGanmcxadeblisRegForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TGanmcxadeblisRegForm.initForm;
begin
  self.Show;
  self.HeaderFrame1.LabelAppName.Text := 'განმცხადებლის რეგისტრაცია';
end;

procedure TGanmcxadeblisRegForm.Label1Tap(Sender: TObject;
  const Point: TPointF);
begin
  RectangleAuth.Visible := True;
end;

procedure TGanmcxadeblisRegForm.Button1Click(Sender: TObject);
begin
  RectangleAuth.Visible := True;
end;

procedure TGanmcxadeblisRegForm.ButtonAuthClick(Sender: TObject);
begin
  with TauthForm.Create(Application) do
  begin
    if consoleAuth(EditAuthEmail.Text, EditAuthPassword.Text) = True then
    begin
      ShowMessage('ავტორიზაციამ ჩაიარა წარმატებით');
      self.Close;
    end
    else
    begin
      ShowMessage('ელ-ფოსტა ან პაროლი არ არის სწორი!');
    end;
  end;
end;

procedure TGanmcxadeblisRegForm.ButtonCloseAuthClick(Sender: TObject);
begin
  RectangleAuth.Visible := False;
end;

procedure TGanmcxadeblisRegForm.ButtonConfirmationClick(Sender: TObject);
begin
  if ButtonConfirmation.Tag = 0 then
  begin
    EditConfirmation.CanFocus := True;
    ButtonConfirmation.Text := 'დადასტურება';
    ButtonConfirmation.Tag := 1;
  end
  else if ButtonConfirmation.Tag = 1 then
  begin
    ButtonConfirmation.Text := 'იტვირთება...';
    ButtonConfirmation.Tag := 2;
    RESTRequestActivation.Execute;
    { if EditConfirmation.Text = '1234' then
      begin
      ShowMessage('აქტივაციამ ჩაიარა წარმატებით');
      self.Close;
      end; }
  end;
end;

function TGanmcxadeblisRegForm.equalPassword(pass1, pass2: string): boolean;
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

procedure TGanmcxadeblisRegForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TGanmcxadeblisRegForm.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 137 then
    self.Free;
end;

procedure TGanmcxadeblisRegForm.RegButtonClick(Sender: TObject);
var
  password: string;
  aTask: ITask;
begin
  if self.equalPassword(PasswordEdit.Text, CPasswordEdit.Text) = True then
    password := PasswordEdit.Text
  else
  begin
    ShowMessage('პაროლის ველები არ მეთხვევა ერთმანეთს');
    exit;
  end;
  self.RectanglePreloader.Visible := True;
  FMXLoadingIndicator1.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          { if self.checkEmailPass(EmailEdit.Text, password, 'signup') = False then
            exit;
          }
          RESTRequestReg.Params.Clear;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'user_type_id';
            Value := '1'
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'full_name';
            Value := TIdURI.ParamsEncode(FullNameEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
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

procedure TGanmcxadeblisRegForm.RESTRequestActivationAfterExecute
  (Sender: TCustomRESTRequest);
var
  jsonObject: TJSONObject;
  msg: string;
  status: integer;
begin
  jsonObject := TJSONObject.ParseJSONValue
    (TEncoding.UTF8.GetBytes(self.RESTResponseReg.Content), 0) as TJSONObject;
  status := jsonObject.GetValue('status').Value.ToInteger;
  msg := jsonObject.GetValue('msg').Value;
  self.RectanglePreloader.Visible := False;
  RectangleConfirmation.Visible := False;
  if status = 1 then
  begin
    ShowMessage(msg);
    self.Close;
  end;
end;

procedure TGanmcxadeblisRegForm.RESTRequestRegAfterExecute
  (Sender: TCustomRESTRequest);
var
  jsonObject: TJSONObject;
  msg: string;
  status: integer;
begin
  jsonObject := TJSONObject.ParseJSONValue
    (TEncoding.UTF8.GetBytes(self.RESTResponseReg.Content), 0) as TJSONObject;
  status := jsonObject.GetValue('status').Value.ToInteger;
  msg := jsonObject.GetValue('msg').Value;
  FMXLoadingIndicator1.Visible := False;
  if status = 1 then
  begin
    RectanglePreloader.Visible := False;
    ShowMessage(msg);
    // self.consoleAuth(EmailEdit.Text, PasswordEdit.Text);
    self.Close;
  end
  else if status = 0 then
  begin
    RectanglePreloader.Visible := False;
    ShowMessage(msg);
  end
  else if status = 3 then
  begin
    RectangleConfirmation.Visible := True;
    LabelConfirmation.Text := msg;
  end;
end;

procedure TGanmcxadeblisRegForm.consoleAuth(AuthEmail, AuthPassword: string);
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
end;

procedure TGanmcxadeblisRegForm.Timer1Timer(Sender: TObject);
var
  Ini: TMemIniFile;
begin
  Timer1.Enabled := False;
  if FDMemTableAuth.FieldByName('loginstatus').AsInteger = 1 then
  begin
    DModule.id := FDMemTableAuth.FieldByName('id').AsInteger;
    DModule.user_type_id := FDMemTableAuth.FieldByName('user_type_id')
      .AsInteger;
    DModule.full_name := FDMemTableAuth.FieldByName('full_name').AsString;
    DModule.phone := FDMemTableAuth.FieldByName('phone').AsString;
    DModule.email := FDMemTableAuth.FieldByName('email').AsString;
    DModule.sesskey := FDMemTableAuth.FieldByName('sesskey').AsString;
    DModule.notifications := FDMemTableAuth.FieldByName('notifications')
      .AsInteger;

    // ---------------
    Ini := TMemIniFile.Create(TPath.Combine(TPath.GetDocumentsPath,
      'AzomvaSettings.ini'));
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

end.

