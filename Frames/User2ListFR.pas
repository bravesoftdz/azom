unit User2ListFR;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls, Header, FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, FMX.ListView, FMX.Layouts, FMX.LoadingIndicator, FMX.Controls.Presentation, FMX.Objects,
  Data.Bind.Components,
  Data.Bind.ObjectScope, REST.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, FMX.TMSRatingGrid,
  FMX.TMSBaseControl, FMX.TMSGauge,
  FMX.RatingBar, FMX.TMSRating, Data.Bind.GenData, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.DBScope, System.Threading;

type
  TUser2ListFrame = class(TFrame)
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    RectanglePreloader: TRectangle;
    LabelAppName: TLabel;
    RESTRequestAmzomvelebi: TRESTRequest;
    RESTResponse1: TRESTResponse;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTableAmzomvelebi: TFDMemTable;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    ListView2: TListView;
    LinkListControlToField2: TLinkListControlToField;
    RectangleMain: TRectangle;
    FDMemTableAmzomvelebiid: TWideStringField;
    FDMemTableAmzomvelebiuser_type_id: TWideStringField;
    FDMemTableAmzomvelebiuser_status_id: TWideStringField;
    FDMemTableAmzomvelebirating: TWideStringField;
    FDMemTableAmzomvelebifname: TWideStringField;
    FDMemTableAmzomvelebilname: TWideStringField;
    FDMemTableAmzomvelebiphone: TWideStringField;
    FDMemTableAmzomvelebiemail: TWideStringField;
    FDMemTableAmzomvelebicreate_date: TWideStringField;
    FDMemTableAmzomvelebimodify_date: TWideStringField;
    FDMemTableAmzomvelebiregipaddr: TWideStringField;
    FDMemTableAmzomvelebifull_name: TWideStringField;
    FDMemTableAmzomvelebicontact_info: TWideStringField;
    Button1: TButton;
    PanelDetails: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure RESTRequestAmzomvelebiAfterExecute(Sender: TCustomRESTRequest);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initFrame;
  end;

implementation

{$R *.fmx}

uses DataModule, Main;
{ TUser2ReviewFrame }

procedure TUser2ListFrame.Button1Click(Sender: TObject);
var
  aTask: ITask;
begin
  self.Show;
  self.RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestAmzomvelebi.Params.Clear;
          with RESTRequestAmzomvelebi.Params.AddItem do
          begin
            name := 'sort';
            Value := 'stars';
          end;
          if DModule.sesskey.IsEmpty = False then
          begin
            with RESTRequestAmzomvelebi.Params.AddItem do
            begin
              name := 'sesskey';
              Value := DModule.sesskey;
            end;
            with RESTRequestAmzomvelebi.Params.AddItem do
            begin
              name := 'user_id';
              Value := DModule.id.ToString;
            end;
          end;
          self.RESTRequestAmzomvelebi.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUser2ListFrame.initFrame;
var
  aTask: ITask;
begin
  self.Show;
  self.RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestAmzomvelebi.Params.Clear;
          if DModule.sesskey.IsEmpty = False then
          begin
            with RESTRequestAmzomvelebi.Params.AddItem do
            begin
              name := 'sesskey';
              Value := DModule.sesskey;
            end;
            with RESTRequestAmzomvelebi.Params.AddItem do
            begin
              name := 'user_id';
              Value := DModule.id.ToString;
            end;
          end;
          self.RESTRequestAmzomvelebi.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUser2ListFrame.RESTRequestAmzomvelebiAfterExecute(Sender: TCustomRESTRequest);
begin
  self.RectanglePreloader.Visible := False;
end;

end.
