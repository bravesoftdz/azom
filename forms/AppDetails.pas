unit AppDetails;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Controls.Presentation, System.PushNotification
{$IFDEF ANDROID}
    , FMX.PushNotification.android
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
    procedure RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure ButtonOfferClick(Sender: TObject);
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

uses DataModule, Main, BidUnit;
{ TForm1 }

procedure TAppDetailForm.ButtonOfferClick(Sender: TObject);
begin
  with TBidForm.Create(Application) do
  begin
    initForm(self.app_id);
    ShowModal(
      procedure(ModalResult: TModalResult)
      begin
      end);
  end;
end;

procedure TAppDetailForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TAppDetailForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TAppDetailForm.initForm(id: integer);
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
end;

procedure TAppDetailForm.RESTRequestAppAfterExecute(Sender: TCustomRESTRequest);
begin
  self.RectanglePreloader.Visible := False;
  self.AniIndicator1.Enabled := False;
end;

end.
