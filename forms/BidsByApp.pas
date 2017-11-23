unit BidsByApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  System.Threading,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt,
  FMX.Bind.DBEngExt, Data.Bind.DBScope, FMX.DateTimeCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Ani;

type
  TBidsByAppForm = class(TForm)
    RESTRequestBids: TRESTRequest;
    RESTResponseBids: TRESTResponse;
    RESTResponseDataSetAdapterBids: TRESTResponseDataSetAdapter;
    FDMemTableBids: TFDMemTable;
    RectanglePreloader: TRectangle;
    AniIndicator1: TAniIndicator;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    LabelAppName: TLabel;
    ListView1: TListView;
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
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    PanelCancel: TPanel;
    FloatAnimation1: TFloatAnimation;
    RectangleMain: TRectangle;
    MemoCancelReason: TMemo;
    Label1: TLabel;
    RectangleHeder: TRectangle;
    Button1: TButton;
    Label2: TLabel;
    ButtonSubmit: TButton;
    RESTRequestC: TRESTRequest;
    RESTResponse1: TRESTResponse;
    procedure RESTRequestBidsAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonBackClick(Sender: TObject);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ButtonSubmitClick(Sender: TObject);
    procedure RESTRequestCAfterExecute(Sender: TCustomRESTRequest);
  private
    procedure reloadItems;
    { Private declarations }
  public
    { Public declarations }
    app_id: Integer;
    app_name: string;
    procedure initForm;
  end;

var
  BidsByAppForm: TBidsByAppForm;

implementation

{$R *.fmx}

uses DataModule, Main;
{ TBidsByAppForm }

procedure TBidsByAppForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TBidsByAppForm.ButtonSubmitClick(Sender: TObject);
var
  aTask: ITask;
begin
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestC.Params.Clear;
          with RESTRequestC.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestC.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          with RESTRequestC.Params.AddItem do
          begin
            name := 'app_id';
            Value := self.app_id.ToString;
          end;
          with RESTRequestC.Params.AddItem do
          begin
            name := 'bid_id';
            Value := self.app_id.ToString;
          end;
          with RESTRequestC.Params.AddItem do
          begin
            name := 'reason';
            Value := MemoCancelReason.Text;
          end;
          self.RESTRequestC.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TBidsByAppForm.initForm;
begin
  self.LabelAppName.Text := self.app_name;
  self.Show;
  RectanglePreloader.Visible := True;
  self.reloadItems;
end;

procedure TBidsByAppForm.reloadItems;
var
  aTask: ITask;
begin
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          // Bids request
          self.RESTRequestBids.Params.Clear;
          with RESTRequestBids.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestBids.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          with RESTRequestBids.Params.AddItem do
          begin
            name := 'app_id';
            Value := self.app_id.ToString;
          end;
          self.RESTRequestBids.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TBidsByAppForm.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
begin
  // ShowMessage(self.FDMemTableBids.FieldByName('id').AsString);
  PanelCancel.Visible := True;
end;

procedure TBidsByAppForm.ListView1PullRefresh(Sender: TObject);
begin
  ListView1.PullRefreshWait := True;
end;

procedure TBidsByAppForm.RESTRequestBidsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
  ListView1.PullRefreshWait := False;
end;

procedure TBidsByAppForm.RESTRequestCAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
  PanelCancel.Visible := False;
end;

end.
