unit map;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Maps,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects;

type
  TmapViewForm = class(TForm)
    MapView1: TMapView;
    ButtonSetCoords: TButton;
    Line1: TLine;
    Line2: TLine;
    Circle1: TCircle;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MapView1MapLongClick(const Position: TMapCoordinate);
    procedure ButtonSetCoordsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Descr: TMapMarkerDescriptor;
    marker: TMapMarker;
    MyPosition: TMapCoordinate;
    procedure initForm;
  end;

var
  mapViewForm: TmapViewForm;

implementation

{$R *.fmx}

uses Main, DataModule;
{ TmapViewForm }

procedure TmapViewForm.ButtonSetCoordsClick(Sender: TObject);
begin
  ShowMessage(MapView1.Location.Zero.Longitude.ToString + ',' + MapView1.Location.Zero.Latitude.ToString);
  // ShowMessage(MapView1.BoundsRect.Longitude.ToString + ',' + MapView1.BoundsRect.Location.Latitude.ToString);
  self.Close;
end;

procedure TmapViewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TmapViewForm.initForm;
begin
  self.Show;
  MapView1.Show;
  // MapView1.Location.Latitude;
  // MapView1.Location.Longitude;
end;

procedure TmapViewForm.MapView1MapLongClick(const Position: TMapCoordinate);
begin
  DModule.MyPosition := Position;
  Descr := TMapMarkerDescriptor.Create(Position, 'არჩეული ადგილი');
  Descr.Icon := MainForm.ImageList1.Bitmap(TSizeF.Create(256, 256), 5);
  Descr.Draggable := True;
  MapView1.AddMarker(Descr);
end;

end.
