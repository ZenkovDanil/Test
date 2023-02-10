unit Test;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,SyncObjs, MyThread;

type
  TTesting = class(TForm)
    btMagic: TButton;
    procedure btMagicClick(Sender: TObject);
  private
    Thread1: TMyThread1;
    Thread2: TMyThread2;
    { Private declarations }
function fProst(i:integer):boolean;
  public
    { Public declarations }
procedure recordR(i,pot:integer);
  end;

var
  Testing: TTesting;
  fResult:TextFile;
  fThread1:TextFile;
  fThread2:TextFile;
  Event: TEvent;
  path: string;

implementation

{$R *.dfm}

{ TThread1 }


procedure TTesting.btMagicClick(Sender: TObject);
begin
  GetDir(0,path);

  AssignFile(fResult,path+'\Result.txt');
  Rewrite(fResult);
  AssignFile(fThread1,path+'\Thread1.txt');
  Rewrite(fThread1);
  AssignFile(fThread2,path+'\Thread2.txt');
  Rewrite(fThread2);

  MyThread.i:=1;

  Thread1:=TMyThread1.Create(True);
  Thread2:=TMyThread2.Create(True);
  Thread1.FreeOnTerminate:=True;
  Thread2.FreeOnTerminate:=True;
  Thread1.Priority:=tpNormal;
  Thread2.Priority:=tpNormal;
  Thread1.Resume;
  Thread2.Resume;

  Event:=TEvent.Create(nil,false,true,'');
end;

function TTesting.fProst(i: integer):boolean;
var
  k: integer;
  prost: boolean;
begin
  if i>=1000000 then
    begin
      Thread1.Terminate;
      Thread2.Terminate;
      Closefile(fResult);
      Closefile(fThread1);
      Closefile(fThread2);
      Exit
    end;

  prost:=true;

  for k:=2 to i-1 do
     begin
       if (i mod k)=0 then
         begin
          prost:=false;
          break;
         end;
     end;

  result:=prost;
end;

procedure TTesting.recordR(i,pot: integer);
var
  prost: boolean;
begin
  prost:=fProst(i);

  if prost=true then
    begin
      Write(fResult,IntToStr(i)+' ');

      case pot of
       1: Write(fThread1,IntToStr(i)+' ');
       2: Write(fThread2,IntToStr(i)+' ');
      end;
    end;
end;

end.
