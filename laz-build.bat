@echo off

set myLAZ_ver=%1

cd ..

set myROOT=%cd%
set myLAZ=%myROOT%\lazarus\%myLAZ_ver%

cd %myLAZ%

lazbuild.exe --build-ide= --pcp=..\%myLAZ_ver%-config
