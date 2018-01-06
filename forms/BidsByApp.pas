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
  FMX.Bind.DBEngExt, Data.Bind.DBScope, FMX.DateTimeCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Ani, IdURI, Header, FMX.Layouts,
  FMX.LoadingIndicator;

type
  TBidsByAppForm = class(TForm)
    RESTRequestBids: TRESTRequest;
    RESTResponseBids: TRESTResponse;
    RESTResponseDataSetAdapterBids: TRESTResponseDataSetAdapter;
    FDMemTableBids: TFDMemTable;
    RectanglePreloader: TRectangle;
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
    RESTResponseC: TRESTResponse;
    ImageRequestSent: TImage;
    FDMemTableBidsapproved: TWideStringField;
    FloatAnimation2: TFloatAnimation;
    PanelChoose: TPanel;
    FloatAnimation3: TFloatAnimation;
    Rectangle1: TRectangle;
    MemoApproveComment: TMemo;
    Label3: TLabel;
    Rectangle2: TRectangle;
    Button2: TButton;
    Label4: TLabel;
    ButtonApprove: TButton;
    ImageRequestSent2: TImage;
    FloatAnimation4: TFloatAnimation;
    RESTRequestApproveRequest: TRESTRequest;
    RESTResponseApproveRequest: TRESTResponse;
    HeaderFrame1: THeaderFrame;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    procedure RESTRequestBidsAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonBackClick(Sender: TObject);
    procedure ListView1PullRefresh(Sender: TObject);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure ButtonSubmitClick(Sender: TObject);
    procedure RESTRequestCAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure ListView1Paint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
    procedure FloatAnimation2Finish(Sender: TObject);
    procedure ButtonApproveClick(Sender: TObject);
    procedure RESTRequestApproveRequestAfterExecute(Sender: TCustomRESTRequest);
    procedure FloatAnimation4Finish(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
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

procedure TBidsByAppForm.Button1Click(Sender: TObject);
begin
  self.PanelCancel.Visible := False;
end;

procedure TBidsByAppForm.Button2Click(Sender: TObject);
begin
  self.PanelChoose.Visible := False;
end;

procedure TBidsByAppForm.ButtonApproveClick(Sender: TObject);
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
          self.RESTRequestApproveRequest.Params.Clear;
          with RESTRequestApproveRequest.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestApproveRequest.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          with RESTRequestApproveRequest.Params.AddItem do
          begin
            name := 'app_id';
            Value := self.app_id.ToString;
          end;
          with RESTRequestApproveRequest.Params.AddItem do
          begin
            name := 'app_offer_id';
            Value := self.FDMemTableBids.FieldByName('id').AsString;
          end;
          with RESTRequestApproveRequest.Params.AddItem do
          begin
            name := 'note';
            Value := TIdURI.ParamsEncode(MemoApproveComment.Text);
          end;
          self.RESTRequestApproveRequest.Execute;
        end);
    end);
  aTask.Start;
end;

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
            name := 'app_offer_id';
            Value := self.FDMemTableBids.FieldByName('id').AsString;
          end;
          with RESTRequestC.Params.AddItem do
          begin
            name := 'reason_text';
            Value := TIdURI.ParamsEncode(MemoCancelReason.Text)
          end;
          self.RESTRequestC.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TBidsByAppForm.initForm;
begin
  self.HeaderFrame1.LabelAppName.Text := self.app_name;
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
  if FDMemTableBids.FieldByName('approved_id').AsInteger > 0 then
    PanelCancel.Visible := True
  else
    PanelChoose.Visible := True;
end;

procedure TBidsByAppForm.ListView1Paint(Sender: TObject; Canvas: TCanvas; const ARect: TRectF);
begin
  { Canvas.Fill.Color := TAlphaColorRec.Red;
    Canvas.FillRect(ARect, 0, 0, AllCorners, 1);
    Canvas.Fill.Color := TAlphaColorRec.Black;
    Canvas.FillText(ARect, 'some text', False, 1, [], TTextAlign.taLeading);
  }
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

procedure TBidsByAppForm.RESTRequestApproveRequestAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
  ImageRequestSent2.Visible := True;
  ShowMessage(RESTResponseApproveRequest.Content);
end;

procedure TBidsByAppForm.RESTRequestCAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
  ImageRequestSent.Visible := True;
end;

procedure TBidsByAppForm.FloatAnimation2Finish(Sender: TObject);
begin
  PanelCancel.Visible := False;
  MemoCancelReason.Text := '';
end;

procedure TBidsByAppForm.FloatAnimation4Finish(Sender: TObject);
begin
  PanelChoose.Visible := False;
  MemoApproveComment.Text := '';
end;

procedure TBidsByAppForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

end.
