unit BidUnit;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.Edit, FMX.ScrollBox,
  FMX.Memo, REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.DateTimeCtrls;

type
  TBidForm = class(TForm)
    ButtonSubmit: TButton;
    RectangleMain: TRectangle;
    RectangleHeder: TRectangle;
    Button1: TButton;
    EditOfferedPrice: TEdit;
    MemoOfferDescription: TMemo;
    Label1: TLabel;
    RESTRequestOffer: TRESTRequest;
    RESTResponse1: TRESTResponse;
    DateEdit1: TDateEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonSubmitClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    app_id: integer;
    procedure initForm(app_id: integer);
  end;

var
  BidForm: TBidForm;

implementation

{$R *.fmx}

uses DataModule;

procedure TBidForm.Button1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TBidForm.ButtonSubmitClick(Sender: TObject);
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
end;

procedure TBidForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TBidForm.initForm(app_id: integer);
begin
  self.app_id := app_id;
end;

end.
