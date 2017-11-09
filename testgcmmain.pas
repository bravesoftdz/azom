unit testgcmmain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.StdCtrls, FMX.Layouts, FMX.Memo, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL,
  gcmnotification, FMX.ScrollBox, FMX.Controls.Presentation;

type
  TFormHelper = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    gcmn: TGCMNotification;
    procedure OnNotification(Sender: TObject; ANotification: TGCMNotificationMessage);
  end;

const
  YOUR_GCM_SENDERID = '815410072521';
  YOUR_API_ID = 'azomvacom-1505748455991';

var
  FormHelper: TFormHelper;

implementation

{$R *.fmx}

procedure TFormHelper.Button1Click(Sender: TObject);
begin
  gcmn.SenderID := YOUR_GCM_SENDERID;
  if gcmn.DoRegister then
    Memo1.Lines.Add('Successfully registered with GCM.');
end;

procedure TFormHelper.Button2Click(Sender: TObject);
const
  sendUrl = 'https://android.googleapis.com/gcm/send';
var
  Params: TStringList;
  AuthHeader: STring;
  IdHTTP: TIDHTTP;
  SSLIOHandler: TIdSSLIOHandlerSocketOpenSSL;
begin
  IdHTTP := TIDHTTP.Create(nil);
  try
    SSLIOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHTTP.IOHandler := SSLIOHandler;
    IdHTTP.HTTPOptions := [];
    Params := TStringList.Create;
    try
      Params.Add('registration_id=' + gcmn.RegistrationID);
      Params.Values['data.message'] := 'test: ' + FormatDateTime('yy-mm-dd hh:nn:ss', Now);
      IdHTTP.Request.Host := sendUrl;
      AuthHeader := 'Authorization: key=' + YOUR_API_ID;
      IdHTTP.Request.CustomHeaders.Add(AuthHeader);
      IdHTTP.Request.ContentType := 'application/x-www-form-urlencoded;charset=UTF-8';
      Memo1.Lines.Add('Send result: ' + IdHTTP.Post(sendUrl, Params));
    finally
      Params.Free;
    end;
  finally
    IdHTTP.Free;;
  end;
end;

procedure TFormHelper.FormCreate(Sender: TObject);
begin
  gcmn := TGCMNotification.Create(self);
  gcmn.OnReceiveGCMNotification := OnNotification;
end;

procedure TFormHelper.FormDestroy(Sender: TObject);
begin
  FreeAndNil(gcmn);
end;

procedure TFormHelper.OnNotification(Sender: TObject; ANotification: TGCMNotificationMessage);
begin
  Memo1.Lines.Add('Received: ' + ANotification.Body);
end;

end.
