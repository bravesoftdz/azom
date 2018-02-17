unit AddApps;

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
  FMX.Ani, FMX.LoadingIndicator, Header, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, System.Actions,
  FMX.ActnList, FMX.TMSBaseControl, FMX.TMSDateTimeEdit, System.JSON, REST.Types;

type
  TFormAddApps = class(TForm)
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
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    BindSourceDB2: TBindSourceDB;
    TimerForLoadLists: TTimer;
    RectanglePropertyRequizites: TRectangle;
    EditCadcode: TEdit;
    EditArea: TEdit;
    EditAddress: TEdit;
    LabelServiceType: TLabel;
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
    RadioButtonVada1: TRadioButton;
    RadioButtonVada3: TRadioButton;
    RadioButtonVada2: TRadioButton;
    CheckBox1: TCheckBox;
    LinkControlToPropertyEnabled: TLinkControlToProperty;
    LinkControlToPropertyEnabled2: TLinkControlToProperty;
    LinkControlToPropertyEnabled3: TLinkControlToProperty;
    HeaderFrame1: THeaderFrame;
    ListBoxServiceTypes: TListBox;
    LinkListControlToField1: TLinkListControlToField;
    LinkPropertyToFieldItemIndex: TLinkPropertyToField;
    LinkFillControlToField1: TLinkFillControlToField;
    RectDialogFinishApp: TRectangle;
    ButtonAppReCreate: TButton;
    Button3: TButton;
    Text1: TText;
    RESTResponseDataSetAdapter1: TRESTResponseDataSetAdapter;
    FDMemTablePage: TFDMemTable;
    FDMemTablePageid: TWideStringField;
    FDMemTablePagetitle: TWideStringField;
    FDMemTablePagecontent: TWideStringField;
    BindSourceDB4: TBindSourceDB;
    LinkPropertyToFieldText: TLinkPropertyToField;
    RectangleFinishMain: TRectangle;
    ActionList1: TActionList;
    ActionAddApp: TAction;
    ListView1: TListView;
    ComboBoxApp_property_types: TComboBox;
    LabelPropertyType: TLabel;
    LinkListControlToField2: TLinkListControlToField;
    FDMemTableTMPApp: TFDMemTable;
    FDMemTableTMPAppid: TWideStringField;
    FDMemTableTMPAppcreate_date: TWideStringField;
    FDMemTableTMPAppdeadlineby_user: TWideStringField;
    FDMemTableTMPAppnote: TWideStringField;
    FDMemTablePropRequz: TFDMemTable;
    TMSFMXDateTimeEdit1: TTMSFMXDateTimeEdit;
    FDMemTableApp_service_typesMem: TFDMemTable;
    FDMemTableApp_service_typesMemtitle: TStringField;
    FDMemTableAppOwner: TFDMemTable;
    FDMemTablePropRequzapp_property_type_name: TStringField;
    FDMemTablePropRequzcadcode: TStringField;
    FDMemTablePropRequzarea: TStringField;
    FDMemTablePropRequzlocation_id: TIntegerField;
    FDMemTablePropRequzaddress: TStringField;
    FDMemTableAppOwnerfull_name: TStringField;
    FDMemTableAppOwneremail: TStringField;
    FDMemTableAppOwnerphone: TStringField;
    FDMemTableTMPAppEmailNotifications: TIntegerField;
    FDMemTableTMPAppDeviceNotifications: TIntegerField;
    FDMemTableApp: TFDMemTable;
    FDMemTableAppid: TWideStringField;
    FDMemTableAppuser_id: TWideStringField;
    FDMemTableAppapp_service_type_name: TWideStringField;
    FDMemTableAppapp_property_type_name: TWideStringField;
    FDMemTableAppcreate_date: TWideStringField;
    FDMemTableAppdeadlineby_user: TWideStringField;
    FDMemTableAppimageIndex: TWideStringField;
    FDMemTableAppusername: TWideStringField;
    FDMemTableAppnote: TWideStringField;
    FDMemTableAppaddress: TWideStringField;
    FDMemTableApparea: TWideStringField;
    FDMemTableAppcadcode: TWideStringField;
    FDMemTableApplocation_id: TWideStringField;
    FDMemTableApplocation_name: TWideStringField;
    FDMemTableApplon_lat: TWideStringField;
    FDMemTableAppstatus_name: TWideStringField;
    FDMemTableAppstatus_color: TWideStringField;
    FDMemTableAppstatus_progress: TWideStringField;
    FDMemTableAppapp_status_id: TWideStringField;
    FDMemTableApplocation_address: TWideStringField;
    BindSourceDBApp: TBindSourceDB;
    LinkListControlToField4: TLinkListControlToField;
    FDMemTablePropRequzapp_property_type_id: TIntegerField;
    RESTRequestApp_property_types: TRESTRequest;
    RESTResponseApp_property_types: TRESTResponse;
    FDMemTablePropRequzfull_name: TStringField;
    FDMemTablePropRequzemail: TStringField;
    FDMemTablePropRequzphone: TStringField;
    FDMemTablePropRequzapp_service_types: TWideStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
    procedure TimerForLoadListsTimer(Sender: TObject);
    procedure ButtonFinishAddingClick(Sender: TObject);
    procedure RESTRequestAddAppAfterExecute(Sender: TCustomRESTRequest);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ButtonNextStep1Click(Sender: TObject);
    procedure ButtonNextStep2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure HeaderFrame1ButtonBackClick(Sender: TObject);
    procedure ComboBoxLocationPopup(Sender: TObject);
    procedure ActionAddAppExecute(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ButtonAppReCreateClick(Sender: TObject);
    procedure RESTRequestApp_property_typesAfterExecute(Sender: TCustomRESTRequest);
  private
  var
    aTask: ITask;
    V_App_service_types: String;
    procedure fillListViewWithOneRecord;
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;

  end;

var
  FormAddApps: TFormAddApps;

implementation

{$R *.fmx}

uses Main, DataModule, map, auth, UserGanmcxadebeliReg;

{ TFormAddApps }

// 1 step of wizzard
procedure TFormAddApps.ButtonNextStep1Click(Sender: TObject);
var
  app_service_type_id, item: string;
begin
  TabItemRequizites.Enabled := True;
  TabControl1.ActiveTab := TabItemRequizites;
  TabItemGeneral.Enabled := False;
  self.PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(TThread.CurrentThread,
        procedure
        var
          I: integer;
        begin
          FDMemTableApp_service_typesMem.Open;
          for I := 0 to ListBoxServiceTypes.Items.Count - 1 do
          begin
            if ListBoxServiceTypes.ListItems[I].IsChecked = True then
            begin
              item := TIdURI.ParamsEncode(ListBoxServiceTypes.Items.Strings[I]);
              V_App_service_types := V_App_service_types + item + '|';
            end;
          end;
          V_App_service_types := V_App_service_types.Remove(V_App_service_types.Length - 1);

          RESTRequestApp_property_types.Params.Clear;
          with RESTRequestApp_property_types.Params.AddItem do
          begin
            name := 'app_service_types';
            Value := V_App_service_types;
          end;
          RESTRequestApp_property_types.Execute;
        end);
    end);
  aTask.Start;
end;

// 2 step of wizzard
procedure TFormAddApps.ButtonNextStep2Click(Sender: TObject);
begin
  if EditCadcode.Text.IsEmpty = True then
  begin
    ShowMessage('გთხოვთ შეავსოთ უძრავი ქონების საკადასტრო კოდი');
    exit;
  end;
  if EditArea.Text.IsEmpty = True then
  begin
    ShowMessage('გთხოვთ შეავსოთ უძრავი ქონების ფართობი');
    exit;
  end;
  if EditAddress.Text.IsEmpty = True then
  begin
    ShowMessage('გთხოვთ შეავსოთ უძრავი ქონების მისამართი');
    exit;
  end;

  TabItemAppOwner.Enabled := True;
  TabControl1.ActiveTab := TabItemAppOwner;
end;

procedure TFormAddApps.ButtonFinishAddingClick(Sender: TObject);
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
    ActionAddApp.Execute;
  end;
end;

// 5 step of wizzard
procedure TFormAddApps.ActionAddAppExecute(Sender: TObject);
var
  I: integer;
begin
  PreloaderRectangle.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      RESTRequestAddApp.Params.Clear;
      // ავტორიზაციის პარამეტრები
      RESTRequestAddApp.Params.AddItem('sesskey', DModule.sesskey);
      RESTRequestAddApp.Params.AddItem('user_id', DModule.id.ToString);
      // ძირითადი ინფორმაციის პარამეტრები
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
        if RadioButtonVada1.IsChecked = True then
          Value := '1'
        else if RadioButtonVada2.IsChecked = True then
          Value := '4'
        else if RadioButtonVada3.IsChecked = True then
          Value := '7'
        else
          Value := '0';
      end;
      with RESTRequestAddApp.Params.AddItem do
      begin
        name := 'note';
        Value := TIdURI.ParamsEncode(MemoNote.Text);
      end;
      // მომსახურების ტიპები
      FDMemTableApp_service_typesMem.First;
      while not FDMemTableApp_service_typesMem.Eof do
      begin
        RESTRequestAddApp.Params.AddItem('app_service_types[]', FDMemTableApp_service_typesMem.FieldByName('title')
          .AsString);
        FDMemTableApp_service_typesMem.Next;
      end;

      // ქონების რეკვიზიტები
      I := 0;
      FDMemTablePropRequz.First;
      while not FDMemTablePropRequz.Eof do
      begin

        RESTRequestAddApp.Params.AddItem('PropRequz[' + I.ToString + '][app_service_types]',
          FDMemTablePropRequz.FieldByName('app_service_types').AsString);
        RESTRequestAddApp.Params.AddItem('PropRequz[' + I.ToString + '][app_property_type_id]',
          FDMemTablePropRequz.FieldByName('app_property_type_id').AsString);
        RESTRequestAddApp.Params.AddItem('PropRequz[' + I.ToString + '][cadcode]',
          FDMemTablePropRequz.FieldByName('cadcode').AsString);
        RESTRequestAddApp.Params.AddItem('PropRequz[' + I.ToString + '][area]', FDMemTablePropRequz.FieldByName('area')
          .AsString);
        RESTRequestAddApp.Params.AddItem('PropRequz[' + I.ToString + '][location_id]',
          FDMemTablePropRequz.FieldByName('location_id').AsString);
        RESTRequestAddApp.Params.AddItem('PropRequz[' + I.ToString + '][address]',
          FDMemTablePropRequz.FieldByName('address').AsString);
        {
          RESTRequestAddApp.Params.AddItem('lon_lat', TIdURI.ParamsEncode(DModule.MyPosition.Latitude.ToString + ',' +
          DModule.MyPosition.Longitude.ToString));
        }

        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'PropRequz[' + I.ToString + '][full_name]';
          Value := FDMemTablePropRequz.FieldByName('full_name').AsString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'PropRequz[' + I.ToString + '][phone]';
          Value := FDMemTablePropRequz.FieldByName('phone').AsString;
        end;
        with RESTRequestAddApp.Params.AddItem do
        begin
          name := 'PropRequz[' + I.ToString + '][email]';
          Value := FDMemTablePropRequz.FieldByName('email').AsString;
        end;

        I := I + 1;
        FDMemTablePropRequz.Next;
      end;
      // დამკვეთის რეკვიზიტები

      RESTRequestAddApp.Execute;

      // ShowMessage(RESTResponseAddApp.Content);
    end);
  aTask.Start;
end;

procedure TFormAddApps.fillListViewWithOneRecord;
var
  listviewitem: TListViewItem;
  I: integer;
begin
  // set listview item
  FDMemTablePropRequz.Open;
  FDMemTablePropRequz.Insert;
  FDMemTablePropRequz.FieldByName('app_service_types').AsString := V_App_service_types;
  FDMemTablePropRequz.FieldByName('app_property_type_id').AsInteger := FDMemTableApp_property_types.FieldByName('id')
    .AsInteger;
  FDMemTablePropRequz.FieldByName('app_property_type_name').AsString :=
    FDMemTableApp_property_types.FieldByName('title').AsString;
  FDMemTablePropRequz.FieldByName('cadcode').AsString := EditCadcode.Text;
  FDMemTablePropRequz.FieldByName('area').AsString := EditArea.Text;
  FDMemTablePropRequz.FieldByName('location_id').AsInteger := FDMemTableLocations.FieldByName('id').AsInteger;
  FDMemTablePropRequz.FieldByName('address').AsString := TIdURI.ParamsEncode(EditAddress.Text);

  if self.CheckBox1.IsChecked = True then
  begin
    FDMemTablePropRequz.FieldByName('full_name').AsString := TIdURI.ParamsEncode(EditUserParamsFullname.Text);
    FDMemTablePropRequz.FieldByName('email').AsString := TIdURI.ParamsEncode(EditUserParamsEmail.Text);
    FDMemTablePropRequz.FieldByName('phone').AsString := TIdURI.ParamsEncode(EditUserParamsPhone.Text);
  end
  else
  begin
    FDMemTablePropRequz.FieldByName('full_name').AsString := TIdURI.ParamsEncode(DModule.full_name);
    FDMemTablePropRequz.FieldByName('email').AsString := TIdURI.ParamsEncode(DModule.email);
    FDMemTablePropRequz.FieldByName('phone').AsString := TIdURI.ParamsEncode(DModule.phone);
  end;

  FDMemTablePropRequz.Post;

  V_App_service_types:='';

  FDMemTableApp.Open;
  if FDMemTableApp.RecordCount = 0 then
  begin
    with FDMemTableApp do
    begin
      Insert;
      FieldByName('app_property_type_name').AsString := FDMemTableApp_property_types.FieldByName('title').AsString;
      FieldByName('location_address').AsString := FDMemTableLocations.FieldByName('title').AsString;
      FieldByName('area').AsString := EditArea.Text;
      FieldByName('address').AsString := EditAddress.Text;
      Post;
    end;
  end
  else
  begin
    with FDMemTableApp do
    begin
      Edit;
      FieldByName('app_property_type_name').AsString := FieldByName('app_property_type_name').AsString + ', ' +
        FDMemTableApp_property_types.FieldByName('title').AsString;
      FieldByName('area').AsString := FieldByName('area').AsString + ', ' + EditArea.Text;
      FieldByName('address').AsString := FieldByName('address').AsString + ', ' + EditAddress.Text;
      Post;
    end;
  end;
  // HeaderFrame1.LabelAppName.Text := FDMemTableApp.RecordCount.ToString;
end;

procedure TFormAddApps.Button1Click(Sender: TObject);
begin
  TabItemFinish.Enabled := True;
  TabControl1.ActiveTab := TabItemFinish;
  self.fillListViewWithOneRecord;
end;

procedure TFormAddApps.Button3Click(Sender: TObject);
begin
  // ActionAddApp.Execute;
  RectDialogFinishApp.Visible := False;
end;

procedure TFormAddApps.ButtonAppReCreateClick(Sender: TObject);
var
  I: integer;
begin
  FDMemTableApp_property_types.First;
  EditCadcode.Text := '';
  EditArea.Text := '';
  FDMemTableLocations.First;
  EditAddress.Text := '';
  ComboBoxLocation.Enabled := False;
  for I := 0 to ListBoxServiceTypes.Items.Count - 1 do
  begin
    ListBoxServiceTypes.ListItems[I].IsChecked := False;
  end;
  TabItemGeneral.Enabled := True;
  TabControl1.ActiveTab := TabItemGeneral;
end;

// 4 step of wizzard
procedure TFormAddApps.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TFormAddApps.HeaderFrame1ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TFormAddApps.ComboBoxLocationPopup(Sender: TObject);
begin
  // ShowMessage(FDMemTableLocations.FieldByName('title').AsString);
end;

procedure TFormAddApps.initForm;
begin
  self.Show;
  PreloaderRectangle.Visible := True;
  TimerForLoadLists.Enabled := True;

  self.EditUserParamsFullname.Text := DModule.full_name;
  self.EditUserParamsEmail.Text := DModule.email;
  self.EditUserParamsPhone.Text := DModule.phone;
  CheckBox1.IsChecked := False;

  self.EditUserParamsFullname.Enabled := False;
  self.EditUserParamsEmail.Enabled := False;
  self.EditUserParamsPhone.Enabled := False;
end;

procedure TFormAddApps.RESTRequestAddAppAfterExecute(Sender: TCustomRESTRequest);
begin
  PreloaderRectangle.Visible := False;
  if RESTResponseAddApp.Content = 'ok' then
  begin
    ShowMessage('განცხადება დაემატა წარმატებით');
    self.Close;
  end
  else
    MemoNote.Text := RESTResponseAddApp.Content;
end;

procedure TFormAddApps.RESTRequestApp_property_typesAfterExecute(Sender: TCustomRESTRequest);
begin
  PreloaderRectangle.Visible := False;
end;

procedure TFormAddApps.RESTRequestListsAfterExecute(Sender: TCustomRESTRequest);
begin
  PreloaderRectangle.Visible := False;
end;

procedure TFormAddApps.SpeedButton1Click(Sender: TObject);
begin
  with TmapViewForm.Create(Application) do
  begin
    initForm;
  end;
end;

procedure TFormAddApps.TimerForLoadListsTimer(Sender: TObject);
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
