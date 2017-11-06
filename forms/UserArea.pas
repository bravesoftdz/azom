unit UserArea;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls;

type
  TUserAreaForm = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  UserAreaForm: TUserAreaForm;

implementation

{$R *.fmx}
{ TUserAreaForm }

procedure TUserAreaForm.initForm;
begin
  self.Show;
end;

end.
