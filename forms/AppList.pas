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
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Threading,
  FMX.MultiView, FMX.Layouts, FMX.ListBox, FMX.Ani, FMX.LoadingIndicator;

type
  TAppListForm = class(TForm)
    PreloaderRectangle: TRectangle;
    BindSourceDB1: TBindSourceDB;
    FDMemTableApps: TFDMemTable;
    RESTResponseDataSetAdapterApps: TRESTResponseDataSetAdapter;
    RESTResponseApps: TRESTResponse;
    RESTRequestApps: TRESTRequest;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    BindingsList1: TBindingsList;
    Label1: TLabel;
    ButtonSorting: TButton;
    RectangleMain: TRectangle;
    RESTRequestLists: TRESTRequest;
    RESTResponseLists: TRESTResponse;
    RESTResponseDataSetAdapterLists: TRESTResponseDataSetAdapter;
    FDMemTableLocations: TFDMemTable;
    FDMemTableLocationsid: TWideStringField;
    FDMemTableLocationspid: TWideStringField;
    FDMemTableLocationstitle: TWideStringField;
    FDMemTableLocationsmap_title: TWideStringField;
    FDMemTableLocationschildren: TWideStringField;
    BindSourceDB2: TBindSourceDB;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
    FDMemTableAppsid: TWideStringField;
    FDMemTableAppsuser_id: TWideStringField;
    FDMemTableAppsdeadlineby_user: TWideStringField;
    FDMemTableAppsexecute_days: TWideStringField;
    FDMemTableAppsimageIndex: TWideStringField;
    FDMemTableAppsusername: TWideStringField;
    FDMemTableAppsnote: TWideStringField;
    FDMemTableAppsstatus_name: TWideStringField;
    FDMemTableAppsstatus_color: TWideStringField;
    FDMemTableAppsstatus_progress: TWideStringField;
    FDMemTableAppsapp_status_id: TWideStringField;
    FDMemTableAppsnotification_on_email: TWideStringField;
    FDMemTableAppsnotification_on_device: TWideStringField;
    FDMemTableAppscreate_date: TWideStringField;
    FDMemTableAppsapp_property_requisites: TWideStringField;
    FDMemTableAppslocation: TWideStringField;
    FDMemTableAppsarea: TWideStringField;
    FDMemTableAppsapp_property_requisites_count: TWideStringField;
    FDMemTableAppsdropdownarrow_imageindex: TWideStringField;
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure RESTRequestAppsAfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
    procedure ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
      const ItemObject: TListItemDrawable);
    procedure ButtonCloseObjectDetailsClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    procedure reloadItems(sort_field, sort: String; loadOnlyMyApps: boolean = False);
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  AppListForm: TAppListForm;

implementation

{$R *.fmx}

uses DataModule, AppDetails, Main;

{ TAppListForm }

procedure TAppListForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppListForm.ButtonCloseObjectDetailsClick(Sender: TObject);
begin
  //RectangleObjectsDetails.Visible := False;
end;

procedure TAppListForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TAppListForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 137 then
    self.Free;
end;

procedure TAppListForm.initForm;
var
  aTask: ITask;
begin
  self.Show;
  PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      self.RESTRequestLists.Execute;
    end);
  aTask.Start;
end;

procedure TAppListForm.reloadItems(sort_field, sort: String; loadOnlyMyApps: boolean = False);
var
  aTask: ITask;
begin
  PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      RESTRequestApps.Params.Clear;
      if not DModule.sesskey.IsEmpty then
      begin
        RESTRequestApps.AddParameter('sesskey', DModule.sesskey);
        RESTRequestApps.AddParameter('user_id', DModule.id.ToString);
        if loadOnlyMyApps = True then
          RESTRequestApps.AddParameter('op', 'onlymyapps');
      end;
      RESTRequestApps.AddParameter('sort_field', sort_field);
      RESTRequestApps.AddParameter('sort', sort);
      RESTRequestApps.Execute;
    end);
  aTask.Start;
end;

procedure TAppListForm.ListView1ItemClickEx(const Sender: TObject; ItemIndex: Integer; const LocalClickPos: TPointF;
const ItemObject: TListItemDrawable);
var
  id: Integer;
begin
  if (ItemObject is TListItemText) or (ItemObject is TListItemImage) then
  begin
    if (ItemObject.Name = 'app_property_requisites_count') or (ItemObject.Name = 'ArrowImage') then
    begin
      if ListView1.Selected.Height = 90 then
      begin
        ListView1.Selected.Height := 170;
        TListItem(ListView1.Selected).View.FindDrawable('details').Visible := True;
      end
      else
      begin
        ListView1.Selected.Height := 90;
        TListItem(ListView1.Selected).View.FindDrawable('details').Visible := False;
      end;
    end
    else
    begin
      id := self.FDMemTableApps.FieldByName('id').AsInteger;
      with TAppDetailForm.Create(Application) do
      begin
        initForm(id);
      end;
    end;
  end;
end;

procedure TAppListForm.ListView1PullRefresh(Sender: TObject);
begin
  self.ListView1.PullRefreshWait := True;
  self.reloadItems('', '');
end;

procedure TAppListForm.RESTRequestAppsAfterExecute(Sender: TCustomRESTRequest);
begin
  self.ListView1.PullRefreshWait := False;
  PreloaderRectangle.Visible := False;
end;

procedure TAppListForm.RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
begin
  self.reloadItems('id', 'desc');
end;

end.
