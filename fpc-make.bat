@echo off

rem =======================================================================================
rem === COMMAND ARGUMENTS ===
rem     example: 
rem       fpc.bat 3.0.1 i386 cross
rem =======================================================================================

cd ..

set myROOT=%cd%
set myOPTVERSION=%1
set myOPTPLATFORM=%2
set myOPTCROSS=%3

rem === CONSTANTS ===
set cFPC_STABLE_VER=3.0.0

set cPLATFORM_32=i386
set cPLATFORM_64=x86
set cPLATFORM_ARM=arm

set cCROSS_YES=cross
set cCROSS_NO=nocross
set cCROSS_ONLY=crossonly

rem =======================================================================================
rem === DEFINE ====
rem =======================================================================================
set myTARGET=none
rem  -gw2 -godwarfsets  --debug info
set myOPTS=-gl
set myCOMMONOPTS=UPXPROG=echo COPYTREE=echo OPT="%myOPTS%"
rem set myCOMMONOPTS=

rem =======================================================================================
rem === VERIFYING THE ARGUMENTS
rem =======================================================================================
if [%myOPTVERSION%.] equ [.] (
  echo ERROR: 1 arg is the FPC version
  goto END
)
set myFPC=%myROOT%\compilers\%myOPTVERSION%
if not exist %myFPC% (
  echo ERROR: Version "%myOPTVERSION%" does not exists
  goto END
)

rem =======================================================================================
rem === DEFAULT VALUES ===
rem =======================================================================================
if [%myOPTPLATFORM%.] equ [.] (
  set myOPTPLATFORM=%cPLATFORM_32%
)
if [%myOPTCROSS%.] equ [.] (
  set myOPTCROSS=%cCROSS_YES%
)

rem =======================================================================================
rem === SET PATH AND OPTIONS === 
rem =======================================================================================
if %myOPTPLATFORM% equ %cPLATFORM_32% (
  set myTARGET=i386-win32
  set myPPC_EXE=ppc386.exe
  set myCOMMONOPTS=%myCOMMONOPTS% OS_TARGET=win32 CPU_TARGET=i386 DATA2INC=%myROOT%\compilers\%cFPC_STABLE_VER%\utils\data2inc.exe
) 
if %myOPTPLATFORM% equ %cPLATFORM_64% (
  set myTARGET=x86_64-win64
  set myPPC_EXE=ppcrossx64.exe
  set myCOMMONOPTS=%myCOMMONOPTS% OS_TARGET=win64 CPU_TARGET=x86_64
) 
if %myOPTPLATFORM% equ %cPLATFORM_ARM% (
  set myTARGET=arm-wince
  set myPPC_EXE=ppc386.exe
  set myCOMMONOPTS=%myCOMMONOPTS% OS_TARGET=arm CPU_TARGET=i386
) 

rem =======================================================================================
rem === INVARIANT PART ===
rem =======================================================================================
set myFPC_STABLE_BIN_PATH=%myROOT%\compilers\%cFPC_STABLE_VER%\bin

rem set myBINUTILS_PATH=%myROOT%\binutils\%myOPTVERSION%\%myTARGET%
set myBINUTILS_PATH=%myROOT%\binutils\%cFPC_STABLE_VER%\%myTARGET%
set myCOMMONOPTS=%myCOMMONOPTS% INSTALL_PREFIX=%myFPC% PP=%myFPC_STABLE_BIN_PATH%\%myTARGET%\%myPPC_EXE%


if %myTARGET% equ none (
  echo ERROR: Plataform "%myOPTPLATFORM%" does not exists
  echo OPTIONS: %cPLATFORM_32% %cPLATFORM_64% %cPLATFORM_ARM%
  goto END
)

set PATH=%myBINUTILS_PATH%;%myFPC%\bin\%myTARGET%
cd %myFPC%

del /s /f /q *.ppu
rem del /s /f /q *.o
del /s /f /q *.a
rmdir units /s /q

rem use the command below if you not use COPYTREE=echo
rem rd /s /q  %myfpc%\examples

if [%myOPTCROSS%.] neq [%cCROSS_ONLY%.] (
  echo ---------------------------------------------------
  echo "Running make install"
  echo ---------------------------------------------------
  make distclean
  make all & make install %myCOMMONOPTS%
  fpcmkcfg -d basepath=%myFPC% -o %myFPC%\bin\%myTARGET%\fpc.cfg
  fpc -iV
)

if [%myOPTPLATFORM%.] equ [%cPLATFORM_32%.] (
  if [%myOPTCROSS%.] equ [%cCROSS_NO%.] (
    goto END
  )

  echo ---------------------------------------------------
  echo "Running make crossinstall"
  echo ---------------------------------------------------
  pause
  set myTARGET=x86_64-win64
  make crossinstall %myCOMMONOPTS% OS_TARGET=win64 CPU_TARGET=x86_64 
  fpcmkcfg -d basepath=%myFPC% -o %myFPC%\bin\%myTARGET%\fpc.cfg
)

cd %myROOT%

echo ================================================
echo DONE
:END