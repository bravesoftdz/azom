unit UserGanmcxadebeliReg;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header, FMX.StdCtrls, FMX.Ani,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, System.Threading, IdURI, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Layouts, FMX.LoadingIndicator;

type
  TGanmcxadeblisRegForm = class(TForm)
    HeaderFrame1: THeaderFrame;
    RectangleMain: TRectangle;
    CPasswordEdit: TEdit;
    EmailEdit: TEdit;
    FloatAnimationEmailReg: TFloatAnimation;
    LnameEdit: TEdit;
    NameEdit: TEdit;
    PasswordEdit: TEdit;
    PhoneEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    RESTResponseDataSetAdapterReg: TRESTResponseDataSetAdapter;
    FDMemTableReg: TFDMemTable;
    RectanglePreloader: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    procedure RegButtonClick(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  GanmcxadeblisRegForm: TGanmcxadeblisRegForm;

implementation

{$R *.fmx}
{ TForm1 }

procedure TGanmcxadeblisRegForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TGanmcxadeblisRegForm.initForm;
begin
  self.Show;
  self.HeaderFrame1.LabelAppName.Text := 'განმცხადებლის რეგისტრაცია';
end;

procedure TGanmcxadeblisRegForm.RegButtonClick(Sender: TObject);
var
  password: string;
  aTask: ITask;
begin
  self.RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          { if self.checkEmailPass(EmailEdit.Text, password, 'signup') = False then
            exit;

            if self.equalPassword(PasswordEdit.Text, CPasswordEdit.Text) = True then
            password := PasswordEdit.Text
            else
            exit; }
          RESTRequestReg.Params.Clear;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'user_type_id';
            Value := '1'
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'name';
            Value := TIdURI.ParamsEncode(NameEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'lname';
            Value := TIdURI.ParamsEncode(LnameEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'email';
            Value := TIdURI.ParamsEncode(EmailEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'phone';
            Value := PhoneEdit.Text;
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'password';
            Value := password;
          end;
          RESTRequestReg.Execute;
        end);
    end);
  aTask.Start;
end;

end.
