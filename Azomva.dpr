program Azomva;

uses
  System.StartUpCopy,
  FMX.Forms,
  Main in 'Main.pas' {MainForm},
  auth in 'auth.pas' {authForm},
  UserArea in 'forms\UserArea.pas' {UserAreaForm},
  MyApps in 'forms\MyApps.pas' {FormMyApps},
  DataModule in 'DataModule.pas' {DModule: TDataModule},
  HelperUnit in 'HelperUnit.pas',
  AddApp in 'forms\AddApp.pas' {FormAddApp},
  AppDetails in 'forms\AppDetails.pas' {AppDetailForm},
  BidUnit in 'forms\BidUnit.pas' {BidForm},
  map in 'forms\map.pas' {mapViewForm},
  MyAppDetails in 'forms\MyAppDetails.pas' {MyAppDetailsForm},
  BidsByApp in 'forms\BidsByApp.pas' {BidsByAppForm},
  AppList in 'forms\AppList.pas' {AppListForm},
  serviceUnit in 'AndroidServiceApp\serviceUnit.pas' {DM: TAndroidService};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDModule, DModule);
  Application.Run;
end.
