@echo off

cd ..

set myROOT=%cd%
set myOPTVERSION=%1

rem === DEFINE ====
set cFPC_STABLE_VER=3.0.0
set myOPTS=-gl
rem  -gw2 -godwarfsets  --debug info
set myCOMMONOPTS=UPXPROG=echo COPYTREE=echo OPT="%myOPTS%"

rem === VERIFYING THE ARGUMENTS
if [%myOPTVERSION%.] equ [.] (
  echo ERROR: 1 arg is the FPC version
  goto END
)
set myFPC=%myROOT%\compilers\%myOPTVERSION%
if not exist %myFPC% (
  echo ERROR: Version "%myOPTVERSION%" does not exists
  goto END
)

rem === SET PATH AND OPTIONS === 
set myTARGET=i386-win32
set myPPC_EXE=ppc386.exe
set myCOMMONOPTS=%myCOMMONOPTS% OS_TARGET=win32 CPU_TARGET=i386 DATA2INC=%myROOT%\compilers\%cFPC_STABLE_VER%\utils\data2inc.exe

rem === INVARIANT PART ===
set myFPC_STABLE_BIN_PATH=%myROOT%\compilers\%cFPC_STABLE_VER%\bin
set myBINUTILS_PATH=%myROOT%\binutils\%cFPC_STABLE_VER%\%myTARGET%
set myCOMMONOPTS=%myCOMMONOPTS% INSTALL_PREFIX=%myFPC% PP=%myFPC_STABLE_BIN_PATH%\%myTARGET%\%myPPC_EXE%

set PATH=%myBINUTILS_PATH%;%myFPC%\bin\%myTARGET%
cd %myFPC%

del /s /f /q *.ppu
rem del /s /f /q *.o
del /s /f /q *.a
rmdir units /s /q

echo ---------------------------------------------------
echo "Running make install"
echo ---------------------------------------------------

make distclean
make all & make install %myCOMMONOPTS%
fpcmkcfg -d basepath=%myFPC% -o %myFPC%\bin\%myTARGET%\fpc.cfg
fpc -iV

pause

echo ---------------------------------------------------
echo "Running make crossinstall"
echo ---------------------------------------------------

make crossinstall OS_TARGET=win64 CPU_TARGET=x86_64 INSTALL_PREFIX=%myFPC%

cd %myROOT%

echo ================================================
echo DONE
:END