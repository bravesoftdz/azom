unit AddApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Objects,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Response.Adapter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Memo, FMX.Layouts, FMX.TabControl, System.Threading;

type
  TFormAddApp = class(TForm)
    Button1: TButton;
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
    MemoNote: TMemo;
    SpeedButton1: TSpeedButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TabItem3: TTabItem;
    StyleBook1: TStyleBook;
    ButtonNextStep1: TButton;
    ButtonNextStep2: TButton;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
    procedure TimerForLoadListsTimer(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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

uses Main, DataModule, map;

{ TFormAddApp }

procedure TFormAddApp.Button1Click(Sender: TObject);
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
        Value := MemoNote.Text;
      end;
      // app_property_requisites
      with RESTRequestAddApp.Params.AddItem do
      begin
        name := 'cadcode';
        Value := EditCadcode.Text;
      end;
      with RESTRequestAddApp.Params.AddItem do
      begin
        name := 'area';
        Value := EditArea.Text;
      end;
      with RESTRequestAddApp.Params.AddItem do
      begin
        name := 'location_id';
        Value := FDMemTableLocations.FieldByName('id').AsString;
      end;
      with RESTRequestAddApp.Params.AddItem do
      begin
        name := 'address';
        Value := EditAddress.Text;
      end;
      with RESTRequestAddApp.Params.AddItem do
      begin
        name := 'lon_lat';
        Value := DModule.MyPosition.Latitude.ToString + ',' + DModule.MyPosition.Longitude.ToString;
      end;
      RESTRequestAddApp.Execute;
    end);
end;

procedure TFormAddApp.ButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormAddApp.ButtonNextStep1Click(Sender: TObject);
begin
  TabItem2.Enabled := True;
  TabControl1.ActiveTab := TabItem2;
end;

procedure TFormAddApp.ButtonNextStep2Click(Sender: TObject);
begin
  TabItem3.Enabled := True;
  TabControl1.ActiveTab := TabItem3;
end;

procedure TFormAddApp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormAddApp.initForm;
begin
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
begin
  PreloaderRectangle.Visible := False;
  AniIndicator1.Enabled := False;
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
