program azomvabgservice;

uses
  System.Android.ServiceApplication,
  serviceUnit in 'serviceUnit.pas' {DM: TAndroidService};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
