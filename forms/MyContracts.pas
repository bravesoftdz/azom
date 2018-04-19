unit MyContracts;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, Header,
  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope, FMX.Layouts,
  FMX.LoadingIndicator, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.ImageList, FMX.ImgList, Data.Bind.DBScope, System.Rtti,
  System.Bindings.Outputs, System.Threading,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt;

type
  TMyContractsForm = class(TForm)
    HeaderFrame1: THeaderFrame;
    RectanglePreloader: TRectangle;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    ListView1: TListView;
    BindSourceDB1: TBindSourceDB;
    RESTRequestContracts: TRESTRequest;
    RESTResponseContracts: TRESTResponse;
    RESTResponseDataSetAdapterContracts: TRESTResponseDataSetAdapter;
    FDMemTableContracts: TFDMemTable;
    FDMemTableContractsapp_id: TWideStringField;
    FDMemTableContractsamzomveli_id: TWideStringField;
    FDMemTableContractsganmcxadebeli_id: TWideStringField;
    FDMemTableContractsganmcxadebeli_name: TWideStringField;
    FDMemTableContractsoffered_price: TWideStringField;
    FDMemTableContractsoffer_description: TWideStringField;
    FDMemTableContractscreate_date: TWideStringField;
    FDMemTableContractsimageindex: TWideStringField;
    ImageList1: TImageList;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure RESTRequestContractsAfterExecute(Sender: TCustomRESTRequest);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  MyContractsForm: TMyContractsForm;

implementation

{$R *.fmx}

uses DataModule, AppDetails;
{ TMyContractsForm }

procedure TMyContractsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TMyContractsForm.FormKeyUp(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 137 then
    self.Free;
end;

procedure TMyContractsForm.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TMyContractsForm.initForm;
var
  aTask: ITask;
begin
  self.show;
  HeaderFrame1.LabelAppName.Text := 'ჩემი შეთანხმებების სია';
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      RESTRequestContracts.Params.Clear;
      if not DModule.sesskey.IsEmpty then
      begin
        RESTRequestContracts.AddParameter('user_id', DModule.id.ToString);
        RESTRequestContracts.AddParameter('sesskey', DModule.sesskey);
      end
      else
        self.Close;
      self.RESTRequestContracts.Execute;
    end);
  aTask.Start;
end;

procedure TMyContractsForm.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  v_app_id: integer;
begin
  v_app_id := self.FDMemTableContracts.FieldByName('app_id').AsInteger;
  with TAppDetailForm.Create(Application) do
  begin
    initForm(v_app_id, True);
  end;
end;

procedure TMyContractsForm.RESTRequestContractsAfterExecute
  (Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

end.
