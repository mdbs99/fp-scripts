
cd ..

set fpc_ver=3.0.2

set root=%cd%
set fpc=%myroot%/compilers/%fpc_ver%/
set binutils=%root%/binutils/%fpc_ver%/i386-win32/gdb.exe
set PATH=%fpc%\bin\i386-win32

cd ide\mse

start mseide.exe --macrodef=FPCDIR,%fpc%,FPCDIRLIB,{$FPCDIR}/bin/i386-win32/,COMPILER,${FPCDIR}/bin/i386-win32/ppc386.exe,DEBUGGER,%binutils%