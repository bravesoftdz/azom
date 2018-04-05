unit User2Review;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header,
  FMX.TMSBaseControl, FMX.TMSRatingGrid, FMX.Layouts, FMX.LoadingIndicator,
  FMX.Objects, FMX.RatingBar, FMX.TMSRating, FMX.Controls.Presentation,
  FMX.StdCtrls;

type
  TUser2ReviewForm = class(TForm)
    HeaderFrame1: THeaderFrame;
    TMSFMXRatingGrid1: TTMSFMXRatingGrid;
    PreloaderRectangle: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    RectangleMain: TRectangle;
    TMSFMXRating1: TTMSFMXRating;
    Button1: TButton;
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm(user_id: integer);
  end;

var
  User2ReviewForm: TUser2ReviewForm;

implementation

{$R *.fmx}
{ TUser2ReviewForm }

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

procedure TUser2ReviewForm.initForm(user_id: integer);
begin
  self.Show;
end;

end.
