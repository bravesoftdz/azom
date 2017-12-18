unit UserNotifications;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.ListView.Types, FMX.ListView.Appearances, FMX.ListView.Adapters.Base,
  FMX.ListView, FMX.StdCtrls, FMX.Controls.Presentation, FMX.Objects, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Threading, Data.Bind.EngExt, Fmx.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs,
  Fmx.Bind.Editors, Data.Bind.DBScope, FMX.Ani;

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
    FDMemTableNotificationsid: TWideStringField;
    FDMemTableNotificationsuser_id: TWideStringField;
    FDMemTableNotificationsnotification_type_id: TWideStringField;
    FDMemTableNotificationstitle: TWideStringField;
    FDMemTableNotificationsdescription: TWideStringField;
    FDMemTableNotificationsfire_time: TWideStringField;
    FDMemTableNotificationsexecuted: TWideStringField;
    FDMemTableNotificationsaction_id: TWideStringField;
    FDMemTableNotificationscreate_date: TWideStringField;
    FDMemTableNotificationsexecuted_date: TWideStringField;
    FDMemTableNotificationsnotification_type_name: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkListControlToField1: TLinkListControlToField;
    LabelLoading: TLabel;
    ProgressBar1: TProgressBar;
    FloatAnimationPreloader: TFloatAnimation;
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RESTRequestNotificationsAfterExecute(Sender: TCustomRESTRequest);
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

uses DataModule;
{ TUserNotificationsForm }

procedure TUserNotificationsForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUserNotificationsForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
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

procedure TUserNotificationsForm.RESTRequestNotificationsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

end.

