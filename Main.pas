unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.MultiView, FMX.StdCtrls, System.Actions,
  FMX.ActnList, FMX.Objects, FMX.Layouts, FMX.Ani, FMX.Effects,
  FMX.Filter.Effects, System.ImageList, FMX.ImgList, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  Data.Bind.Components, Data.Bind.ObjectScope, System.JSON, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.DBScope,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, FMX.TabControl, FMX.Gestures, System.Threading,
  System.PushNotification,
  System.Notification,
  FMX.ScrollBox, FMX.Memo,
  DW.PushClient, IdURI, System.IOUtils,
  Inifiles, FMX.Header, User2ListFR,
  FMX.LoadingIndicator,
  System.Messaging
{$IFDEF ANDROID}
    , // System.Android.Service,
     // FMX.DialogService,
    // Androidapi.JNI.PlayServices,
  FMX.PushNotification.Android,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.Net,
  Androidapi.JNI.Telephony,
  Androidapi.JNI.Provider
{$ENDIF ANDROID}
{$IFDEF IOS}
    , FMX.PushNotification.IOS
{$ENDIF};

type
  TMainForm = class(TForm)
    ActionList1: TActionList;
    AuthAction: TAction;
    RectangleNonAuth: TRectangle;
    ButtonAuthReg: TButton;
    RectangleProfile: TRectangle;
    ButtonAddApp: TButton;
    ButtonUserNotifications: TButton;
    ButtonMyApps: TButton;
    ActionAppAdding: TAction;
    ActionMyApps: TAction;
    ActionUserArea: TAction;
    RESTRequestVersioning: TRESTRequest;
    RESTResponseVersioning: TRESTResponse;
    TimerVersioning: TTimer;
    BindingsList1: TBindingsList;
    TabControl1: TTabControl;
    TabItemMain: TTabItem;
    TabItemUserArea: TTabItem;
    TabControl2: TTabControl;
    TabItem4: TTabItem;
    TabItem5: TTabItem;
    Rectangle4: TRectangle;
    GestureManager1: TGestureManager;
    ActiontabSliderRight: TAction;
    ActiontabSliderLeft: TAction;
    FloatAnimation1: TFloatAnimation;
    ChangeTabActionRight: TChangeTabAction;
    ChangeTabActionLeft: TChangeTabAction;
    StyleBook1: TStyleBook;
    ButtonSettings: TButton;
    Rectangle3: TRectangle;
    RectangleApps: TRectangle;
    Circle1: TCircle;
    LabelTotalAppsCount: TLabel;
    ButtonSignOut: TButton;
    ActionSignOut: TAction;
    RESTRequestSignOut: TRESTRequest;
    RESTResponseSignOut: TRESTResponse;
    Rectangle5: TRectangle;
    Rectangle9: TRectangle;
    TextMainPageText: TText;
    RESTResponseDataSetAdapterInit: TRESTResponseDataSetAdapter;
    FDMemTableInit: TFDMemTable;
    PreloaderRectangle: TRectangle;
    RESTResponseDataSetAdapterPages: TRESTResponseDataSetAdapter;
    FDMemTablePages: TFDMemTable;
    FDMemTablePagesid: TWideStringField;
    FDMemTablePagesgroup_id: TWideStringField;
    FDMemTablePageslang_id: TWideStringField;
    FDMemTablePagestitle: TWideStringField;
    FDMemTablePagescontent: TWideStringField;
    FDMemTablePagesmeta_keywords: TWideStringField;
    FDMemTablePagesmeta_description: TWideStringField;
    FDMemTablePagescreate_date: TWideStringField;
    FDMemTablePagesmodify_date: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    Circle2: TCircle;
    LabelWeekApps: TLabel;
    Rectangle1: TRectangle;
    ImageList1: TImageList;
    RectangleMainHeader: TRectangle;
    ButtonMasterView: TButton;
    ActionUserNotifications: TAction;
    LabelAppName: TLabel;
    BindSourceDB2: TBindSourceDB;
    LabelApps: TLabel;
    MultiView1: TMultiView;
    Button2: TButton;
    RESTRequestDeviceToken: TRESTRequest;
    NotificationCenter1: TNotificationCenter;
    RESTResponseDataSetAdapterAuth: TRESTResponseDataSetAdapter;
    FDMemTableAuth: TFDMemTable;
    FDMemTableAuthid: TWideStringField;
    FDMemTableAuthuser_type_id: TWideStringField;
    FDMemTableAuthuser_status_id: TWideStringField;
    FDMemTableAuthfname: TWideStringField;
    FDMemTableAuthlname: TWideStringField;
    FDMemTableAuthphone: TWideStringField;
    FDMemTableAuthemail: TWideStringField;
    FDMemTableAuthcreate_date: TWideStringField;
    FDMemTableAuthmodify_date: TWideStringField;
    FDMemTableAuthregipaddr: TWideStringField;
    FDMemTableAuthsesskey: TWideStringField;
    FDMemTableAuthloginstatus: TWideStringField;
    FDMemTableAuthisSetLocations: TWideStringField;
    ButtonRegGanmcxadeblis: TButton;
    ActionRegGanmcxadebeli: TAction;
    LabelFullName: TLabel;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    TabItemAmzomvelebi: TTabItem;
    Button1: TButton;
    Button3: TButton;
    Button4: TButton;
    ButtonGanmcxReg: TButton;
    ButtonAuth: TButton;
    Image1: TImage;
    User2ListFrame1: TUser2ListFrame;
    Button5: TButton;
    CircleAddApp: TCircle;
    Label2: TLabel;
    ButtonContracts: TButton;
    ActionMyContracts: TAction;
    TimerInitActivation: TTimer;
    ImageLogo: TImage;
    SpeedButtonNotifications: TSpeedButton;
    RectangleConnectionStatus: TRectangle;
    LabelConnectionStatus: TLabel;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    RESTResponseDSAInitUser: TRESTResponseDataSetAdapter;
    FDMemTableInitUser: TFDMemTable;
    FDMemTableInitUserid: TWideStringField;
    FDMemTableInitUseruser_type_id: TWideStringField;
    FDMemTableInitUseruser_status_id: TWideStringField;
    FDMemTableInitUserfull_name: TWideStringField;
    FDMemTableInitUserphone: TWideStringField;
    FDMemTableInitUseremail: TWideStringField;
    FDMemTableInitUsercreate_date: TWideStringField;
    FDMemTableInitUsermodify_date: TWideStringField;
    FDMemTableInitUserregipaddr: TWideStringField;
    FDMemTableInitUsersesskey: TWideStringField;
    FDMemTableInitUserloginstatus: TWideStringField;
    FDMemTableInitUserisSetLocations: TWideStringField;
    FDMemTableInitUsernotifications: TWideStringField;
    FDMemTableInittotal_apps_count: TWideStringField;
    FDMemTableInitweek_apps_count: TWideStringField;
    FDMemTableInitusers2count: TWideStringField;
    FDMemTableInitapp_name: TWideStringField;
    FDMemTableInitAzomva_GCMAppID: TWideStringField;
    FDMemTableInitAzomva_Legacy_server_key: TWideStringField;
    FDMemTableInitaction: TWideStringField;
    FDMemTableInitmsg: TWideStringField;
    procedure AuthActionExecute(Sender: TObject);
    procedure ActionAppAddingExecute(Sender: TObject);
    procedure ActionMyAppsExecute(Sender: TObject);
    procedure ActionUserAreaExecute(Sender: TObject);
    procedure TimerVersioningTimer(Sender: TObject);
    procedure RESTRequestVersioningAfterExecute(Sender: TCustomRESTRequest);
    procedure ChangeTabActionRightUpdate(Sender: TObject);
    procedure ChangeTabActionLeftUpdate(Sender: TObject);
    procedure ActionSignOutExecute(Sender: TObject);
    procedure RESTRequestSignOutAfterExecute(Sender: TCustomRESTRequest);
    procedure RectangleAppsClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionUserNotificationsExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
    procedure ActionRegGanmcxadebeliExecute(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure User2ListFrame1Button1Click(Sender: TObject);
    procedure ActionMyContractsExecute(Sender: TObject);
    procedure TimerInitActivationTimer(Sender: TObject);
    procedure Rectangle1Click(Sender: TObject);
  private
    procedure PushClientChangeHandler(Sender: TObject; AChange: TPushService.TChanges);
    procedure PushClientReceiveNotificationHandler(Sender: TObject; const ANotification: TPushServiceNotification);
{$IFDEF ANDROID}
    // procedure ServiceAppStart;
    // function isServiceStarted: Boolean;
{$ENDIF ANDROID}
    procedure checkVersion;
    // procedure loginRequest(hash, phone, email: string);
    procedure clearINIParams;
    // procedure OnServiceConnectionChange(Sender: TObject; AChange: TPushService.TChanges);
    // function isServiceStarted: Boolean;
{$IFDEF ANDROID}
    function getDeviceID: string;
{$ENDIF ANDROID}
    { Private declarations }
  public
    { Public declarations }
    FPushClient: TPushClient;
    v_Ini: TIniFile;
    procedure DoAuthenticate;
    procedure showConnectionIsOffline;
    procedure showConnectionIsOnline;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses auth, DataModule, MyApps, UserArea, AppList,
  UserNotifications, AppDetails,
  UserGanmcxadebeliReg, AddApps, MyContracts, User2Review, HelperUnit;

procedure TMainForm.DoAuthenticate;
begin
  self.RectangleNonAuth.Visible := False;
  LabelFullName.Text := DModule.full_name;
  ButtonUserNotifications.Text := '(' + DModule.notifications.ToString + ') შეტყობინებები';
  SpeedButtonNotifications.Text := DModule.notifications.ToString;
  self.RectangleProfile.Visible := True;
  FPushClient.Active := True;
  ButtonGanmcxReg.Visible := False;
  ButtonAuth.Visible := False;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  self.PreloaderRectangle.Visible := True;
  self.SpeedButtonNotifications.Visible := False;
  self.v_Ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, DModule.AzomvaSettingsIniFile));
  self.v_Ini.AutoSave := True;
end;

procedure TMainForm.PushClientReceiveNotificationHandler(Sender: TObject; const ANotification: TPushServiceNotification);
var
  MyNotification: TNotification;
  ini: TIniFile;
  v_action, v_app_id, v_user_id: string;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  // ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, DModule.AzomvaNotificationsSettingsIniFile));
  try
    { ini.AutoSave := True;
      ini.WriteString('Notification', 'action', ANotification.DataObject.Values['action'].ToString.Replace('"', ''));
      ini.WriteString('Notification', 'app_id', ANotification.DataObject.Values['app_id'].ToString.Replace('"', ''));
      ini.WriteString('Notification', 'user_id', ANotification.DataObject.Values['user_id'].ToString.Replace('"', ''));
    }
    MyNotification.Name := ANotification.DataObject.Values['action'].ToString.Replace('"', '');
    // + '^' + ANotification.DataObject.Values['app_id'].ToString.Replace('"', '') + '^' + ANotification.DataObject.Values['user_id'].ToString.Replace('"', '');
    MyNotification.Title := ANotification.DataObject.Values['title'].ToString.Replace('"', '');
    MyNotification.AlertBody := ANotification.DataObject.Values['message'].ToString.Replace('"', ''); // + v_action;
    MyNotification.EnableSound := True;
    MyNotification.Number := 1;
    MyNotification.HasAction := True;
    MyNotification.AlertAction := 'Launch';
    NotificationCenter1.PresentNotification(MyNotification);
    NotificationCenter1.ApplicationIconBadgeNumber := 1;
  finally
    MyNotification.DisposeOf;
    // ini.free;
  end;
end;

procedure TMainForm.NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
var
  sl: TStringList;
  ini: TIniFile;
begin
  ShowMessage(ANotification.Name);
  self.NotificationCenter1.CancelNotification(ANotification.Name);
  ini := TIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, DModule.AzomvaNotificationsSettingsIniFile));
  self.TextMainPageText.Text := 'action: ' + ini.ReadString('Notification', 'action', '') + '; app_id: ' +
    ini.ReadString('Notification', 'app_id', '') + '; user_id: ' + ini.ReadString('Notification', 'user_id', '');
  { sl.Delimiter := '^';
    sl.DelimitedText := ANotification.Name;
    v_action := sl[0];
    ShowMessage(sl[0] + sl[1] + sl[2]);
    v_app_id := sl[1];
    v_user_id := sl[2];
    if self.action = 'TAppDetailForm' then
    begin
    with TAppDetailForm.Create(Application) do
    begin
    initForm(self.app_id.ToInteger);
    end;
    end
    else if self.action = 'TUser2ReviewForm' then
    begin
    if self.user_id.ToInteger > 0 then
    begin
    with TUser2ReviewForm.Create(Application) do
    begin
    initForm(self.user_id.ToInteger);
    end;
    end;
    end; }
end;

procedure TMainForm.PushClientChangeHandler(Sender: TObject; AChange: TPushService.TChanges);
var
  aTask: ITask;
begin
  if TPushService.TChange.DeviceToken in AChange then
  begin
    aTask := TTask.Create(
      procedure()
      begin
        TThread.Synchronize(nil,
          procedure
          begin
            RESTRequestDeviceToken.Params.Clear;
            RESTRequestDeviceToken.AddParameter('deviceid', self.getDeviceID);
            // FPushClient.DeviceId;
            RESTRequestDeviceToken.AddParameter('devicetoken', TIdURI.ParamsEncode(FPushClient.DeviceToken));
            RESTRequestDeviceToken.AddParameter('sesskey', DModule.sesskey);
            RESTRequestDeviceToken.AddParameter('user_id', DModule.id.ToString);
            RESTRequestDeviceToken.Execute;
          end);
      end);
    aTask.Start;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FPushClient.free;
  self.v_Ini.free;
end;

procedure TMainForm.ActionRegGanmcxadebeliExecute(Sender: TObject);
begin
  // განმცხადებლის რეგისტრაცია
  with TGanmcxadeblisRegForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionAppAddingExecute(Sender: TObject);
begin
  self.MultiView1.HideMaster;
  with TFormAddApps.Create(Application) do
  begin
    initForm;
  end;
  { with TUser2ReviewForm.Create(Application) do
    begin
    v_user_FullName := 'saeli gvari';
    initForm(2);
    end; }
end;

procedure TMainForm.ActionMyAppsExecute(Sender: TObject);
begin
  with TFormMyApps.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionMyContractsExecute(Sender: TObject);
begin
  with TMyContractsForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionSignOutExecute(Sender: TObject);
var
  aTask: ITask;
begin
  TimerVersioning.Enabled := False;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestSignOut.Params.Clear;
          RESTRequestSignOut.AddParameter('sesskey', DModule.sesskey);
          RESTRequestSignOut.AddParameter('user_id', DModule.id.ToString);
          RESTRequestSignOut.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TMainForm.ActionUserAreaExecute(Sender: TObject);
begin
  with TUserAreaForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionUserNotificationsExecute(Sender: TObject);
begin
  with TUserNotificationsForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.AuthActionExecute(Sender: TObject);
begin
  with TauthForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  { self.TabControl1.ActiveTab := TabItemAmzomvelebi;
    self.MultiView1.HideMaster; }
  TextMainPageText.Text := v_Ini.ReadString('notification', 'action', '') + '/' + v_Ini.ReadString('notification', 'app_id', '') + '/' +
    v_Ini.ReadString('notification', 'user_id', '');
end;

procedure TMainForm.Button3Click(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItemUserArea;
  self.MultiView1.HideMaster;
end;

procedure TMainForm.Button4Click(Sender: TObject);
begin
  self.MultiView1.HideMaster;
  with TAppListForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ChangeTabActionRightUpdate(Sender: TObject);
begin
  if TabControl2.TabIndex > 0 then
    ChangeTabActionLeft.Tab := TabControl2.Tabs[TabControl2.TabIndex - 1]
  else
    ChangeTabActionLeft.Tab := nil;
end;

procedure TMainForm.ChangeTabActionLeftUpdate(Sender: TObject);
begin
  if TabControl2.TabIndex < TabControl2.TabCount - 1 then
    ChangeTabActionRight.Tab := TabControl2.Tabs[TabControl2.TabIndex + 1]
  else
    ChangeTabActionRight.Tab := nil;
end;

procedure TMainForm.Rectangle1Click(Sender: TObject);
begin
  TabControl1.ActiveTab := TabItemAmzomvelebi;
end;

procedure TMainForm.RectangleAppsClick(Sender: TObject);
begin
  with TAppListForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.RESTRequestSignOutAfterExecute(Sender: TCustomRESTRequest);
begin
  RectangleProfile.Visible := False;
  RectangleNonAuth.Visible := True;
  DModule.SignOut;
  self.clearINIParams;
end;

procedure TMainForm.RESTRequestVersioningAfterExecute(Sender: TCustomRESTRequest);
begin
  { action := FDMemTableInit.FieldByName('action').AsInteger;
    msg := FDMemTableInit.FieldByName('msg').AsString;
    if action = 1 then
    begin
    ShowMessage(msg);
    self.Close;
    end;
    if FDMemTableInit.FieldByName('user.loginstatus').AsInteger = 1 then
    begin
    DModule.id := FDMemTableInit.FieldByName('user.id').Value.ToInteger;
    DModule.full_name := FDMemTableInit.FieldByName('user.full_name').AsString;
    DModule.phone := FDMemTableInit.FieldByName('user.phone').AsString;
    DModule.email := FDMemTableInit.FieldByName('user.email').AsString;
    DModule.sesskey := FDMemTableInit.FieldByName('user.sesskey').AsString;
    self.DoAuthenticate;
    end
    else
    self.clearINIParams;
    FPushClient := TPushClient.Create;
    FPushClient.GCMAppID := FDMemTableInit.FieldByName('Azomva_GCMAppID').AsString; // '1072986242571';
    FPushClient.ServerKey := FDMemTableInit.FieldByName('Azomva_Legacy_server_key').AsString;
    // 'AAAA-dL2vgs:APA91bHselPykPJp2XxIRxe4mmUhR5G_onOl0a1bPLS_zGaertyAxYuKMXEAPFHnHiwr7GmZEyO7fXux8jka_9sYo1DtCENhk8X7wvPA8CxCl9uJlQuBHukNtjgtMJidSi_xoBeYJZ1W';
    FPushClient.BundleID := ''; // cFCMBundleID;
    FPushClient.UseSandbox := True; // Change this to False for production use!
    FPushClient.OnChange := PushClientChangeHandler;
    FPushClient.OnReceiveNotification := PushClientReceiveNotificationHandler;
    self.PreloaderRectangle.Visible := False; }
  self.showConnectionIsOnline;
  TimerInitActivation.Enabled := True;
end;

procedure TMainForm.TimerInitActivationTimer(Sender: TObject);
begin
  self.TimerInitActivation.Enabled := False;
  self.checkVersion;
end;

procedure TMainForm.TimerVersioningTimer(Sender: TObject);
var
  aTask: ITask;
begin
  TimerVersioning.Enabled := False;
  // aTask := TTask.Create(
  // procedure()
  // begin
  RESTRequestVersioning.Params.Clear;
  RESTRequestVersioning.AddParameter('version', DModule.currentVersion);
  if self.v_Ini.ReadString('auth', 'hash', '').IsEmpty = False then
  begin
    RESTRequestVersioning.AddParameter('op', 'login_with_hash');
    RESTRequestVersioning.AddParameter('hash', self.v_Ini.ReadString('auth', 'hash', ''));
    RESTRequestVersioning.AddParameter('phone', self.v_Ini.ReadString('auth', 'phone', ''));
    RESTRequestVersioning.AddParameter('email', self.v_Ini.ReadString('auth', 'email', ''));
  end;
  try
    RESTRequestVersioning.Execute;
  except
    on E: Exception do
    begin
      self.showConnectionIsOffline;
    end;
  end;
  // end);
  // aTask.Start;
end;

procedure TMainForm.User2ListFrame1Button1Click(Sender: TObject);
begin
  // PreloaderRectangle.Visible := True;
  User2ListFrame1.Button1Click(Sender);
end;

procedure TMainForm.checkVersion;
var
  msg: string;
  Action: Integer;
  helper: THelperUnit;
begin
  Action := FDMemTableInit.FieldByName('action').AsInteger;
  msg := FDMemTableInit.FieldByName('msg').AsString;
  if Action = 1 then
  begin
    ShowMessage(msg);
    self.Close;
  end;

  FPushClient := TPushClient.Create;
  FPushClient.GCMAppID := FDMemTableInit.FieldByName('Azomva_GCMAppID').AsString; // '1072986242571';
  FPushClient.ServerKey := FDMemTableInit.FieldByName('Azomva_Legacy_server_key').AsString;
  // 'AAAA-dL2vgs:APA91bHselPykPJp2XxIRxe4mmUhR5G_onOl0a1bPLS_zGaertyAxYuKMXEAPFHnHiwr7GmZEyO7fXux8jka_9sYo1DtCENhk8X7wvPA8CxCl9uJlQuBHukNtjgtMJidSi_xoBeYJZ1W';
  FPushClient.BundleID := ''; // cFCMBundleID;
  FPushClient.UseSandbox := True; // Change this to False for production use!
  FPushClient.OnChange := PushClientChangeHandler;
  FPushClient.OnReceiveNotification := PushClientReceiveNotificationHandler;

  if FDMemTableInitUser.FieldByName('loginstatus').AsInteger = 1 then
  begin
    DModule.id := FDMemTableInitUser.FieldByName('id').AsInteger;
    DModule.full_name := FDMemTableInitUser.FieldByName('full_name').AsString;
    DModule.phone := FDMemTableInitUser.FieldByName('phone').AsString;
    DModule.email := FDMemTableInitUser.FieldByName('email').AsString;
    DModule.sesskey := FDMemTableInitUser.FieldByName('sesskey').AsString;
    DModule.notifications := FDMemTableInitUser.FieldByName('notifications').AsInteger;
    self.DoAuthenticate;
  end
  else
    self.clearINIParams;
  self.PreloaderRectangle.Visible := False;
  helper := THelperUnit.Create;
  try
    helper.AndroidCheckAndRequestInternetPermission;
  finally
    helper.free;
  end;
end;

procedure TMainForm.clearINIParams;
begin
  self.v_Ini.WriteString('auth', 'hash', '');
  self.v_Ini.WriteString('auth', 'full_name', '');
  self.v_Ini.WriteString('auth', 'phone', '');
  self.v_Ini.WriteString('auth', 'email', '');
  self.v_Ini.WriteString('auth', 'fname', '');
end;

procedure TMainForm.showConnectionIsOffline;
var
  aTask: ITask;
begin
  RectangleConnectionStatus.Visible := True;
  RectangleConnectionStatus.Fill.Color := TAlphaColor($FFFF0000);
  LabelConnectionStatus.Text := 'შეამოწმეთ კავშირი ინტერნეტთან...';
  aTask := TTask.Create(
    procedure()
    begin
      Sleep(3000);
      self.TimerVersioning.Enabled := True;
    end);
  aTask.Start;
end;

procedure TMainForm.showConnectionIsOnline;
var
  aTask: ITask;
begin
  User2ListFrame1.initFrame;
  RectangleConnectionStatus.Fill.Color := TAlphaColor($FF008000);
  LabelConnectionStatus.Text := '';
  aTask := TTask.Create(
    procedure()
    begin
      Sleep(5000);
      RectangleConnectionStatus.Visible := False;
    end);
  aTask.Start;
end;

{
  procedure TMainForm.loginRequest(hash, phone, email: string);
  begin
  PreloaderRectangle.Visible := True;
  end;
}
{$IFDEF IOS}

function TMainForm.getDeviceID: string;
begin
  Result := 'iOS';
end;
{$ENDIF IOS}
{$IFDEF ANDROID}

function TMainForm.getDeviceID: string;
var
  obj: JObject;
  tm: JTelephonyManager;
  identifier: String;
begin
  obj := TANdroidHelper.Context.getSystemService(TJContext.JavaClass.TELEPHONY_SERVICE);
  if obj <> nil then
  begin
    tm := TJTelephonyManager.Wrap((obj as ILocalObject).GetObjectID);
    if tm <> nil then
      identifier := JStringToString(tm.getDeviceID);
  end;
  if identifier = '' then
    identifier := JStringToString(TJSettings_Secure.JavaClass.getString(TANdroidHelper.Activity.getContentResolver,
      TJSettings_Secure.JavaClass.ANDROID_ID));
  Result := identifier;
end;

{
  procedure TMainForm.ServiceAppStart;
  var
  LIntent: JIntent;
  jcomp: JComponentName;
  FService: TLocalServiceConnection;
  LService: string;
  helper: TANdroidHelper;
  begin
  LIntent := TJIntent.Create;
  helper := TANdroidHelper.Create;
  LService := 'com.azomva.com.services.notificationServiceApp';
  LIntent.setClassName(TANdroidHelper.Context.getPackageName(), TANdroidHelper.StringToJString(LService));
  LIntent.putExtra(TANdroidHelper.StringToJString('sesskey'), TANdroidHelper.StringToJString(DModule.sesskey));
  helper.Activity.startService(LIntent);
  end;

  {
  function TMainForm.isServiceStarted: Boolean;
  var
  ActivityServiceManager: JObject;
  FActivityManager: JActivityManager;
  List: JList;
  Iterator: JIterator;
  ri: TJActivityManager;
  s: String;
  begin
  ri := TJActivityManager.Create;
  Result := False;
  ActivityServiceManager := TAndroidHelper.Context.getSystemService(TJContext.JavaClass.ACTIVITY_SERVICE);
  FActivityManager := TJActivityManager.Wrap((ActivityServiceManager as ILocalObject).GetObjectID);
  List := FActivityManager.getRunningServices(MAXINT);
  Iterator := List.Iterator;
  while Iterator.hasNext and (not Result) do
  begin
  ri := TJActivityManager.Wrap((Iterator.next as ILocalObject).GetObjectID);
  s := ri.ClassName;
  Result := (s = 'com.embarcadero.services.azomvabgservice');
  end;
  end;
}
{$ENDIF ANDROID}

end.
