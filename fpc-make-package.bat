@echo off

rem === CONSTANTS ===
set cPLATFORM_32=i386
set cPLATFORM_64=x86
set cDEBUG=debug

rem === YOUR OPTIONS ===

cd ..

set myROOT=%cd%
set myOPTVERSION=%1
set myOPTPLATFORM=%2
set myPKGPATH=%3
set myDEBUG=%4

rem === OPTIONS ====
set myBINUTILS=%myROOT%\binutils
set myTARGET=none
set myOPTS=-gl
rem set myCOMMONOPTS=UPXPROG=echo COPYTREE=echo OPT="%myOPTS%"
set myCOMMONOPTS=

if [%myDEBUG%.] equ [%cDEBUG%.] (
  set myCOMMONOPTS=UPXPROG=echo COPYTREE=echo OPT="%myOPTS%"
)

rem === VERIFYING THE ARGS
if [%myOPTVERSION%.] equ [.] (
  echo ERROR: 1 arg is the FPC version
  goto END
)
set myFPC=%myROOT%\compilers\%myOPTVERSION%
if not exist %myFPC% (
  echo ERROR: Version "%myOPTVERSION%" does not exists
  goto END
)

rem === DEFAULT VALUES ===
if [%myOPTPLATFORM%.] equ [.] (
  set myOPTPLATFORM=%cPLATFORM_32%
)

rem === SET PATH AND OPTIONS === 
if %myOPTPLATFORM% equ %cPLATFORM_32% (
  set myTARGET=i386-win32
  set myCOMMONOPTS=%myCOMMONOPTS% OS_TARGET=win32 CPU_TARGET=i386 DATA2INC=%myFPC%\utils\data2inc.exe
) 
if %myOPTPLATFORM% equ %cPLATFORM_64% (
  set myTARGET=x86_64-win64
  set myCOMMONOPTS=%myCOMMONOPTS% OS_TARGET=win64 CPU_TARGET=x86_64
) 

set myBINUTILS_PATH=%myBINUTILS%\%myOPTVERSION%\%myTARGET%

if %myTARGET% equ none (
  echo ERROR: Plataform "%myOPTPLATFORM%" does not exists
  echo OPTIONS: %cPLATFORM_32% %cPLATFORM_64%
  goto END
)

rem === INVARIANT PART ===
set PATH=%myBINUTILS_PATH%;%myFPC%\bin\%myTARGET%
rem goto package
cd %myPKGPATH%

make clean all install %myCOMMONOPTS% INSTALL_PREFIX=%myFPC% PP=%myFPC%\bin\%myTARGET%\fpc.exe
echo ....................................
echo DONE
:END