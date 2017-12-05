unit UserRegistration;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, FMX.StdCtrls, FMX.Ani,
  FMX.Controls.Presentation, FMX.Edit, FMX.Objects, System.IOUtils, System.Threading, IdURI, FMX.Layouts, FMX.TreeView,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, REST.Response.Adapter, System.JSON, FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.DBScope;

type
  TRegForm = class(TForm)
    RectangleMain: TRectangle;
    NameEdit: TEdit;
    LnameEdit: TEdit;
    EmailEdit: TEdit;
    FloatAnimationEmailReg: TFloatAnimation;
    PhoneEdit: TEdit;
    PasswordEdit: TEdit;
    CPasswordEdit: TEdit;
    RegButton: TButton;
    RESTRequestReg: TRESTRequest;
    RESTResponseReg: TRESTResponse;
    RectangleLocation: TRectangle;
    FloatAnimation1: TFloatAnimation;
    FloatAnimation2: TFloatAnimation;
    RESTRequestLocation: TRESTRequest;
    RESTResponseLocation: TRESTResponse;
    RESTResponseDataSetAdapterL: TRESTResponseDataSetAdapter;
    FDMemTableL: TFDMemTable;
    ListBoxLocationsMaster: TListBox;
    FDMemTableLid: TWideStringField;
    FDMemTableLpid: TWideStringField;
    FDMemTableLtitle: TWideStringField;
    FDMemTableLmap_title: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    RectangleDetail: TRectangle;
    ListBoxDetails: TListBox;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    LabelAppName: TLabel;
    RESTRequestLocationDetails: TRESTRequest;
    RESTResponseLocationDetails: TRESTResponse;
    RESTResponseDataSetAdapterLocationDetails: TRESTResponseDataSetAdapter;
    FDMemTableLocationDetails: TFDMemTable;
    RectanglePreloader: TRectangle;
    AniIndicator1: TAniIndicator;
    Button1: TButton;
    LinkPropertyToFieldText: TLinkPropertyToField;
    RESTRequestSetLocations: TRESTRequest;
    RESTResponseDataSetAdapterResult: TRESTResponseDataSetAdapter;
    FDMemTableResult: TFDMemTable;
    procedure RegButtonClick(Sender: TObject);
    procedure ListBoxLocationsMasterItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
    procedure RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure ButtonBackClick(Sender: TObject);
    procedure ListBoxLocationsMasterChangeCheck(Sender: TObject);
    procedure ListBoxDetailsChangeCheck(Sender: TObject);
    procedure RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
    procedure FloatAnimation1Finish(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    v_detailRequestId: integer;
    locationsSL, locationsSLDetails: TStringList;
    procedure initForm;
  end;

var
  RegForm: TRegForm;

implementation

{$R *.fmx}

uses DataModule, Main;

procedure TRegForm.Button1Click(Sender: TObject);
var
  I: integer;
  aTask: ITask;
  names: string;
begin
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

procedure TRegForm.ButtonBackClick(Sender: TObject);
begin
  if RectangleDetail.Visible = True then
    RectangleDetail.Visible := False;
end;

procedure TRegForm.FloatAnimation1Finish(Sender: TObject);
begin
  RectangleLocation.Visible := True;
end;

procedure TRegForm.initForm;
begin
  self.Show;
  self.RESTRequestLocation.Execute;
  self.v_detailRequestId := 0;
  locationsSL := TStringList.Create;
  locationsSLDetails := TStringList.Create;
end;

procedure TRegForm.ListBoxDetailsChangeCheck(Sender: TObject);
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

procedure TRegForm.ListBoxLocationsMasterChangeCheck(Sender: TObject);
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

procedure TRegForm.ListBoxLocationsMasterItemClick(const Sender: TCustomListBox; const Item: TListBoxItem);
var
  aTask: ITask;
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
            RESTRequestLocationDetails.Execute;
          end);
      end);
    aTask.Start;
  end;
end;

procedure TRegForm.RegButtonClick(Sender: TObject);
var
  password: string;
  aTask: ITask;
begin
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
            Value := '2'
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

procedure TRegForm.RESTRequestLocationDetailsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

procedure TRegForm.RESTRequestRegAfterExecute(Sender: TCustomRESTRequest);
begin
  if FDMemTableResult.FieldByName('loginstatus').AsInteger = 1 then
  begin
    DModule.id := FDMemTableResult.FieldByName('id').AsInteger;
    DModule.user_type_id := FDMemTableResult.FieldByName('user_type_id').AsInteger;
    DModule.fname := FDMemTableResult.FieldByName('fname').AsString;
    DModule.lname := FDMemTableResult.FieldByName('lname').AsString;
    DModule.phone := FDMemTableResult.FieldByName('phone').AsString;
    DModule.email := FDMemTableResult.FieldByName('email').AsString;
    DModule.sesskey := FDMemTableResult.FieldByName('sesskey').AsString;
    MainForm.DoAuthenticate;
    self.RectangleMain.Visible := False;
  end;
end;

end.
