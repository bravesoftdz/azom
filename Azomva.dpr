program Azomva;

uses
  FMX.Forms,
  FMX.Types,
  Main in 'Main.pas' {MainForm},
  auth in 'auth.pas' {authForm},
  UserArea in 'forms\UserArea.pas' {UserAreaForm},
  MyApps in 'forms\MyApps.pas' {FormMyApps},
  HelperUnit in 'HelperUnit.pas',
  AddApp in 'forms\AddApp.pas' {FormAddApp},
  AppDetails in 'forms\AppDetails.pas' {AppDetailForm},
  map in 'forms\map.pas' {mapViewForm},
  MyAppDetails in 'forms\MyAppDetails.pas' {MyAppDetailsForm},
  BidsByApp in 'forms\BidsByApp.pas' {BidsByAppForm},
  AppList in 'forms\AppList.pas' {AppListForm},
  DataModule in 'DataModule.pas' {DModule: TDataModule},
  UserAmzomveliReg in 'forms\UserAmzomveliReg.pas' {UserAmzomveliRegForm},
  UserLocations in 'forms\UserLocations.pas' {UserLocationsForm},
  UserNotifications in 'forms\UserNotifications.pas' {UserNotificationsForm},
  UserServiceTypes in 'forms\UserServiceTypes.pas' {UserServiceTypesForm},
  User1Review in 'forms\User1Review.pas' {User1ReviewForm},
  User2Review in 'forms\User2Review.pas' {User2ReviewForm: TFrame},
  Header in 'Frames\Header.pas' {HeaderFrame: TFrame},
  UserGanmcxadebeliReg in 'forms\UserGanmcxadebeliReg.pas' {GanmcxadeblisRegForm},
  User2ListFR in 'Frames\User2ListFR.pas' {User2ListFrame: TFrame},
  MyContracts in 'forms\MyContracts.pas' {MyContractsForm},
  AddApps in 'forms\AddApps.pas' {FormAddApps},
  AddAppRequizitesFR in 'Frames\AddAppRequizitesFR.pas' {AddAppRequizitesFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  //VKAutoShowMode := TVKAutoShowMode.Always;
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TDModule, DModule);
  Application.CreateForm(TMyContractsForm, MyContractsForm);
  Application.Run;

end.
