unit AppList;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  REST.Client, Data.Bind.ObjectScope, REST.Response.Adapter, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, Data.Bind.Components,
  Data.Bind.DBScope, FMX.StdCtrls, FMX.Objects, FMX.ListView,
  FMX.Controls.Presentation, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Threading;

type
  TAppListForm = class(TForm)
    ListView1: TListView;
    PreloaderRectangle: TRectangle;
    AniIndicator1: TAniIndicator;
    BindSourceDB1: TBindSourceDB;
    FDMemTableApps: TFDMemTable;
    FDMemTableAppsid: TWideStringField;
    FDMemTableAppsuser_id: TWideStringField;
    FDMemTableAppsapp_service_type_id: TWideStringField;
    FDMemTableAppsapp_service_type_name: TWideStringField;
    FDMemTableAppsapp_property_type_id: TWideStringField;
    FDMemTableAppsapp_property_type_name: TWideStringField;
    FDMemTableAppscreate_date: TWideStringField;
    FDMemTableAppsdeadlineby_user: TWideStringField;
    FDMemTableAppsimageIndex: TWideStringField;
    RESTResponseDataSetAdapterApps: TRESTResponseDataSetAdapter;
    RESTResponseApps: TRESTResponse;
    RESTRequestApps: TRESTRequest;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure RESTRequestAppsAfterExecute(Sender: TCustomRESTRequest);
  private
    procedure reloadItems;
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  AppListForm: TAppListForm;

implementation

{$R *.fmx}

uses DataModule, AppDetails;

{ TAppListForm }

procedure TAppListForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TAppListForm.initForm;
begin
  self.Show;
  PreloaderRectangle.Visible := True;
  self.reloadItems;
end;

procedure TAppListForm.reloadItems;
var
  aTask: ITask;
begin
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestApps.Params.Clear;
          with RESTRequestApps.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestApps.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          RESTRequestApps.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TAppListForm.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  with TAppDetailForm.Create(Application) do
  begin
    initForm(FDMemTableApps.FieldByName('id').AsInteger);
  end;
end;

procedure TAppListForm.ListView1PullRefresh(Sender: TObject);
begin
  self.ListView1.PullRefreshWait := True;
  self.reloadItems;
end;

procedure TAppListForm.RESTRequestAppsAfterExecute(Sender: TCustomRESTRequest);
begin
  self.ListView1.PullRefreshWait := False;
  PreloaderRectangle.Visible := False;
end;

end.
