unit term;
interface
uses ctypes;

function  usleep(Microseconds:cuint64):longint;cdecl;external 'libc'; //name 'usleep';
function  getpt            :cint; cdecl;external 'c'; // name 'getpt';
function  grantpt (fd:cint):cint; cdecl;external 'c';
function  unlockpt(fd:cint):cint; cdecl;external 'c';
function  ptsname (fd:cint):pchar;cdecl;external 'c';

implementation

end.
