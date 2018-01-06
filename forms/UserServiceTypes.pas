unit UserServiceTypes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, System.Actions, FMX.ActnList, FMX.Gestures,
  Data.Bind.DBScope, Data.Bind.Components, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.ObjectScope, FMX.StdCtrls,
  FMX.ListBox, FMX.Objects, System.Threading, IdURI, FMX.Controls.Presentation,
  FMX.Layouts, FMX.Ani, FMX.LoadingIndicator;

type
  TUserServiceTypesForm = class(TForm)
    RectangleLocation: TRectangle;
    ListBoxServiceTypes: TListBox;
    Button1: TButton;
    RectanglePreloader: TRectangle;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    LabelAppName: TLabel;
    TimerSetChecked: TTimer;
    RESTRequestServiceTypes: TRESTRequest;
    RESTResponseServiceTypes: TRESTResponse;
    RESTResponseDataSetAdapterST: TRESTResponseDataSetAdapter;
    FDMemTableServiceTypes: TFDMemTable;
    FDMemTableServiceTypesid: TWideStringField;
    FDMemTableServiceTypestitle: TWideStringField;
    FDMemTableServiceTypesisChecked: TWideStringField;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB1: TBindSourceDB;
    RESTRequestSetServiceTypes: TRESTRequest;
    RESTResponseSetServiceTypes: TRESTResponse;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    procedure ListBoxServiceTypesChangeCheck(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RESTRequestServiceTypesAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestSetServiceTypesAfterExecute(Sender: TCustomRESTRequest);
    procedure TimerSetCheckedTimer(Sender: TObject);
  private
    procedure setServiceTypes;
    procedure checkCheckboxSelections;
    { Private declarations }
  public
    { Public declarations }
    serviceTypesSL: TStringList;
    checkCheckBoxesMaster: boolean;
    procedure initForm;
  end;

var
  UserServiceTypesForm: TUserServiceTypesForm;

implementation

{$R *.fmx}

uses DataModule;

procedure TUserServiceTypesForm.Button1Click(Sender: TObject);
begin
  self.setServiceTypes;
end;

procedure TUserServiceTypesForm.initForm;
var
  aTask: ITask;
begin
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
          RESTRequestServiceTypes.Params.Clear;
          with RESTRequestServiceTypes.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestServiceTypes.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          self.RESTRequestServiceTypes.Execute;
        end);
    end);
  aTask.Start;
  serviceTypesSL := TStringList.Create;
end;

procedure TUserServiceTypesForm.setServiceTypes;
var
  I: integer;
  aTask: ITask;
  names: string;
begin
  RectanglePreloader.Visible := True;
  for I := 0 to serviceTypesSL.Count - 1 do
  begin
    names := names + serviceTypesSL.Strings[I] + '|';
  end;
  // ShowMessage(names);
  // exit;
  if serviceTypesSL.Count > 0 then
    names.TrimRight;

  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestSetServiceTypes.Params.Clear;
          with RESTRequestSetServiceTypes.Params.AddItem do
          begin
            name := 'service_types';
            Value := TIdURI.ParamsEncode(names);
          end;
          with RESTRequestSetServiceTypes.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestSetServiceTypes.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          RESTRequestSetServiceTypes.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUserServiceTypesForm.TimerSetCheckedTimer(Sender: TObject);
var
  I: integer;
  IsChecked: String;
begin
  TTimer(Sender).Enabled := False;
  for I := 0 to ListBoxServiceTypes.Items.Count - 1 do
  begin
    IsChecked := ListBoxServiceTypes.ListItems[I].ItemData.Detail;
    if IsChecked = '1' then
    begin
      ListBoxServiceTypes.ListItems[I].BeginUpdate;
      ListBoxServiceTypes.ListItems[I].IsChecked := True;
      ListBoxServiceTypes.ListItems[I].EndUpdate;
    end;
  end;
  RectanglePreloader.Visible := False;
end;

procedure TUserServiceTypesForm.ListBoxServiceTypesChangeCheck(Sender: TObject);
begin
  self.checkCheckboxSelections;
end;

procedure TUserServiceTypesForm.RESTRequestServiceTypesAfterExecute(Sender: TCustomRESTRequest);
begin
  TimerSetChecked.Enabled := True;
end;

procedure TUserServiceTypesForm.RESTRequestSetServiceTypesAfterExecute(Sender: TCustomRESTRequest);
begin
  if RESTResponseSetServiceTypes.Content = 'success' then
    RectanglePreloader.Visible := False;
end;

procedure TUserServiceTypesForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUserServiceTypesForm.checkCheckboxSelections;
var
  I: integer;
begin
  serviceTypesSL.Clear;
  for I := 0 to ListBoxServiceTypes.Items.Count - 1 do
  begin
    if ListBoxServiceTypes.ListItems[I].IsChecked = True then
    begin
      serviceTypesSL.Add(ListBoxServiceTypes.Items.Strings[I]);
    end;
  end;
end;

procedure TUserServiceTypesForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

end.
