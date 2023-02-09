program Test1;

uses
  Vcl.Forms,
  Test in 'Test.pas' {Testing},
  MyThread in 'MyThread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTesting, Testing);
  Application.Run;
end.
