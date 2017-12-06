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
  FMX.ScrollBox, FMX.Memo
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
    Rectangle8: TRectangle;
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
    AniIndicator2: TAniIndicator;
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
    FDMemTableInitaction: TWideStringField;
    FDMemTableInitmsg: TWideStringField;
    FDMemTableInitpages: TWideStringField;
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
    Button2: TButton;
    ActionReg: TAction;
    ButtonLocationsConfig: TButton;
    ActionUserNotifications: TAction;
    Label1: TLabel;
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
    procedure Rectangle8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OnReceiveNotificationEvent(Sender: TObject; const ANotification: TPushServiceNotification);
    procedure ActionRegExecute(Sender: TObject);
    procedure ButtonLocationsConfigClick(Sender: TObject);
    procedure ActionUserNotificationsExecute(Sender: TObject);
  private
{$IFDEF ANDROID}
    procedure ServiceAppStart;
    // function isServiceStarted: Boolean;
{$ENDIF ANDROID}
    procedure checkVersion;
    procedure OnServiceConnectionChange(Sender: TObject; AChange: TPushService.TChanges);
    // function isServiceStarted: Boolean;

    { Private declarations }
  public
    { Public declarations }
    procedure DoAuthenticate;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.fmx}

uses auth, DataModule, AddApp, MyApps, UserArea, AppList, UserRegistration,
  UserLocations, UserNotifications;
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
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  self.PreloaderRectangle.Visible := True;
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

procedure TMainForm.ActionMyAppsExecute(Sender: TObject);
begin
  with TFormMyApps.Create(Application) do
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

procedure TMainForm.ButtonLocationsConfigClick(Sender: TObject);
begin
  with TUserLocationsForm.Create(Application) do
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

procedure TMainForm.Rectangle8Click(Sender: TObject);
var
  aTask: ITask;
begin
{$IF ANDROID}
  { aTask := TTask.Create(
    procedure()
    begin
    TThread.Synchronize(nil,
    procedure
    const
    Senderid: String = '815410072521';
    var
    DeviceId, Token: String;
    XPushService: TPushService;
    XPushConnection: TPushServiceConnection;
    begin
    XPushService := TPushServiceManager.Instance.GetServiceByName(TPushService.TServiceNames.GCM);
    XPushService.AppProps[TPushService.TAppPropNames.GCMAppID] := Senderid;

    XPushConnection := TPushServiceConnection.Create(XPushService);
    XPushConnection.Active := True;
    XPushConnection.OnChange := OnServiceConnectionChange;
    XPushConnection.OnReceiveNotification := OnReceiveNotificationEvent;

    DeviceId := XPushService.DeviceIDValue[TPushService.TDeviceIDNames.DeviceId];
    Token := XPushService.DeviceTokenValue[TPushService.TDeviceTokenNames.DeviceToken];
    Memo1.Lines.Add('DeviceId:' + DeviceId);
    Memo1.Lines.Add('Token:' + Token);
    Memo1.Lines.Add('ServiceName:' + XPushService.ServiceName);

    end);
    end);
    aTask.Start;
    exit; }
{$ENDIF ANDROID}
  with TAppListForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TMainForm.OnServiceConnectionChange(Sender: TObject; AChange: TPushService.TChanges);
begin
  //
end;

procedure TMainForm.OnReceiveNotificationEvent(Sender: TObject; const ANotification: TPushServiceNotification);
var
  MyNotification: TNotification;
  NotificationCenter: TNotificationCenter;
  BadgeNumber: integer;
begin
  MyNotification := TNotification.Create;
  NotificationCenter := TNotificationCenter.Create(nil);
  try
    MyNotification.Name := 'PushEvents1PushReceived';
    MyNotification.AlertBody := ANotification.ToString;
    MyNotification.EnableSound := True;
    // MyNotification.Number := BadgeNumber;
    // NotificationCenter.ApplicationIconBadgeNumber := BadgeNumber;
    NotificationCenter.PresentNotification(MyNotification);
  finally
    NotificationCenter.Free;
    MyNotification.Free;
  end;
  {
    Memo1.Lines.Add('Data Key = ' + ANotification.DataKey);
    Memo1.Lines.Add('JSON = ' + ANotification.JSON.ToString);
    Memo1.Lines.Add('Data Objetct = ' + ANotification.DataObject.ToString);
  }
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
          ServiceAppStart;
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
  jsonObject := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(self.RESTResponseVersioning.Content), 0) as TJSONObject;
  action := jsonObject.GetValue('action').Value.ToInteger;
  msg := jsonObject.GetValue('msg').Value;
  if action = 1 then
  begin
    ShowMessage(msg);
    self.Close;
  end;
  LabelTotalAppsCount.Text := jsonObject.GetValue('total_apps_count').Value;
  LabelWeekApps.Text := jsonObject.GetValue('week_apps_count').Value;
end;

{$IFDEF ANDROID}

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

initialization

finalization

Ini.Free;

end.
