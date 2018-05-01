@echo on

cd ..

set root=%cd%
set fpc=%root%\compilers\%1
set binutils=%root%\binutils\%1
set PATH=%binutils%\i386-win32;%fpc%\bin\i386-win32

cd %root%\compilers\fpcdocs

make fcl.chk FPCSRCDIR=%fpc%
make rtl.chk FPCSRCDIR=%fpc%
