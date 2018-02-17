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
  FMX.Controls.Presentation, System.PushNotification, FMX.ListView.Types, FMX.ListView.Appearances,
  FMX.ListView.Adapters.Base, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, FMX.DateTimeCtrls,
  FMX.ScrollBox, FMX.Memo, FMX.Edit, IdURI,
  FMX.Ani, FMX.ListView, FMX.TabControl, FMX.Bind.GenData, FMX.Layouts, FMX.LoadingIndicator, Header;

type
  TAppDetailForm = class(TForm)
    RectanglePreloader: TRectangle;
    RESTRequestApp: TRESTRequest;
    RESTResponseApp: TRESTResponse;
    RESTResponseDataSetAdapterApp: TRESTResponseDataSetAdapter;
    FDMemTableApp: TFDMemTable;
    ButtonOffer: TButton;
    PanelBids: TPanel;
    FloatAnimation1: TFloatAnimation;
    RectangleInnerMain: TRectangle;
    RectangleHeder: TRectangle;
    Button1: TButton;
    ButtonSubmit: TButton;
    EditOfferedPrice: TEdit;
    MemoOfferDescription: TMemo;
    Label1: TLabel;
    DateEdit1: TDateEdit;
    RESTRequestOffer: TRESTRequest;
    RESTResponse1: TRESTResponse;
    Label2: TLabel;
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
    Label3: TLabel;
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
    procedure RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonOfferClick(Sender: TObject);
    procedure ButtonSubmitClick(Sender: TObject);
    procedure RESTRequestOfferAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure FDMemTableAppAfterOpen(DataSet: TDataSet);
    procedure FDMemTableBidsAfterGetRecord(DataSet: TFDDataSet);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    app_id: integer;
    aTask: ITask;
    procedure initForm(app_id: integer);
  end;

var
  AppDetailForm: TAppDetailForm;

implementation

{$R *.fmx}

uses DataModule, Main;

procedure TAppDetailForm.ButtonOfferClick(Sender: TObject);
begin
  PanelBids.Visible := True;
end;

procedure TAppDetailForm.ButtonSubmitClick(Sender: TObject);
begin
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestOffer.Params.Clear;
          with RESTRequestOffer.Params.AddItem do
          begin
            name := 'app_id';
            Value := self.app_id.ToString;
          end;
          with RESTRequestOffer.Params.AddItem do
          begin
            name := 'offered_price';
            Value := EditOfferedPrice.Text;
          end;
          with RESTRequestOffer.Params.AddItem do
          begin
            name := 'start_date';
            Value := DateEdit1.Text;
          end;
          with RESTRequestOffer.Params.AddItem do
          begin
            name := 'offer_description';
            Value := TIdURI.ParamsEncode(MemoOfferDescription.Text);
          end;
          with RESTRequestOffer.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestOffer.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          RESTRequestOffer.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TAppDetailForm.Button1Click(Sender: TObject);
begin
  self.PanelBids.Visible := False;
end;

procedure TAppDetailForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppDetailForm.FDMemTableAppAfterOpen(DataSet: TDataSet);
begin
  {
    if DataSet.FieldByName('id').AsInteger = 1 then
    begin
    SpeedButtonApplied.Visible := True;
    ButtonOffer.Visible := False;
    end
    else
    begin
    SpeedButtonApplied.Visible := False;
    ButtonOffer.Visible := True;
    end;
  }
end;

procedure TAppDetailForm.FDMemTableBidsAfterGetRecord(DataSet: TFDDataSet);
begin
  // if DataSet.FieldByName('approved_id').AsString <> '' then
end;

procedure TAppDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TAppDetailForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppDetailForm.initForm(app_id: integer);
begin
  self.app_id := app_id;
  HeaderFrame1.LabelAppName.Text := 'განცხადება N ' + app_id.ToString;
  self.Show;
  RectanglePreloader.Visible := True;
  if DModule.user_type_id = 2 then
    ButtonOffer.Visible := True
  else
    ButtonOffer.Visible := False;
  aTask := TTask.Create(
    procedure()
    begin
      if DModule.user_type_id = 2 then
        ButtonOffer.Visible := True
      else
        ButtonOffer.Visible := False;
      RESTRequestApp.Params.Clear;
      with RESTRequestApp.Params.AddItem do
      begin
        name := 'app_id';
        Value := self.app_id.ToString;
      end;
      if not DModule.sesskey.IsEmpty then
      begin
        with RESTRequestApp.Params.AddItem do
        begin
          name := 'sesskey';
          Value := DModule.sesskey;
        end;
        with RESTRequestApp.Params.AddItem do
        begin
          name := 'user_id';
          Value := DModule.id.ToString;
        end;
      end
      else
      begin
        TabItemOffer.Visible := False;
      end;
      RESTRequestApp.Execute;
    end);
  aTask.Start;
end;

procedure TAppDetailForm.RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
begin
  self.RectanglePreloader.Visible := False;
end;

procedure TAppDetailForm.RESTRequestOfferAfterExecute(Sender: TCustomRESTRequest);
begin
  self.initForm(self.app_id);
  PanelBids.Visible := False;
  RectanglePreloader.Visible := False;
end;

end.
