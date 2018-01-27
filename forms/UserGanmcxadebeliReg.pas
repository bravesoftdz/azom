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
    FullNameEdit: TEdit;
    PasswordEdit: TEdit;
    PhoneEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    RESTResponseDataSetAdapterReg: TRESTResponseDataSetAdapter;
    FDMemTableReg: TFDMemTable;
    RectanglePreloader: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    FDMemTableAuth: TFDMemTable;
    FDMemTableAuthid: TWideStringField;
    FDMemTableAuthuser_type_id: TWideStringField;
    FDMemTableAuthuser_status_id: TWideStringField;
    FDMemTableAuthfull_name: TWideStringField;
    FDMemTableAuthphone: TWideStringField;
    FDMemTableAuthemail: TWideStringField;
    FDMemTableAuthcreate_date: TWideStringField;
    FDMemTableAuthmodify_date: TWideStringField;
    FDMemTableAuthregipaddr: TWideStringField;
    FDMemTableAuthsesskey: TWideStringField;
    FDMemTableAuthloginstatus: TWideStringField;
    FDMemTableAuthisSetLocations: TWideStringField;
    FDMemTableAuthnotifications: TWideStringField;
    procedure RegButtonClick(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
  private
    function equalPassword(pass1, pass2: string): boolean;
    { Private declarations }
  public
    { Public declarations }
    closeAfterReg: boolean;
    procedure initForm;
  end;

var
  GanmcxadeblisRegForm: TGanmcxadeblisRegForm;

implementation

{$R *.fmx}

uses auth;
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

function TGanmcxadeblisRegForm.equalPassword(pass1, pass2: string): boolean;
begin
  if pass1.Equals(pass2) then
  begin
    Result := True;
  end
  else
  begin
    PasswordEdit.FontColor := TAlphaColors.Red;
    Result := False;
  end;
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
          }
          if self.equalPassword(PasswordEdit.Text, CPasswordEdit.Text) = True then
            password := PasswordEdit.Text
          else
            exit;
          RESTRequestReg.Params.Clear;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'user_type_id';
            Value := '1'
          end;
          with RESTRequestReg.Params.AddItem do
          begin
            name := 'full_name';
            Value := TIdURI.ParamsEncode(FullNameEdit.Text);
          end;
          with RESTRequestReg.Params.AddItem do
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

procedure TGanmcxadeblisRegForm.RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
begin
  if self.closeAfterReg = True then
  begin
    with TauthForm.Create(Application) do
    begin
      self.FDMemTableAuth := consoleAuth(EmailEdit.Text, PasswordEdit.Text);
    end;
    self.Close;
  end;
end;

end.
