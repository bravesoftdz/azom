unit AddApp;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FMX.Objects,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Client,
  REST.Response.Adapter, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FMX.ListBox, Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti,
  System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.DBScope, FMX.ScrollBox,
  FMX.Memo, FMX.Layouts, FMX.TabControl, System.Threading, FMX.Types, IdURI,
  FMX.Ani, FMX.LoadingIndicator, Header;

type
  TFormAddApp = class(TForm)
    ButtonFinishAdding: TButton;
    RectangleMain: TRectangle;
    PreloaderRectangle: TRectangle;
    RESTRequestLists: TRESTRequest;
    RESTResponseLists: TRESTResponse;
    RESTResponseDataSetAdapterST: TRESTResponseDataSetAdapter;
    RESTResponseDataSetAdapterPT: TRESTResponseDataSetAdapter;
    FDMemTableApp_property_types: TFDMemTable;
    FDMemTableApp_service_types: TFDMemTable;
    FDMemTableApp_property_typesid: TWideStringField;
    FDMemTableApp_property_typestitle: TWideStringField;
    FDMemTableApp_service_typesid: TWideStringField;
    FDMemTableApp_service_typestitle: TWideStringField;
    ComboBoxApp_property_types: TComboBox;
    ComboBoxApp_service_types: TComboBox;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    BindSourceDB2: TBindSourceDB;
    LinkListControlToField2: TLinkListControlToField;
    TimerForLoadLists: TTimer;
    RectanglePropertyRequizites: TRectangle;
    EditCadcode: TEdit;
    EditArea: TEdit;
    EditAddress: TEdit;
    LabelServiceType: TLabel;
    LabelPropertyType: TLabel;
    RESTRequestAddApp: TRESTRequest;
    RESTResponseAddApp: TRESTResponse;
    ComboBoxLocation: TComboBox;
    RESTResponseDataSetAdapterLoc: TRESTResponseDataSetAdapter;
    FDMemTableLocations: TFDMemTable;
    FDMemTableLocationsid: TWideStringField;
    FDMemTableLocationstitle: TWideStringField;
    FDMemTableLocationsmap_title: TWideStringField;
    BindSourceDB3: TBindSourceDB;
    LinkListControlToField3: TLinkListControlToField;
    SpeedButton1: TSpeedButton;
    TabControl1: TTabControl;
    TabItemGeneral: TTabItem;
    TabItemRequizites: TTabItem;
    TabItemFinish: TTabItem;
    ButtonNextStep1: TButton;
    ButtonNextStep2: TButton;
    ComboBox1: TComboBox;
    Label2: TLabel;
    MemoNote: TMemo;
    RESTResponseDataSetAdapterAddApp: TRESTResponseDataSetAdapter;
    FDMemTableAddApp: TFDMemTable;
    FDMemTableAddAppstatus: TWideStringField;
    FDMemTableAddAppmsg: TWideStringField;
    TabItemAppOwner: TTabItem;
    Button1: TButton;
    Rectangle1: TRectangle;
    EditUserParamsFullname: TEdit;
    EditUserParamsPhone: TEdit;
    EditUserParamsEmail: TEdit;
    CheckBoxDeviceNotifications: TCheckBox;
    CheckBoxEmailNotifications: TCheckBox;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    CheckBox1: TCheckBox;
    LinkControlToPropertyEnabled: TLinkControlToProperty;
    LinkControlToPropertyEnabled2: TLinkControlToProperty;
    LinkControlToPropertyEnabled3: TLinkControlToProperty;
    HeaderFrame1: THeaderFrame;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
    procedure TimerForLoadListsTimer(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ButtonFinishAddingClick(Sender: TObject);
    procedure RESTRequestAddAppAfterExecute(Sender: TCustomRESTRequest);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ButtonNextStep1Click(Sender: TObject);
    procedure ButtonNextStep2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure ComboBoxApp_service_typesChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  FormAddApp: TFormAddApp;

implementation

{$R *.fmx}

uses Main, DataModule, map, auth, UserGanmcxadebeliReg;

{ TFormAddApp }

procedure TFormAddApp.ButtonFinishAddingClick(Sender: TObject);
var
  aTask: ITask;
begin
  // განცხადების დამატება
  if DModule.sesskey.IsEmpty = True then
  begin
    with TGanmcxadeblisRegForm.Create(Application) do
    begin
      closeAfterReg := True;
      initForm;
    end;
  end
  else
  begin
    PreloaderRectangle.Visible := True;
    aTask := TTask.Create(
      procedure()
      begin
        TThread.Synchronize(TThread.CurrentThread,
          procedure
          begin
            RESTRequestAddApp.Params.Clear;
            // ავტორიზაციის პარამეტრები
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'sesskey';
              Value := DModule.sesskey;
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'user_id';
              Value := DModule.id.ToString;
            end;
            // ძირითადი ინფორმაციის პარამეტრები
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'app_service_type_id';
              Value := FDMemTableApp_service_types.FieldByName('id').AsString;
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'app_property_type_id';
              Value := FDMemTableApp_property_types.FieldByName('id').AsString;
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'notification_on_device';
              if CheckBoxDeviceNotifications.IsChecked = True then
                Value := '1'
              else
                Value := '0';
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'notification_on_email';
              if CheckBoxEmailNotifications.IsChecked = True then
                Value := '1'
              else
                Value := '0';
            end;

            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'deadlineby_user';
              Value := id.ToString;
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'note';
              Value := TIdURI.ParamsEncode(MemoNote.Text);
            end;
            // ქონების რეკვიზიტები
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'cadcode';
              Value := TIdURI.ParamsEncode(EditCadcode.Text);
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'area';
              Value := TIdURI.ParamsEncode(EditArea.Text);
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'location_id';
              Value := FDMemTableLocations.FieldByName('id').AsString;
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'address';
              Value := TIdURI.ParamsEncode(EditAddress.Text);
            end;
            with RESTRequestAddApp.Params.AddItem do
            begin
              name := 'lon_lat';
              Value := TIdURI.ParamsEncode(DModule.MyPosition.Latitude.ToString + ',' + DModule.MyPosition.Longitude.ToString);
            end;
            // დამკვეთის რეკვიზიტები
            if self.CheckBox1.IsChecked = True then
            begin
              with RESTRequestAddApp.Params.AddItem do
              begin
                name := 'full_name';
                Value := TIdURI.ParamsEncode(EditUserParamsFullname.Text);
              end;
              with RESTRequestAddApp.Params.AddItem do
              begin
                name := 'phone';
                Value := TIdURI.ParamsEncode(EditUserParamsPhone.Text);
              end;
              with RESTRequestAddApp.Params.AddItem do
              begin
                name := 'email';
                Value := TIdURI.ParamsEncode(EditUserParamsEmail.Text);
              end;
            end;
            RESTRequestAddApp.Execute;
          end);
      end);
    aTask.Start;
  end;
end;

procedure TFormAddApp.ButtonCloseClick(Sender: TObject);
begin
  self.Close;
end;

// 1 step of wizzard
procedure TFormAddApp.ButtonNextStep1Click(Sender: TObject);
begin
  TabItemRequizites.Enabled := True;
  TabControl1.ActiveTab := TabItemRequizites;
end;

// 2 step of wizzard
procedure TFormAddApp.ButtonNextStep2Click(Sender: TObject);
begin
  TabItemAppOwner.Enabled := True;
  TabControl1.ActiveTab := TabItemAppOwner;
end;

procedure TFormAddApp.ComboBoxApp_service_typesChange(Sender: TObject);
var
  aTask: ITask;
  app_service_type_id: string;
begin
  {
    self.PreloaderRectangle.Visible := True;
    app_service_type_id := FDMemTableApp_service_types.FieldByName('id').AsString;
    aTask := TTask.Create(
    procedure()
    begin
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
    RESTRequestLists.Params.Clear;
    with RESTRequestLists.Params.AddItem do
    begin
    name := 'app_service_type_id';
    Value := app_service_type_id;
    end;
    RESTRequestLists.Execute;
    end);
    end);
    aTask.Start;
  }
end;

// 3 step of wizzard
procedure TFormAddApp.Button1Click(Sender: TObject);
begin
  TabItemFinish.Enabled := True;
  TabControl1.ActiveTab := TabItemFinish;
end;

// 4 step of wizzard
procedure TFormAddApp.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormAddApp.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormAddApp.initForm;
begin
  PreloaderRectangle.Visible := True;
  self.Show;
  TimerForLoadLists.Enabled := True;

  self.EditUserParamsFullname.Text := DModule.full_name;
  self.EditUserParamsEmail.Text := DModule.email;
  self.EditUserParamsPhone.Text := DModule.phone;
  CheckBox1.IsChecked := False;

  self.EditUserParamsFullname.Enabled := False;
  self.EditUserParamsEmail.Enabled := False;
  self.EditUserParamsPhone.Enabled := False;
end;

procedure TFormAddApp.RESTRequestAddAppAfterExecute(Sender: TCustomRESTRequest);
begin
  PreloaderRectangle.Visible := False;
  // MemoNote.Text := RESTResponseAddApp.Content;
  if FDMemTableAddApp.FieldByName('status').AsString = 'ok' then
  begin
    ShowMessage('განცხადება დაემატა წარმატებით');
    self.Close;
  end;
end;

procedure TFormAddApp.RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
var
  i: integer;
begin
  PreloaderRectangle.Visible := False;
  for i := 0 to ComboBoxApp_property_types.Count - 1 do
  begin
    ComboBoxApp_property_types.ListItems[i].TextSettings.Font.Size := 10;
  end;

  for i := 0 to ComboBoxApp_service_types.Count - 1 do
  begin
    ComboBoxApp_service_types.ListItems[i].Font.Size := 10;
  end;
end;

procedure TFormAddApp.SpeedButton1Click(Sender: TObject);
begin
  with TmapViewForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TFormAddApp.TimerForLoadListsTimer(Sender: TObject);
var
  aTask: ITask;
begin
  TimerForLoadLists.Enabled := False;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        begin
          RESTRequestLists.Params.Clear;
          RESTRequestLists.Execute;
        end);
    end);
  aTask.Start;
end;

end.
