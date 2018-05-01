@echo off

set _LOG=log

cd ..

set root=%cd%
set laz_ver=%1
set log=%2
set laz_path=%root%\ide\lazarus\%laz_ver%
set opt=--pcp=%laz_path%-config --lazarus-dir=%laz_path%

if [%log%] equ [%_LOG%] (
  del %laz_path%\debuglog.txt
  set opt=%opt% --debug-log=debuglog.txt
)


cd \

rem if /i %cd% equ W:\ (
  cd %laz_path%
  start startlazarus %opt%
rem ) else (
rem   echo "invalid driver"
rem   pause
rem )

exit