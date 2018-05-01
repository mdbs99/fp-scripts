@echo off

set fpc_ver=%1
set laz_ver=%2

cd ..

set root=%cd%
set fpc_path=%root%\compilers\%fpc_ver%
set laz_path=%root%\ide\lazarus\%laz_ver%
set binutils_path=%root%\binutils\%fpc_ver%
set PATH=%binutils_path%\i386-win32;%fpc_path%\bin\i386-win32

cd %laz_path%

make clean all OPT="-glw2"
