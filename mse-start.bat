
cd ..

set myroot=%cd%
set myFPC=%myroot%/compilers/2.6.5/
set myBINUTILS=%myroot%/binutils/2.6.5/i386-win32/gdb.exe
set PATH=%myFPC%\bin\i386-win32

cd mseide-msegui

start mseide.exe --macrodef=FPCDIR,%myFPC%,FPCDIRLIB,{$FPCDIR}/bin/i386-win32/,COMPILER,${FPCDIR}/bin/i386-win32/ppc386.exe,DEBUGGER,%myBINUTILS%