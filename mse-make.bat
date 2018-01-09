@echo off

cd ..

set myroot=%cd%
set myFPC=%myroot%\compilers\3.0.1
set PATH=%myFPC%\bin\i386-win32

cd ide\mse
del /s /f /q *.ppu
del /s /f /q *.o
del /s /f /q *.a

set myMSE=%cd%
cd %myMSE%

ppc386 -Xs -O- -B apps\ide\mseide.pas -Fulib\common\* -Fulib\common\kernel\windows -FE%myMSE% -FUunits\i386-win32 -omseide.exe
