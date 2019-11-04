program test;

uses baseunix, unix, term;

var fds, fdm: cint;
slave_name: pchar;
begin

  fdm := fpopen ('/dev/ptmx', O_RdWr);
  grantpt(fdm);
  unlockpt(fdm);

  slave_name := ptsname(fdm);
  fds := fpopen (slave_name, O_RdWr);

end.
