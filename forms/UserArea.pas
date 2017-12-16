unit UserArea;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.Edit, FMX.StdCtrls, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, REST.Response.Adapter, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, System.Threading, FMX.Objects, System.Rtti, System.Bindings.Outputs, FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  Data.Bind.DBScope, System.UIConsts, IdURI;

type
  TUserAreaForm = class(TForm)
    EditFname: TEdit;
    EditLname: TEdit;
    EditPhone: TEdit;
    EditEmail: TEdit;
    Button1: TButton;
    RESTRequestUserDetails: TRESTRequest;
    RESTResponseUserDetails: TRESTResponse;
    RESTResponseDataSetAdapterUserDetails: TRESTResponseDataSetAdapter;
    FDMemTableUserDetails: TFDMemTable;
    RectanglePreloader: TRectangle;
    AniIndicator1: TAniIndicator;
    RectangleMain: TRectangle;
    RectangleHeader: TRectangle;
    ButtonBack: TButton;
    Label1: TLabel;
    FDMemTableUserDetailsid: TWideStringField;
    FDMemTableUserDetailsuser_type_id: TWideStringField;
    FDMemTableUserDetailsuser_status_id: TWideStringField;
    FDMemTableUserDetailsfname: TWideStringField;
    FDMemTableUserDetailslname: TWideStringField;
    FDMemTableUserDetailsphone: TWideStringField;
    FDMemTableUserDetailsemail: TWideStringField;
    FDMemTableUserDetailscreate_date: TWideStringField;
    FDMemTableUserDetailsmodify_date: TWideStringField;
    FDMemTableUserDetailsregipaddr: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    RESTRequestSet: TRESTRequest;
    RESTResponseSet: TRESTResponse;
    RESTResponseDataSetAdapterSet: TRESTResponseDataSetAdapter;
    FDMemTableSet: TFDMemTable;
    FDMemTableSetcolor: TStringField;
    FDMemTableSetmsg: TWideStringField;
    procedure RESTRequestUserDetailsAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
    procedure RESTRequestSetAfterExecute(Sender: TCustomRESTRequest);
    procedure ButtonBackClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure loadUserDetails;
    { Private declarations }
  public
    { Public declarations }
    procedure initForm;
  end;

var
  UserAreaForm: TUserAreaForm;

implementation

{$R *.fmx}

uses DataModule, Main;
{ TUserAreaForm }

procedure TUserAreaForm.Button1Click(Sender: TObject);
var
  aTask: ITask;
begin
  RectanglePreloader.Visible := True;
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestSet.Params.Clear;
          with RESTRequestSet.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestSet.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;

          with RESTRequestSet.Params.AddItem do
          begin
            name := 'fname';
            Value := TIdURI.ParamsEncode(EditFname.Text);
          end;
          with RESTRequestSet.Params.AddItem do
          begin
            name := 'lname';
            Value := TIdURI.ParamsEncode(EditLname.Text);
          end;
          with RESTRequestSet.Params.AddItem do
          begin
            name := 'email';
            Value := EditEmail.Text;
          end;
          with RESTRequestSet.Params.AddItem do
          begin
            name := 'phone';
            Value := EditPhone.Text;
          end;
          with RESTRequestSet.Params.AddItem do
          begin
            name := 'op';
            Value := 'save';
          end;
          RESTRequestSet.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUserAreaForm.ButtonBackClick(Sender: TObject);
begin
  self.Close;
end;

procedure TUserAreaForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := TCloseAction.caFree;
end;

procedure TUserAreaForm.initForm;
begin
  self.Show;
  RectanglePreloader.Visible := True;
  self.loadUserDetails;
end;

procedure TUserAreaForm.loadUserDetails;
var
  aTask: ITask;
begin
  aTask := TTask.Create(
    procedure()
    begin
      TThread.Synchronize(nil,
        procedure
        begin
          self.RESTRequestUserDetails.Params.Clear;
          with RESTRequestUserDetails.Params.AddItem do
          begin
            name := 'sesskey';
            Value := DModule.sesskey;
          end;
          with RESTRequestUserDetails.Params.AddItem do
          begin
            name := 'user_id';
            Value := DModule.id.ToString;
          end;
          self.RESTRequestUserDetails.Execute;
        end);
    end);
  aTask.Start;
end;

procedure TUserAreaForm.RESTRequestSetAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

procedure TUserAreaForm.RESTRequestUserDetailsAfterExecute(Sender: TCustomRESTRequest);
begin
  RectanglePreloader.Visible := False;
end;

end.
