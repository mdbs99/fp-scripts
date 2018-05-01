@echo off

cd ..

set fpc_ver=3.0.4

set root=%cd%
set fpc=%root%\compilers\%fpc_ver%
set PATH=%fpc%\bin\i386-win32

cd ide\mse
del /s /f /q *.ppu
del /s /f /q *.o
del /s /f /q *.a

set mse=%cd%
cd %mse%

ppc386 -Xs -O- -B apps\ide\mseide.pas -Fulib\common\* -Fulib\common\kernel\windows -FE%mse% -FUunits\i386-win32 -omseide.exe
