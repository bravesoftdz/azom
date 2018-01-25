unit UserLocations;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Ani, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.Components, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.ObjectScope,
  Data.Bind.DBScope, System.Threading, IdURI, System.Actions, FMX.ActnList,
  FMX.Gestures, FMX.LoadingIndicator;

type
  TUserLocationsForm = class(TForm)
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    LabelAppName: TLabel;
    RectangleLocation: TRectangle;
    ListBoxLocationsMaster: TListBox;
    RectangleDetail: TRectangle;
    ListBoxDetails: TListBox;
    Button1: TButton;
    RESTRequestLocation: TRESTRequest;
    RESTResponseLocation: TRESTResponse;
    RESTResponseDataSetAdapterL: TRESTResponseDataSetAdapter;
    FDMemTableL: TFDMemTable;
    FDMemTableLocationDetails: TFDMemTable;
    RESTResponseDataSetAdapterLocationDetails: TRESTResponseDataSetAdapter;
    RESTResponseLocationDetails: TRESTResponse;
    RESTRequestLocationDetails: TRESTRequest;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    BindSourceDB2: TBindSourceDB;
    RESTRequestSetLocations: TRESTRequest;
    RESTResponseLocations: TRESTResponse;
    RectanglePreloader: TRectangle;
    FDMemTableLid: TWideStringField;
    FDMemTableLpid: TWideStringField;
    FDMemTableLtitle: TWideStringField;
    FDMemTableLmap_title: TWideStringField;
    FDMemTableLisChecked: TWideStringField;
    FDMemTableLuser_id: TWideStringField;
    GestureManager1: TGestureManager;
    ActionList1: TActionList;
    ActionCloseDetailPanel: TAction;
    FloatAnimation1: TFloatAnimation;
    TimerSetChecked: TTimer;
    FDMemTableLocationDetailsid: TWideStringField;
    FDMemTableLocationDetailspid: TWideStringField;
    FDMemTableLocationDetailstitle: TWideStringField;
    FDMemTableLocationDetailsmap_title: TWideStringField;
    FDMemTableLocationDetailsisChecked: TWideStringField;
    FDMemTableLocationDetailsuser_id: TWideStringField;
    LinkListControlToField2: TLinkListControlToField;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonBackClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ListBoxDetailsChangeCheck(Sender: TObject);
    procedure ListBoxLocationsMasterChangeCheck(Sender: TObject);
    procedure ListBoxLocationsMasterItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure RESTRequestSetLocationsAfterExecute(Sender: TCustomRESTRequest);
    procedure RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
    procedure ActionCloseDetailPanelExecute(Sender: TObject);
    procedure RESTRequestLocationAfterExecute(Sender: TCustomRESTRequest);
    procedure TimerSetCheckedTimer(Sender: TObject);
  private
    procedure setLocations;
    { Private declarations }
  public
    { Public declarations }
    v_detailRequestId: integer;
    locationsSL, locationsSLDetails: TStringList;
    checkCheckBoxesMaster: boolean;
    procedure initForm;
  end;

var
  UserLocationsForm: TUserLocationsForm;

implementation

{$R *.fmx}

uses DataModule;

procedure TUserLocationsForm.ActionCloseDetailPanelExecute(Sender: TObject);
begin
  RectangleDetail.Visible := False;
end;

procedure TUserLocationsForm.Button1Click(Sender: TObject);
begin
  setLocations;
end;

procedure TUserLocationsForm.ButtonBackClick(Sender: TObject);
begin
  if RectangleDetail.Visible = True then
    RectangleDetail.Visible := False
  else
    self.Close;
end;

procedure TUserLocationsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TUserLocationsForm.initForm;
var
  aTask: ITask;
begin
  RectanglePreloader.Visible := True;
  if DModule.user_type_id <> 2 then
    self.Close;

  self.Show;

  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestLocation.Params.Clear;
          with RESTRequestLocation.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestLocation.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          self.RESTRequestLocation.Execute;
        end);
    end);
  aTask.Start;

  self.v_detailRequestId := 0;
  locationsSL := TStringList.Create;
  locationsSLDetails := TStringList.Create;
end;

procedure TUserLocationsForm.ListBoxDetailsChangeCheck(Sender: TObject);
var
  I: integer;
begin
  locationsSLDetails.Clear;
  for I := 0 to ListBoxDetails.Items.Count - 1 do
  begin
    if ListBoxDetails.ListItems[I].IsChecked = True then
    begin
      locationsSLDetails.Add(ListBoxDetails.Items.Strings[I]);
    end;
  end;
end;

procedure TUserLocationsForm.ListBoxLocationsMasterChangeCheck(Sender: TObject);
var
  I: integer;
begin
  locationsSL.Clear;
  for I := 0 to ListBoxLocationsMaster.Items.Count - 1 do
  begin
    if ListBoxLocationsMaster.ListItems[I].IsChecked = True then
    begin
      locationsSL.Add(ListBoxLocationsMaster.Items.Strings[I]);
    end;
  end;
end;

procedure TUserLocationsForm.ListBoxLocationsMasterItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
var
  aTask: ITask;
begin

  // self.LabelAppName.Text := Item.ItemData.Detail;

  Item.IsChecked := True;
  if RectangleDetail.Visible = True then
    RectangleDetail.Visible := False
  else
  begin
    RectangleDetail.Visible := True;
    if not self.FDMemTableL.FieldByName('id').AsInteger <> self.v_detailRequestId then
    begin
      self.v_detailRequestId := self.FDMemTableL.FieldByName('id').AsInteger;
      RectanglePreloader.Visible := True;
      aTask := TTask.Create(
        procedure()
        begin
          TThread.Synchronize(nil,
            procedure
            begin
              RESTRequestLocationDetails.Params.Clear;
              with RESTRequestLocationDetails.Params.AddItem do
              begin
                name := 'pid';
                Value := self.FDMemTableL.FieldByName('id').AsString
              end;
              with RESTRequestLocationDetails.Params.AddItem do
              begin
                name := 'sesskey';
                Value := DModule.sesskey;
              end;
              with RESTRequestLocationDetails.Params.AddItem do
              begin
                name := 'user_id';
                Value := DModule.id.ToString;
              end;
              RESTRequestLocationDetails.Execute;
            end);
        end);
      aTask.Start;
    end;
  end;
end;

procedure TUserLocationsForm.RESTRequestLocationAfterExecute(Sender: TCustomRESTRequest);
begin
  self.checkCheckBoxesMaster := True;
  TimerSetChecked.Enabled := True;
end;

procedure TUserLocationsForm.RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
begin
  self.checkCheckBoxesMaster := False;
  TimerSetChecked.Enabled := True;
end;

procedure TUserLocationsForm.RESTRequestSetLocationsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
  if RESTResponseLocations.Content = 'success' then
    self.Close;
end;

procedure TUserLocationsForm.setLocations;
var
  I: integer;
  aTask: ITask;
  names: string;
begin
  RectanglePreloader.Visible := True;
  // Master
  for I := 0 to locationsSL.Count - 1 do
  begin
    names := names + locationsSL.Strings[I] + ',';
  end;
  if locationsSL.Count > 0 then
    names.TrimRight;
  // Details
  for I := 0 to locationsSLDetails.Count - 1 do
  begin
    names := names + locationsSLDetails.Strings[I] + ',';
  end;
  if locationsSLDetails.Count > 0 then
    names.TrimRight;

  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestSetLocations.Params.Clear;
          with RESTRequestSetLocations.Params.AddItem do
          begin
            name := 'locations';
            Value := TIdURI.ParamsEncode(names);
          end;
          with RESTRequestSetLocations.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestSetLocations.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          RESTRequestSetLocations.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUserLocationsForm.TimerSetCheckedTimer(Sender: TObject);
var
  I: integer;
  IsChecked: String;
begin
  TTimer(Sender).Enabled := False;
  if self.checkCheckBoxesMaster = True then
  begin
    for I := 0 to ListBoxLocationsMaster.Items.Count - 1 do
    begin
      IsChecked := ListBoxLocationsMaster.ListItems[I].ItemData.Detail;
      if IsChecked = '1' then
      begin
        ListBoxLocationsMaster.ListItems[I].BeginUpdate;
        ListBoxLocationsMaster.ListItems[I].IsChecked := True;
        ListBoxLocationsMaster.ListItems[I].EndUpdate;
      end;
    end;
  end
  else
  begin
    // self.LabelAppName.Text := ListBoxDetails.Items.Count.ToString;
    for I := 0 to ListBoxDetails.Items.Count - 1 do
    begin
      IsChecked := ListBoxDetails.ListItems[I].ItemData.Detail;
      // self.LabelAppName.Text := self.LabelAppName.Text + ' ' + IsChecked;
      if IsChecked = '1' then
      begin
        ListBoxDetails.ListItems[I].BeginUpdate;
        ListBoxDetails.ListItems[I].IsChecked := True;
        // ListBoxDetails.ListItems[I].Text := ListBoxDetails.ListItems[I].Text + ' 1';
        ListBoxDetails.ListItems[I].EndUpdate;
      end;
    end;
  end;
  RectanglePreloader.Visible := False;
end;

end.

