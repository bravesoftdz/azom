unit MyAppDetails;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter,
  REST.Client, Data.Bind.Components, Data.Bind.ObjectScope,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ListView.Types,
  FMX.ListView.Appearances, FMX.ListView.Adapters.Base, FMX.ListView,
  Data.Bind.DBScope, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, FMX.Grid.Style, FMX.ScrollBox, FMX.Grid,
  FMX.Bind.Grid, Data.Bind.Grid, System.Threading;

type
  TMyAppDetailsForm = class(TForm)
    RESTRequestMyApp: TRESTRequest;
    RESTResponseMyApp: TRESTResponse;
    RESTResponseDataSetAdapterMyApp: TRESTResponseDataSetAdapter;
    FDMemTableMyApp: TFDMemTable;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    RectanglePreloader: TRectangle;
    AniIndicator1: TAniIndicator;
    ListView1: TListView;
    BindSourceDBMyApp: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    Label1: TLabel;
    RectangleMain: TRectangle;
    ButtonBids: TButton;
    Button1: TButton;
    StyleBook1: TStyleBook;
    FDMemTableMyAppid: TWideStringField;
    FDMemTableMyAppuser_id: TWideStringField;
    FDMemTableMyAppapp_service_type_id: TWideStringField;
    FDMemTableMyAppapp_service_type_name: TWideStringField;
    FDMemTableMyAppapp_property_type_id: TWideStringField;
    FDMemTableMyAppapp_property_type_name: TWideStringField;
    FDMemTableMyAppcreate_date: TWideStringField;
    FDMemTableMyAppdeadlineby_user: TWideStringField;
    FDMemTableMyAppimageIndex: TWideStringField;
    FDMemTableMyAppusername: TWideStringField;
    FDMemTableMyAppnote: TWideStringField;
    FDMemTableMyAppaddress: TWideStringField;
    FDMemTableMyApparea: TWideStringField;
    FDMemTableMyAppcadcode: TWideStringField;
    FDMemTableMyApplocation_id: TWideStringField;
    FDMemTableMyApplon_lat: TWideStringField;
    FDMemTableMyAppbidscount: TWideStringField;
    procedure ButtonBackClick(Sender: TObject);
    procedure RESTRequestBidsCountAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonBidsClick(Sender: TObject);
    procedure RESTRequestMyAppAfterExecute(Sender: TCustomRESTRequest);
    procedure FDMemTableMyAppAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    app_id: Integer;
    procedure initForm;
  end;

var
  MyAppDetailsForm: TMyAppDetailsForm;

implementation

{$R *.fmx}

uses DataModule, BidsByApp;

procedure TMyAppDetailsForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TMyAppDetailsForm.ButtonBidsClick(Sender: TObject);
begin
  with TBidsByAppForm.Create(Application) do
  begin
    app_id := self.app_id;
    app_name := 'App ID: ' + self.app_id.ToString + ' / ' + FDMemTableMyApp.FieldByName('app_service_type_name').AsString;
    initForm;
  end;
end;

procedure TMyAppDetailsForm.FDMemTableMyAppAfterScroll(DataSet: TDataSet);
begin
  self.ButtonBids.Text := '(' + DataSet.FieldByName('bidscount').AsString + ') შემოთავაზებები';
end;

procedure TMyAppDetailsForm.initForm;
var
  aTask: ITask;
begin
  self.Show;
  self.Label1.Text := 'App ID: ' + self.app_id.ToString;
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestMyApp.Params.Clear;
          with RESTRequestMyApp.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestMyApp.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          with RESTRequestMyApp.Params.AddItem do
          begin
            name := 'app_id';
            Value := self.app_id.ToString;
          end;
          self.RESTRequestMyApp.Execute;
          {
            // Bids request
            self.RESTRequestBids.Params.Clear;
            with RESTRequestBids.Params.AddItem do
            with RESTRequestBids.Params.AddItem do
            begin
            name := 'sesskey';
            Value := DModule.sesskey;
            end;
            with RESTRequestBids.Params.AddItem do
            begin
            name := 'user_id';
            Value := DModule.id.ToString;
            end;
            with RESTRequestBids.Params.AddItem do
            begin
            name := 'app_id';
            Value := self.app_id.ToString;
            end;
            self.RESTRequestBids.Execute; }
        end);
    end);
  aTask.Start;
end;

procedure TMyAppDetailsForm.RESTRequestBidsCountAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

procedure TMyAppDetailsForm.RESTRequestMyAppAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

end.
