unit User2Review;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header,
  FMX.TMSBaseControl, FMX.TMSRatingGrid, FMX.Layouts, FMX.LoadingIndicator,
  FMX.Objects, FMX.RatingBar, FMX.TMSRating,
  FMX.StdCtrls, FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo,
  FMX.TabControl;

type
  TUser2ReviewForm = class(TForm)
    HeaderFrame1: THeaderFrame;
    PreloaderRectangle: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    TMSFMXRatingTime: TTMSFMXRating;
    ButtonSave: TButton;
    LabelTime: TLabel;
    LabelPrice: TLabel;
    LabelQuality: TLabel;
    TMSFMXRatingQuality: TTMSFMXRating;
    TMSFMXRatingPrice: TTMSFMXRating;
    LabelSum: TLabel;
    RectangleComment: TRectangle;
    MemoComment: TMemo;
    Button1: TButton;
    RectangleCommentHeader: TRectangle;
    ButtonBack: TButton;
    TabControl1: TTabControl;
    TabItemRating: TTabItem;
    TabItemFeedback: TTabItem;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure TMSFMXRatingTimeValueClick(Sender: TObject; AValue: Single);
    procedure TMSFMXRatingQualityValueClick(Sender: TObject; AValue: Single);
    procedure TMSFMXRatingPriceValueClick(Sender: TObject; AValue: Single);
  private
    procedure calculate;
    { Private declarations }
  public
    { Public declarations }
    v_user_FullName: String;
    v_Item1, v_Item2, v_Item3, v_total: Single;
    procedure initForm(user_id: Integer);
  end;

var
  User2ReviewForm: TUser2ReviewForm;

implementation

{$R *.fmx}

uses Main;
{ TUser2ReviewForm }

procedure TUser2ReviewForm.ButtonBackClick(Sender: TObject);
begin
  RectangleComment.Visible := False;
end;

procedure TUser2ReviewForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TUser2ReviewForm.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 137 then
    self.Free;
end;

procedure TUser2ReviewForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUser2ReviewForm.initForm(user_id: Integer);
begin
  self.Show;
  self.HeaderFrame1.LabelAppName.Text := self.v_user_FullName;
  // 32=>0,33=>1,34=>2,35=>3,36=>4,37=>5
  TabItemRating.ImageIndex := 35;
end;

procedure TUser2ReviewForm.TMSFMXRatingTimeValueClick(Sender: TObject;
  AValue: Single);
begin
  self.v_Item1 := AValue;
  self.calculate;
end;

procedure TUser2ReviewForm.TMSFMXRatingQualityValueClick(Sender: TObject;
  AValue: Single);
begin
  self.v_Item2 := AValue;
  self.calculate;
end;

procedure TUser2ReviewForm.TMSFMXRatingPriceValueClick(Sender: TObject;
  AValue: Single);
begin
  self.v_Item3 := AValue;
  self.calculate;
end;

procedure TUser2ReviewForm.calculate;
begin
  self.v_total := self.v_Item1 + self.v_Item2 + self.v_Item3;
  self.v_total := self.v_total / 3;
  LabelSum.Text := self.v_Item1.ToString + '+' + self.v_Item2.ToString + '+' +
    self.v_Item3.ToString + ' = ' + self.v_total.ToString;
end;

end.
