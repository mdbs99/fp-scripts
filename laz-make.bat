@echo on

set myFPC_ver=%1
set myLAZ_ver=%2

cd ..

set myROOT=%cd%
set myFPC=%myROOT%\compilers\%myFPC_ver%
set myLAZ=%myROOT%\lazarus\%myLAZ_ver%
set myBINUTILS=%myroot%\binutils\%myFPC_ver%
set PATH=%myBINUTILS%\i386-win32;%myFPC%\bin\i386-win32

cd %myLAZ%

make clean all OPT="-glw2"
