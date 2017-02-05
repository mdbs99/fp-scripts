@echo off

cd ..

set myROOT=%cd%
set myVERSION=%1
set myBINUTILS=%myROOT%\binutils
set myTARGET=i386-win32

if [%myVERSION%.] equ [.] (
  echo ERROR: 1 arg is the FPC version
  goto END
)


set myFPC=%myROOT%\compilers\%myVERSION%
if not exist %myFPC% (
  echo ERROR: Version "%myVERSION%" does not exists
  goto END
)

set myBINUTILS_PATH=%myBINUTILS%\%myVERSION%\%myTARGET%

set PATH=%myBINUTILS_PATH%;%myFPC%\bin\%myTARGET%

echo Ready to use MAKE distclean in any folder using FPC %myVERSION%.

:END

