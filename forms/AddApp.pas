unit AddApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Objects,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Response.Adapter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Memo, FMX.Layouts, FMX.TabControl, System.Threading, FMX.Types, IdURI;

type
  TFormAddApp = class(TForm)
    ButtonFinishAdding: TButton;
    RectangleMain: TRectangle;
    PreloaderRectangle: TRectangle;
    AniIndicator1: TAniIndicator;
    RESTRequestLists: TRESTRequest;
    RESTResponseLists: TRESTResponse;
    RESTResponseDataSetAdapterST: TRESTResponseDataSetAdapter;
    RESTResponseDataSetAdapterPT: TRESTResponseDataSetAdapter;
    FDMemTableApp_property_types: TFDMemTable;
    FDMemTableApp_service_types: TFDMemTable;
    FDMemTableApp_property_typesid: TWideStringField;
    FDMemTableApp_property_typestitle: TWideStringField;
    FDMemTableApp_service_typesid: TWideStringField;
    FDMemTableApp_service_typestitle: TWideStringField;
    ComboBoxApp_property_types: TComboBox;
    ComboBoxApp_service_types: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    TimerForLoadLists: TTimer;
    RectangleHeader: TRectangle;
    ButtonClose: TButton;
    Label1: TLabel;
    RectanglePropertyRequizites: TRectangle;
    EditCadcode: TEdit;
    EditArea: TEdit;
    EditAddress: TEdit;
    LabelServiceType: TLabel;
    LabelPropertyType: TLabel;
    RESTRequestAddApp: TRESTRequest;
    RESTResponseAddApp: TRESTResponse;
    ComboBoxLocation: TComboBox;
    RESTResponseDataSetAdapterLoc: TRESTResponseDataSetAdapter;
    FDMemTableLocations: TFDMemTable;
    FDMemTableLocationsid: TWideStringField;
    FDMemTableLocationstitle: TWideStringField;
    FDMemTableLocationsmap_title: TWideStringField;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    SpeedButton1: TSpeedButton;
    TabControl1: TTabControl;
    TabItemGeneral: TTabItem;
    TabItemRequizites: TTabItem;
    TabItemFinish: TTabItem;
    ButtonNextStep1: TButton;
    ButtonNextStep2: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    MemoNote: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
    procedure TimerForLoadListsTimer(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonFinishAddingClick(Sender: TObject);
    procedure RESTRequestAddAppAfterExecute(Sender: TCustomRESTRequest);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ButtonNextStep1Click(Sender: TObject);
    procedure ButtonNextStep2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  FormAddApp: TFormAddApp;

implementation

{$R *.fmx}

uses Main, DataModule, map, auth;

{ TFormAddApp }

procedure TFormAddApp.ButtonFinishAddingClick(Sender: TObject);
begin
  {
    sesskey
    user_id
    app_service_type_id
    app_property_type_id
    deadlineby_user
    note

    cadcode
    area
    location_id
    lon_lat
  }
  if DModule.sesskey.IsEmpty = True then
  begin
    with TauthForm.Create(Application) do
    begin
      TabControl1.ActiveTab := TabItemReg;
      closeAfterReg := True;
      initForm;
    end;
  end
  else
  begin
    PreloaderRectangle.Visible := True;
    AniIndicator1.Enabled := True;
    TThread.Synchronize(TThread.CurrentThread,
      procedure
      begin
        RESTRequestAddApp.Params.Clear;
        // apps
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'sesskey';
          Value := DModule.sesskey;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'user_id';
          Value := DModule.id.ToString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'app_service_type_id';
          Value := FDMemTableApp_service_types.FieldByName('id').AsString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'app_property_type_id';
          Value := FDMemTableApp_property_types.FieldByName('id').AsString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'deadlineby_user';
          Value := id.ToString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'note';
          Value := TIdURI.ParamsEncode(MemoNote.Text);
        end;
        // app_property_requisites
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'cadcode';
          Value := TIdURI.ParamsEncode(EditCadcode.Text);
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'area';
          Value := TIdURI.ParamsEncode(EditArea.Text);
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'location_id';
          Value := FDMemTableLocations.FieldByName('id').AsString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'address';
          Value := TIdURI.ParamsEncode(EditAddress.Text);
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'lon_lat';
          Value := TIdURI.ParamsEncode(DModule.MyPosition.Latitude.ToString + ',' + DModule.MyPosition.Longitude.ToString);
        end;
        RESTRequestAddApp.Execute;
      end);
  end;
end;

procedure TFormAddApp.ButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormAddApp.ButtonNextStep1Click(Sender: TObject);
begin
  TabItemRequizites.Enabled := True;
  TabControl1.ActiveTab := TabItemRequizites;
end;

procedure TFormAddApp.ButtonNextStep2Click(Sender: TObject);
begin
  TabItemFinish.Enabled := True;
  TabControl1.ActiveTab := TabItemFinish;
end;

procedure TFormAddApp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormAddApp.initForm;
begin
  PreloaderRectangle.Visible := False;
  self.Show;
  TimerForLoadLists.Enabled := True;
end;

procedure TFormAddApp.RESTRequestAddAppAfterExecute(Sender: TCustomRESTRequest);
begin
  PreloaderRectangle.Visible := False;
  AniIndicator1.Enabled := False;
  MemoNote.Text := RESTResponseAddApp.Content;
end;

procedure TFormAddApp.RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
var
  i: integer;
begin
  PreloaderRectangle.Visible := False;
  AniIndicator1.Enabled := False;
  for i := 0 to ComboBoxApp_property_types.Count - 1 do
  begin
    ComboBoxApp_property_types.ListItems[i].TextSettings.Font.Size := 10;
  end;

  for i := 0 to ComboBoxApp_service_types.Count - 1 do
  begin
    ComboBoxApp_service_types.ListItems[i].Font.Size := 10;
  end;
end;

procedure TFormAddApp.SpeedButton1Click(Sender: TObject);
begin
  with TmapViewForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TFormAddApp.TimerForLoadListsTimer(Sender: TObject);
begin
  TimerForLoadLists.Enabled := False;
  TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      RESTRequestLists.Execute;
    end);
end;

end.
