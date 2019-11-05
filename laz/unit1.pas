unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, term;

type

  { TForm1 }

  TForm1 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation
const
   fork_failed = 1;

var
    child : boolean;
{$R *.lfm}

{ TForm1 }

procedure call_shell;
  var pp: ppchar;
begin
   getmem(pp, 2*sizeof(pchar));
   pp[0] := nil;

   fpexecvp('/bin/bash', pp);

end;

procedure TForm1.FormCreate(Sender: TObject);
     var fds, fdm: cint;
         slave_name: pchar;
         pid : tpid;
begin
  child := false;
  fdm := fpopen ('/dev/ptmx', O_RdWr);
  grantpt(fdm);
  unlockpt(fdm);

  slave_name := ptsname(fdm);
  fds := fpopen (slave_name, O_RdWr);

   pid := fpfork;

   case pid of
   -1: ShowMessage('fork failed'); runError(fork_failed);
    0: child := true;
   end;
   if child then
   begin
      fpclose (fdm);
      Form1.Caption := 'slave';
      call_shell;
   end
  else //parent
    fpclose(fds);
    Form1.Caption := 'master';
   end;
end;

end.

