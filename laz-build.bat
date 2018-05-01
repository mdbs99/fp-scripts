@echo off

set laz_ver=%1

cd ..

set root=%cd%
set laz_path=%root%\ide\lazarus\%laz_ver%

cd %laz_path%

lazbuild.exe --build-ide= --pcp=..\%laz_ver%-config
