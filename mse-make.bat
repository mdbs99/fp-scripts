@echo off

cd ..

set myroot=%cd%
set myFPC=%myroot%\compilers\2.6.5
set PATH=%myFPC%\bin\i386-win32

cd mseide-msegui
del /s /f /q *.ppu
del /s /f /q *.o
del /s /f /q *.a

set myMSE=%cd%
cd %myMSE%

ppc386 -Xs -O- -B apps\ide\mseide.pas -Fulib\common\* -Fulib\common\kernel\windows -FE%myMSE% -FUunits\i386-win32 -omseide.exe
