@echo on

cd ..

set myroot=%cd%
set myFPC=%myroot%\compilers\%1
set mybinutils=%myroot%\binutils\%1
set PATH=%mybinutils%\i386-win32;%myFPC%\bin\i386-win32

cd %myroot%\compilers\fpcdocs

make fcl.chk FPCSRCDIR=%myFPC%
make rtl.chk FPCSRCDIR=%myFPC%
