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
  FMX.Controls.Presentation, System.PushNotification
{$IFDEF ANDROID}
    , FMX.PushNotification.android, FMX.DateTimeCtrls, FMX.ScrollBox, FMX.Memo, FMX.Edit, FMX.Ani
{$ENDIF};

type
  TAppDetailForm = class(TForm)
    RectanglePreloader: TRectangle;
    AniIndicator1: TAniIndicator;
    RESTRequestApp: TRESTRequest;
    RESTResponseApp: TRESTResponse;
    RESTResponseDataSetAdapterApp: TRESTResponseDataSetAdapter;
    FDMemTableApp: TFDMemTable;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
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
    LabelAppName: TLabel;
    procedure RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonOfferClick(Sender: TObject);
    procedure ButtonSubmitClick(Sender: TObject);
    procedure RESTRequestOfferAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure FDMemTableAppAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    app_id: integer;
    procedure initForm(id: integer);
  end;

var
  AppDetailForm: TAppDetailForm;

implementation

{$R *.fmx}

uses DataModule, Main;
{ TForm1 }

procedure TAppDetailForm.ButtonOfferClick(Sender: TObject);
begin
  PanelBids.Visible := True;
end;

procedure TAppDetailForm.ButtonSubmitClick(Sender: TObject);
var
  aTask: ITask;
begin
  RectanglePreloader.Visible := True;
  PanelBids.Visible := False;
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
            Value := MemoOfferDescription.Text;
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
end;

procedure TAppDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TAppDetailForm.initForm(id: integer);
var
  aTask: ITask;
begin
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          if DModule.user_type_id = 2 then
            ButtonOffer.Visible := True
          else
            ButtonOffer.Visible := False;
          self.app_id := id;
          self.Show;
          RESTRequestApp.Params.Clear;
          with RESTRequestApp.Params.AddItem do
          begin
            name := 'app_id';
            Value := self.app_id.ToString;
          end;
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
          RESTRequestApp.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TAppDetailForm.RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
begin
  self.RectanglePreloader.Visible := False;
  self.AniIndicator1.Enabled := False;
  self.LabelAppName.Text := self.FDMemTableApp.FieldByName('id').AsString;
end;

procedure TAppDetailForm.RESTRequestOfferAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

end.
