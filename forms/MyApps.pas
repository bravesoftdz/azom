unit MyApps;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.DBScope, FMX.StdCtrls, FMX.Controls.Presentation,
  FMX.Objects, System.Threading, FMX.Ani, FMX.Layouts, FMX.LoadingIndicator;

type
  TFormMyApps = class(TForm)
    RESTRequestMyApps: TRESTRequest;
    RESTResponseMyApps: TRESTResponse;
    RESTResponseDataSetAdapterMyApps: TRESTResponseDataSetAdapter;
    FDMemTableMyApps: TFDMemTable;
    FDMemTableMyAppsid: TWideStringField;
    FDMemTableMyAppsuser_id: TWideStringField;
    FDMemTableMyAppsapp_service_type_id: TWideStringField;
    FDMemTableMyAppsapp_service_type_name: TWideStringField;
    FDMemTableMyAppsapp_property_type_id: TWideStringField;
    FDMemTableMyAppsapp_property_type_name: TWideStringField;
    FDMemTableMyAppscreate_date: TWideStringField;
    FDMemTableMyAppsdeadlineby_user: TWideStringField;
    FDMemTableMyAppsimageIndex: TWideStringField;
    FDMemTableMyAppsusername: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    Label1: TLabel;
    PreloaderRectangle: TRectangle;
    ListView1: TListView;
    LinkListControlToField1: TLinkListControlToField;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure RESTRequestMyAppsAfterExecute(Sender: TCustomRESTRequest);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  FormMyApps: TFormMyApps;

implementation

{$R *.fmx}

uses DataModule, MyAppDetails;
{ TFormMyApps }

procedure TFormMyApps.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormMyApps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormMyApps.initForm;
var
  aTask: ITask;
begin
  self.Show;
  PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestMyApps.Params.Clear;
          with RESTRequestMyApps.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestMyApps.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          self.RESTRequestMyApps.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TFormMyApps.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  with TMyAppDetailsForm.Create(Application) do
  begin
    app_id := self.FDMemTableMyApps.FieldByName('id').AsInteger;
    initForm;
  end;
end;

procedure TFormMyApps.ListView1PullRefresh(Sender: TObject);
begin
  self.ListView1.PullRefreshWait := True;
  self.RESTRequestMyApps.Execute;
end;

procedure TFormMyApps.RESTRequestMyAppsAfterExecute(Sender: TCustomRESTRequest);
begin
  self.ListView1.PullRefreshWait := False;
  PreloaderRectangle.Visible := False;
end;

end.
