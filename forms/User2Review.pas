unit User2Review;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header, FMX.TMSBaseControl, FMX.TMSRatingGrid, FMX.Layouts, FMX.LoadingIndicator,
  FMX.Objects, FMX.RatingBar, FMX.TMSRating;

type
  TUser2ReviewForm = class(TForm)
    HeaderFrame1: THeaderFrame;
    TMSFMXRatingGrid1: TTMSFMXRatingGrid;
    PreloaderRectangle: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    RectangleMain: TRectangle;
    FMXRatingBar1: TFMXRatingBar;
    TMSFMXRating1: TTMSFMXRating;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  User2ReviewForm: TUser2ReviewForm;

implementation

{$R *.fmx}

end.
