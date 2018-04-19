unit AppDetails;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, System.Threading,
  FMX.Controls.Presentation, System.PushNotification, FMX.ListView.Types,
  FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.DBScope, FMX.DateTimeCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Edit, IdURI,
  FMX.Ani, FMX.ListView, FMX.TabControl, FMX.Bind.GenData, FMX.Layouts,
  FMX.LoadingIndicator, Header;

type
  TAppDetailForm = class(TForm)
    RectanglePreloader: TRectangle;
    RESTRequestApp: TRESTRequest;
    RESTResponseApp: TRESTResponse;
    RESTResponseDataSetAdapterApp: TRESTResponseDataSetAdapter;
    FDMemTableApp: TFDMemTable;
    RESTRequestOffer: TRESTRequest;
    RESTResponse1: TRESTResponse;
    SpeedButtonApplied: TSpeedButton;
    Image1: TImage;
    RectangleMain: TRectangle;
    TabControl1: TTabControl;
    TabItemDetails: TTabItem;
    TabItemOffer: TTabItem;
    ListViewAppDetails: TListView;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    ListViewOffers: TListView;
    RESTResponseDataSetAdapterBids: TRESTResponseDataSetAdapter;
    FDMemTableBids: TFDMemTable;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    FDMemTableBidsid: TWideStringField;
    FDMemTableBidsuser_id: TWideStringField;
    FDMemTableBidsapp_id: TWideStringField;
    FDMemTableBidsoffered_price: TWideStringField;
    FDMemTableBidsstart_date: TWideStringField;
    FDMemTableBidsoffer_description: TWideStringField;
    FDMemTableBidscreate_date: TWideStringField;
    FDMemTableBidsipaddr: TWideStringField;
    FDMemTableBidsuser: TWideStringField;
    FDMemTableBidsapproved_id: TWideStringField;
    FDMemTableBidsapproved_on_time: TWideStringField;
    FDMemTableBidsapproved_note: TWideStringField;
    FDMemTableBidsapproved: TWideStringField;
    FDMemTableBidsapproved_icon: TWideStringField;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    HeaderFrame1: THeaderFrame;
    RESTResponseDataSetAdapterRequiz: TRESTResponseDataSetAdapter;
    FDMemTableapp_property_requisites: TFDMemTable;
    TabItemProperties: TTabItem;
    ListViewProperties: TListView;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    FDMemTableapp_property_requisitesid: TWideStringField;
    FDMemTableapp_property_requisitesapp_id: TWideStringField;
    FDMemTableapp_property_requisitesapp_property_type_id: TWideStringField;
    FDMemTableapp_property_requisitesapp_property_type_name: TWideStringField;
    FDMemTableapp_property_requisiteslocation_id: TWideStringField;
    FDMemTableapp_property_requisiteslocation_address: TWideStringField;
    FDMemTableapp_property_requisitesaddress: TWideStringField;
    FDMemTableapp_property_requisitescadcode: TWideStringField;
    FDMemTableapp_property_requisitesarea: TWideStringField;
    FDMemTableapp_property_requisiteslon_lat: TWideStringField;
    FDMemTableapp_property_requisitesservice_types: TWideStringField;
    FDMemTableapp_property_requisitesapp_user_param: TWideStringField;
    FDMemTableAppid: TWideStringField;
    FDMemTableAppuser_id: TWideStringField;
    FDMemTableAppcreate_date: TWideStringField;
    FDMemTableAppdeadlineby_user: TWideStringField;
    FDMemTableAppimageIndex: TWideStringField;
    FDMemTableAppusername: TWideStringField;
    FDMemTableAppnote: TWideStringField;
    FDMemTableAppstatus_name: TWideStringField;
    FDMemTableAppstatus_color: TWideStringField;
    FDMemTableAppstatus_progress: TWideStringField;
    FDMemTableAppapp_status_id: TWideStringField;
    FDMemTableAppnotification_on_email: TWideStringField;
    FDMemTableAppnotification_on_device: TWideStringField;
    FDMemTableAppbidscount: TWideStringField;
    TabItemOwner: TTabItem;
    FDMemTableAmzomveli: TFDMemTable;
    RESTResponseDataSetAdapterAmzomveli: TRESTResponseDataSetAdapter;
    ListView2: TListView;
    PanelDetails: TPanel;
    FDMemTableAmzomveliid: TWideStringField;
    FDMemTableAmzomveliuser_type_id: TWideStringField;
    FDMemTableAmzomveliuser_status_id: TWideStringField;
    FDMemTableAmzomvelirating: TWideStringField;
    FDMemTableAmzomvelifull_name: TWideStringField;
    FDMemTableAmzomveliphone: TWideStringField;
    FDMemTableAmzomveliemail: TWideStringField;
    FDMemTableAmzomvelicreate_date: TWideStringField;
    FDMemTableAmzomvelimodify_date: TWideStringField;
    FDMemTableAmzomveliregipaddr: TWideStringField;
    FDMemTableAmzomvelicontact_info: TWideStringField;
    BindSourceDB4: TBindSourceDB;
    LinkListControlToField4: TLinkListControlToField;
    procedure RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure RESTRequestOfferAfterExecute(Sender: TCustomRESTRequest);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    app_id: integer;
    aTask: ITask;
    procedure initForm(papp_id: integer; showOwner: boolean = false);
  end;

var
  AppDetailForm: TAppDetailForm;

implementation

{$R *.fmx}

uses DataModule, Main;

procedure TAppDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TAppDetailForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 137 then
    self.Free;
end;

procedure TAppDetailForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppDetailForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppDetailForm.initForm(papp_id: integer; showOwner: boolean = false);
begin
  TabItemOwner.Visible := showOwner;
  self.app_id := papp_id;
  HeaderFrame1.LabelAppName.Text := 'განცხადება N ' + papp_id.ToString;
  self.Show;
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      RESTRequestApp.Params.Clear;
      RESTRequestApp.AddParameter('app_id', self.app_id.ToString);
      if not DModule.sesskey.IsEmpty then
      begin
        RESTRequestApp.AddParameter('sesskey', DModule.sesskey);
        RESTRequestApp.AddParameter('user_id', DModule.id.ToString);
        if showOwner = True then
        begin
          RESTRequestApp.AddParameter('op', 'showamzomveliinfo');
          TabControl1.ActiveTab := TabItemOwner;
        end
        else
          TabControl1.ActiveTab := TabItemDetails;
      end
      else
      begin
        TabItemOffer.Visible := false;
      end;
      RESTRequestApp.Execute;
    end);
  aTask.Start;
end;

procedure TAppDetailForm.RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
begin
  self.RectanglePreloader.Visible := false;
end;

procedure TAppDetailForm.RESTRequestOfferAfterExecute(Sender: TCustomRESTRequest);
begin
  self.initForm(self.app_id);
  RectanglePreloader.Visible := false;
end;

end.
