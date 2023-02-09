unit MyThread;

interface

uses
  System.SysUtils,SyncObjs,Classes;
type
  TMyThread1 = class(TThread)
  private
    { Private declarations }
  public
    { Public declarations }
   procedure RecorR;
protected
procedure Execute; override;
  end;

type
  TMyThread2 = class(TThread)
  private
    { Private declarations }
   procedure RecorR;
  public
    { Public declarations }
protected
procedure Execute; override;
  end;

var
  i:integer;

implementation

  uses Test;

{ MyThread }

procedure TMyThread1.RecorR;
begin
  Event.WaitFor(INFINITE);
  Event.ResetEvent;
  Testing.recordR(i,1);
  inc(i);
  Event.SetEvent;
end;

procedure TMyThread2.RecorR;
begin
  Event.WaitFor(INFINITE);
  Event.ResetEvent;
  Testing.recordR(i,2);
  inc(i);
  Event.SetEvent;
end;

procedure TMyThread1.Execute;
begin
  inherited;
  while not terminated do
    RecorR;
end;

procedure TMyThread2.Execute;
begin
  inherited;
  while not terminated do
    RecorR;
end;

end.
