unit serviceUnit;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Android.Service,
  AndroidApi.JNI.GraphicsContentViewText,
  AndroidApi.JNI.Os,
  IPPeerClient, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, System.Notification, DateUtils,
  AndroidApi.JNI,
  AndroidApi.JNI.App,
  AndroidApi.Helpers,
  AndroidApi.JNIBridge,
  AndroidApi.JNI.JavaTypes,
  FMX.Types;

type
  TDM = class(TAndroidService)
    RESTClient1: TRESTClient;
    RESTRequestCheckNotification: TRESTRequest;
    RESTResponseCheckNotification: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTableNotifications: TFDMemTable;
    FDMemTableNotificationsid: TWideStringField;
    FDMemTableNotificationsnotification_type_id: TWideStringField;
    FDMemTableNotificationstitle: TWideStringField;
    FDMemTableNotificationsdescription: TWideStringField;
    FDMemTableNotificationsfire_time: TWideStringField;
    FDMemTableNotificationsexecuted: TWideStringField;
    FDMemTableNotificationsaction_id: TWideStringField;
    FDMemTableNotificationscreate_date: TWideStringField;
    FDMemTableNotificationsexecuted_date: TWideStringField;
    FDMemTableNotificationsnotification_type_name: TWideStringField;
    NotificationCenter1: TNotificationCenter;
    Timer1: TTimer;
    function AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDM }

function TDM.AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
var
  sesskey: String;
begin
  sesskey := TAndroidHelper.JStringToString(Intent.getStringExtra(TAndroidHelper.StringToJString('sesskey')));
  Result := TJService.JavaClass.START_FLAG_RETRY;
end;

end.
