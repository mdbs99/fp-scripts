@echo off

set cLOG=log

cd ..

set myROOT=%cd%
set myLAZVER=%1
set myLOG=%2
set myLAZPATH=%myROOT%\lazarus\%myLAZVER%
set myOPT=--pcp=%myROOT%\lazarus\%myLAZVER%-config --lazarus-dir=%myLAZPATH%

if [%myLOG%] equ [%cLOG%] (
  del %myLAZPATH%\debuglog.txt
  set myOPT=%myOPT% --debug-log=debuglog.txt
)


cd \

rem if /i %cd% equ W:\ (
  cd %myLAZPATH%
  start startlazarus %myOPT%
rem ) else (
rem   echo "invalid driver"
rem   pause
rem )

exit