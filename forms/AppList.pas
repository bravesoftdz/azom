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
  FMX.MultiView, FMX.Layouts, FMX.ListBox;

type
  TAppListForm = class(TForm)
    ListView1: TListView;
    PreloaderRectangle: TRectangle;
    AniIndicator1: TAniIndicator;
    BindSourceDB1: TBindSourceDB;
    FDMemTableApps: TFDMemTable;
    RESTResponseDataSetAdapterApps: TRESTResponseDataSetAdapter;
    RESTResponseApps: TRESTResponse;
    RESTRequestApps: TRESTRequest;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    BindingsList1: TBindingsList;
    MultiView1: TMultiView;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    LinkListControlToField1: TLinkListControlToField;
    Label1: TLabel;
    ButtonSorting: TButton;
    RectangleMain: TRectangle;
    FDMemTableAppsid: TWideStringField;
    FDMemTableAppsuser_id: TWideStringField;
    FDMemTableAppsapp_service_type_id: TWideStringField;
    FDMemTableAppsapp_service_type_name: TWideStringField;
    FDMemTableAppsapp_property_type_id: TWideStringField;
    FDMemTableAppsapp_property_type_name: TWideStringField;
    FDMemTableAppscreate_date: TWideStringField;
    FDMemTableAppsdeadlineby_user: TWideStringField;
    FDMemTableAppsimageIndex: TWideStringField;
    FDMemTableAppsusername: TWideStringField;
    FDMemTableAppsnote: TWideStringField;
    FDMemTableAppsaddress: TWideStringField;
    FDMemTableAppsarea: TWideStringField;
    FDMemTableAppscadcode: TWideStringField;
    FDMemTableAppslocation_id: TWideStringField;
    FDMemTableAppslocation_name: TWideStringField;
    FDMemTableAppslon_lat: TWideStringField;
    FDMemTableAppsstatus_name: TWideStringField;
    FDMemTableAppsstatus_color: TWideStringField;
    FDMemTableAppsstatus_progress: TWideStringField;
    FDMemTableAppsapp_status_id: TWideStringField;
    FDMemTableAppslocation_address: TWideStringField;
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure RESTRequestAppsAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure reloadItems(sort_field, sort: String);
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

procedure TAppListForm.Button1Click(Sender: TObject);
begin

  self.reloadItems('id', 'desc');

  self.MultiView1.HideMaster;
end;

procedure TAppListForm.Button2Click(Sender: TObject);
begin
  self.PreloaderRectangle.Visible := True;
  self.MultiView1.HideMaster;
end;

procedure TAppListForm.Button3Click(Sender: TObject);
begin
  self.PreloaderRectangle.Visible := True;
  self.MultiView1.HideMaster;
end;

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
  self.reloadItems('id', 'desc');
end;

procedure TAppListForm.reloadItems(sort_field, sort: String);
var
  aTask: ITask;
begin
  PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestApps.Params.Clear;
          if not DModule.sesskey.IsEmpty then
          begin
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
          end;
          with RESTRequestApps.Params.AddItem do
          begin
            name := 'sort_field';
            Value := sort_field;
          end;
          with RESTRequestApps.Params.AddItem do
          begin
            name := 'sort';
            Value := sort;
          end;
          RESTRequestApps.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TAppListForm.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  id: integer;
begin
  id := self.FDMemTableApps.FieldByName('id').AsInteger;
  with TAppDetailForm.Create(Application) do
  begin
    initForm(id);
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

end.
