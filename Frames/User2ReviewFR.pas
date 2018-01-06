unit User2ReviewFR;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Header, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Layouts, FMX.LoadingIndicator, FMX.Controls.Presentation, FMX.Objects, Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, FMX.TMSRatingGrid, FMX.TMSBaseControl, FMX.TMSGauge,
  FMX.RatingBar, FMX.TMSRating, Data.Bind.GenData, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors;

type
  TUser2ReviewFrame = class(TFrame)
    ListView1: TListView;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    RectanglePreloader: TRectangle;
    LabelAppName: TLabel;
    RESTRequest1: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTable1: TFDMemTable;
    TMSFMXRatingGrid1: TTMSFMXRatingGrid;
    PrototypeBindSource1: TPrototypeBindSource;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initFrame;
  end;

implementation

{$R *.fmx}

uses DataModule;
{ TUser2ReviewFrame }

procedure TUser2ReviewFrame.initFrame;
begin
  self.RectanglePreloader.Visible := True;
end;

end.
