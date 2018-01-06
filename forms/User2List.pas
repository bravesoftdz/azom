unit User2List;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.Layouts, FMX.LoadingIndicator;

type
  TUser2ListForm = class(TFrame)
    ListView1: TListView;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  User2ListForm: TUser2ListForm;

implementation

{$R *.fmx}

procedure TUser2ListForm.initForm;
begin
  //
end;

end.
