unit UserNotifications;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Threading,
  Data.Bind.EngExt, FMX.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.DBScope, FMX.Ani, FMX.Layouts,
  FMX.LoadingIndicator;

type
  TUserNotificationsForm = class(TForm)
    ListView1: TListView;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    LabelAppName: TLabel;
    RESTRequestNotifications: TRESTRequest;
    RESTResponseNotifications: TRESTResponse;
    RESTResponseDataSetAdapterNotifications: TRESTResponseDataSetAdapter;
    FDMemTableNotifications: TFDMemTable;
    RectanglePreloader: TRectangle;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    FMXLoadingIndicator1: TFMXLoadingIndicator;
    FDMemTableNotificationsid: TWideStringField;
    FDMemTableNotificationsapp_id: TWideStringField;
    FDMemTableNotificationsuser_id: TWideStringField;
    FDMemTableNotificationsoffer_user_id: TWideStringField;
    FDMemTableNotificationsoffer_full_name: TWideStringField;
    FDMemTableNotificationsnotification_type_id: TWideStringField;
    FDMemTableNotificationstitle: TWideStringField;
    FDMemTableNotificationsdescription: TWideStringField;
    FDMemTableNotificationsfire_time: TWideStringField;
    FDMemTableNotificationsexecuted: TWideStringField;
    FDMemTableNotificationsaction_id: TWideStringField;
    FDMemTableNotificationscreate_date: TWideStringField;
    FDMemTableNotificationsexecuted_date: TWideStringField;
    FDMemTableNotificationsresponse: TWideStringField;
    FDMemTableNotificationsnotification_type_name: TWideStringField;
    FDMemTableNotificationsformAction: TWideStringField;
    FDMemTableNotificationsdeviceToken: TWideStringField;
    FDMemTableNotificationsdeviceID: TWideStringField;
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestNotificationsAfterExecute(Sender: TCustomRESTRequest);
    procedure ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
    procedure FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  UserNotificationsForm: TUserNotificationsForm;

implementation

{$R *.fmx}

uses DataModule, User2Review, AppDetails, MyAppDetails;
{ TUserNotificationsForm }

procedure TUserNotificationsForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUserNotificationsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TUserNotificationsForm.FormKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char; Shift: TShiftState);
begin
  if Key = 137 then
    self.Free;
end;

procedure TUserNotificationsForm.initForm;
var
  aTask: ITask;
begin
  self.Show;
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          RESTRequestNotifications.Params.Clear;
          with RESTRequestNotifications.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestNotifications.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          self.RESTRequestNotifications.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUserNotificationsForm.ListView1ItemClick(const Sender: TObject; const AItem: TListViewItem);
var
  formAction: String;
begin
  formAction := self.FDMemTableNotifications.FieldByName('formAction').AsString;
  if formAction.Length > 0 then
  begin
    if formAction = 'TUser2ReviewForm' then
    begin
      if self.FDMemTableNotifications.FieldByName('offer_user_id').AsInteger > 0 then
      begin
        with TUser2ReviewForm.Create(Application) do
        begin
          v_user_FullName := self.FDMemTableNotifications.FieldByName('offer_full_name').AsString;
          initForm(self.FDMemTableNotifications.FieldByName('offer_user_id').AsInteger);
        end;
      end;
    end
    else if formAction = 'TAppDetailForm' then
    begin
      if self.FDMemTableNotifications.FieldByName('app_id').AsInteger > 0 then
      begin
        with TMyAppDetailsForm.Create(Application) do
        begin
          app_id := self.FDMemTableNotifications.FieldByName('app_id').AsInteger;
          initForm;
        end;
      end;
    end;
  end;
end;

procedure TUserNotificationsForm.RESTRequestNotificationsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

end.
