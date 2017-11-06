unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, IPPeerClient,
  REST.Backend.PushTypes, REST.Backend.KinveyPushDevice, System.JSON,
  System.PushNotification, REST.Backend.KinveyProvider, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Backend.BindSource, REST.Backend.PushDevice,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TForm2 = class(TForm)
    PushEvents1: TPushEvents;
    KinveyProvider1: TKinveyProvider;
    Memo1: TMemo;
    procedure PushEvents1DeviceRegistered(Sender: TObject);
    procedure PushEvents1DeviceTokenReceived(Sender: TObject);
    procedure PushEvents1DeviceTokenRequestFailed(Sender: TObject; const AErrorMessage: string);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.PushEvents1DeviceRegistered(Sender: TObject);
begin
  Memo1.Lines.Add('PushEvents1DeviceRegistered');
end;

procedure TForm2.PushEvents1DeviceTokenReceived(Sender: TObject);
begin
  Memo1.Lines.Add('PushEvents1DeviceTokenReceived');
end;

procedure TForm2.PushEvents1DeviceTokenRequestFailed(Sender: TObject; const AErrorMessage: string);
begin
  Memo1.Lines.Add(AErrorMessage);
end;

end.
