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
  Inifiles
{$IFDEF ANDROID}
    , FMX.PushNotification.Android,
  Androidapi.JNI.App,
  Androidapi.JNI.GraphicsContentViewText,
  Androidapi.JNI.Os,
  Androidapi.Helpers,
  System.Android.Service,
  Androidapi.JNIBridge,
  Androidapi.JNI.JavaTypes,
  Androidapi.JNI.PlayServices, FMX.Header
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
    TabItem1: TTabItem;
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
    Text1: TText;
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
    LinkPropertyToFieldText: TLinkPropertyToField;
    Circle2: TCircle;
    LabelWeekApps: TLabel;
    Rectangle1: TRectangle;
    ImageList1: TImageList;
    RectangleHeader: TRectangle;
    LabelFullName: TLabel;
    Button1: TButton;
    RectangleMainHeader: TRectangle;
    ButtonMasterView: TButton;
    ActionReg: TAction;
    ButtonLocationsConfig: TButton;
    ActionUserNotifications: TAction;
    Label1: TLabel;
    FDMemTableInitaction: TWideStringField;
    FDMemTableInittotal_apps_count: TWideStringField;
    FDMemTableInitweek_apps_count: TWideStringField;
    FDMemTableInitmsg: TWideStringField;
    FDMemTableInitpages: TWideStringField;
    FDMemTableInitapp_name: TWideStringField;
    BindSourceDB2: TBindSourceDB;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    LabelApps: TLabel;
    ButtonServiceTypes: TButton;
    ActionServiceTypes: TAction;
    ActionLocationsConfig: TAction;
    MultiView1: TMultiView;
    Button2: TButton;
    RESTRequestDeviceToken: TRESTRequest;
    NotificationCenter1: TNotificationCenter;
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
    FDMemTableAuthnotifications: TWideStringField;
    RESTResponseDataSetAdapterAuth: TRESTResponseDataSetAdapter;
    RESTResponseAuth: TRESTResponse;
    RESTRequestAuth: TRESTRequest;
    LabelLoading: TLabel;
    ProgressBar1: TProgressBar;
    FloatAnimationPreloader: TFloatAnimation;
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
    // procedure OnReceiveNotificationEvent(Sender: TObject; const ANotification: TPushServiceNotification);
    procedure ActionRegExecute(Sender: TObject);
    procedure ActionUserNotificationsExecute(Sender: TObject);
    procedure ActionServiceTypesExecute(Sender: TObject);
    procedure ActionLocationsConfigExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RESTRequestAuthAfterExecute(Sender: TCustomRESTRequest);
  private
    procedure PushClientChangeHandler(Sender: TObject; AChange: TPushService.TChanges);
    procedure PushClientReceiveNotificationHandler(Sender: TObject; const ANotification: TPushServiceNotification);
{$IFDEF ANDROID}
    // procedure ServiceAppStart;
    // function isServiceStarted: Boolean;
{$ENDIF ANDROID}
    procedure checkVersion;
    procedure checkUserAuth;
    procedure loginRequest(hash, phone: string);
    // procedure OnServiceConnectionChange(Sender: TObject; AChange: TPushService.TChanges);
    // function isServiceStarted: Boolean;

    { Private declarations }
  public
    { Public declarations }
    FPushClient: TPushClient;
    procedure DoAuthenticate;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses auth, DataModule, AddApp, MyApps, UserArea, AppList, UserRegistration,
  UserLocations, UserNotifications, UserServiceTypes;
// {$IFDEF ANDROID}, testgcmmain{$ENDIF ANDROID};

procedure TMainForm.DoAuthenticate;
begin
  self.RectangleNonAuth.Visible := False;
  LabelFullName.Text := DModule.fname + ' ' + DModule.lname;
  ButtonUserNotifications.Text := '(' + DModule.notifications.ToString + ') შეტყობინებები';
  self.RectangleProfile.Visible := True;
  if DModule.user_type_id = 2 then
  begin
    ButtonAddApp.Visible := False;
    ButtonLocationsConfig.Visible := True;
  end
  else
  begin
    ButtonAddApp.Visible := True;
    ButtonLocationsConfig.Visible := False;
  end;
  FPushClient.Active := True;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  self.PreloaderRectangle.Visible := True;
  FPushClient := TPushClient.Create;
  FPushClient.GCMAppID := '1072986242571';
  FPushClient.ServerKey :=
    'AAAA-dL2vgs:APA91bHselPykPJp2XxIRxe4mmUhR5G_onOl0a1bPLS_zGaertyAxYuKMXEAPFHnHiwr7GmZEyO7fXux8jka_9sYo1DtCENhk8X7wvPA8CxCl9uJlQuBHukNtjgtMJidSi_xoBeYJZ1W';
  // FPushClient.BundleID := cFCMBundleID;
  FPushClient.UseSandbox := True; // Change this to False for production use!
  FPushClient.OnChange := PushClientChangeHandler;
  FPushClient.OnReceiveNotification := PushClientReceiveNotificationHandler;
end;

procedure TMainForm.PushClientReceiveNotificationHandler(Sender: TObject;
  const ANotification: TPushServiceNotification);
var
  MyNotification: TNotification;
begin
  MyNotification := TNotification.Create;
  try
    MyNotification.Name := ANotification.DataObject.Values['Name'].ToString;
    MyNotification.AlertBody := ANotification.DataObject.Values['AlertBody'].ToString;
    MyNotification.EnableSound := True;
    MyNotification.Number := 18;
    NotificationCenter1.ApplicationIconBadgeNumber := MyNotification.Number;
    NotificationCenter1.PresentNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
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
            with RESTRequestDeviceToken.Params.AddItem do
            begin
              name := 'deviceid';
              Value := FPushClient.DeviceID;
            end;
            with RESTRequestDeviceToken.Params.AddItem do
            begin
              name := 'devicetoken';
              Value := TIdURI.ParamsEncode(FPushClient.DeviceToken);
            end;
            with RESTRequestDeviceToken.Params.AddItem do
            begin
              name := 'sesskey';
              Value := DModule.sesskey;
            end;
            with RESTRequestDeviceToken.Params.AddItem do
            begin
              name := 'user_id';
              Value := DModule.id.ToString;
            end;
            RESTRequestDeviceToken.Execute;
          end);
      end);
    aTask.Start;
  end;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  FPushClient.Free;
end;

procedure TMainForm.ActionRegExecute(Sender: TObject);
begin
  with TRegForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionAppAddingExecute(Sender: TObject);
begin
  with TFormAddApp.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionLocationsConfigExecute(Sender: TObject);
begin
  with TUserLocationsForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionMyAppsExecute(Sender: TObject);
begin
  with TFormMyApps.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.ActionServiceTypesExecute(Sender: TObject);
begin
  with TUserServiceTypesForm.Create(Application) do
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
          with RESTRequestSignOut.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestSignOut.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
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

procedure TMainForm.RectangleAppsClick(Sender: TObject);
var
  aTask: ITask;
begin
  with TAppListForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.RESTRequestAuthAfterExecute(Sender: TCustomRESTRequest);
begin
  PreloaderRectangle.Visible := False;
  self.DoAuthenticate;
end;

procedure TMainForm.RESTRequestSignOutAfterExecute(Sender: TCustomRESTRequest);
var
  I: integer;
begin
  RectangleProfile.Visible := False;
  RectangleNonAuth.Visible := True;
  DModule.SignOut;
  { for I := 0 to Application.ComponentCount do
    begin
    if Application.Components[I] is TForm then
    begin
    if TForm(Application.Components[I]).Name <> self.Name then
    TForm(Application.Components[I]).Close;
    end;
    end; }
end;

procedure TMainForm.RESTRequestVersioningAfterExecute(Sender: TCustomRESTRequest);
begin
  self.PreloaderRectangle.Visible := False;
  self.checkVersion;
end;

procedure TMainForm.TimerVersioningTimer(Sender: TObject);
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
          RESTRequestVersioning.Params.Clear;
          with RESTRequestVersioning.Params.AddItem do
          begin
            name := 'version';
            Value := DModule.currentVersion;
          end;
          RESTRequestVersioning.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TMainForm.checkVersion;

var
  jsonObject, PagesJsonObject: TJSONObject;
  msg: string;
  action: integer;
begin
  jsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(self.RESTResponseVersioning.Content), 0)
    as TJSONObject;
  action := jsonObject.GetValue('action').Value.ToInteger;
  msg := jsonObject.GetValue('msg').Value;
  if action = 1 then
  begin
    ShowMessage(msg);
    self.Close;
  end;
  // LabelTotalAppsCount.Text := jsonObject.GetValue('total_apps_count').Value;
  // LabelWeekApps.Text := jsonObject.GetValue('week_apps_count').Value;
  FPushClient.GCMAppID := jsonObject.GetValue('GCMAppID').Value;
  FPushClient.ServerKey := jsonObject.GetValue('GCMServerKey').Value;
  self.checkUserAuth;
end;

procedure TMainForm.checkUserAuth;
var
  Ini: TMemIniFile;
begin
  Ini := TMemIniFile.Create(TPath.Combine(TPath.GetDocumentsPath, 'AzomvaSettings.ini'));
  Ini.AutoSave := True;
  // ShowMessage(Ini.ReadString('auth', 'hash', ''));
  // ShowMessage(TPath.GetDocumentsPath + PathDelim + 'AzomvaSettings.ini');
  if Ini.ReadString('auth', 'hash', '').IsEmpty = False then
  begin
    DModule.id := Ini.ReadString('auth', 'hash', '').ToInteger;
    DModule.user_type_id := Ini.ReadString('auth', 'user_type_id', '').ToInteger;
    DModule.fname := Ini.ReadString('auth', 'fname', '');
    DModule.lname := Ini.ReadString('auth', 'lname', '');
    DModule.phone := Ini.ReadString('auth', 'phone', '');
    DModule.email := Ini.ReadString('auth', 'email', '');
    DModule.sesskey := Ini.ReadString('auth', 'sesskey', '');
    //ShowMessage(Ini.ReadString('auth', 'sesskey', ''));
    self.loginRequest(Ini.ReadString('auth', 'sesskey', ''), Ini.ReadString('auth', 'phone', ''));
  end
  else
    DModule.SignOut;
end;

procedure TMainForm.loginRequest(hash, phone: string);
var
  aTask: ITask;
begin
  PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestAuth.Params.Clear;
          with RESTRequestAuth.Params.AddItem do
          begin
            name := 'op';
            Value := 'login_with_hash';
          end;
          with RESTRequestAuth.Params.AddItem do
          begin
            name := 'hash';
            Value := hash;
          end;
          with RESTRequestAuth.Params.AddItem do
          begin
            name := 'phone';
            Value := phone;
          end;
          RESTRequestAuth.Execute;
        end);
    end);
  aTask.Start;
end;

{$IFDEF ANDROID}
{
  procedure TMainForm.ServiceAppStart;
  var
  LIntent: JIntent;
  jcomp: JComponentName;
  FService: TLocalServiceConnection;
  LService: string;
  helper: TAndroidHelper;
  begin
  LIntent := TJIntent.Create;
  helper := TAndroidHelper.Create;
  LService := 'com.azomva.com.services.azomvabgservice';
  LIntent.setClassName(TAndroidHelper.Context.getPackageName(), TAndroidHelper.StringToJString(LService));
  LIntent.putExtra(TAndroidHelper.StringToJString('sesskey'), TAndroidHelper.StringToJString(DModule.sesskey));
  helper.Activity.startService(LIntent);
  end;
}
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
// initialization

// finalization

// Ini.Free;

end.
