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
    NotificationCenter1: TNotificationCenter;
    function AndroidServiceStartCommand(const Sender: TObject; const Intent: JIntent; Flags, StartId: Integer): Integer;
    procedure NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
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
begin
  // get string := TAndroidHelper.JStringToString(Intent.getStringExtra(TAndroidHelper.StringToJString('sesskey')));
  Result := TJService.JavaClass.START_FLAG_RETRY;
end;

procedure TDM.NotificationCenter1ReceiveLocalNotification(Sender: TObject; ANotification: TNotification);
var
  MyNotification: TNotification;
begin
  MyNotification := NotificationCenter1.CreateNotification;
  try
    MyNotification.Name := ANotification.Name;
    MyNotification.AlertBody := ANotification.AlertBody;
    MyNotification.EnableSound := True;
    MyNotification.FireDate := Now;
    NotificationCenter1.ScheduleNotification(MyNotification);
  finally
    MyNotification.Free;
  end;
end;

end.
