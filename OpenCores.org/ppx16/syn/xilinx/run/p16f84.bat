set name=p16f84
rem set target=xc2v250-cs144-6
rem set target=xcv300e-pq240-8
set target=xc2s200-pq208-5

if "%2" == "" goto default
set target=%2
:default

cd ..\out

if "%1" == "" goto xst

set name=p16f84_leo

copy ..\bin\%name%.pin %name%.ucf

ngdbuild -p %target% %1 %name%.ngd

goto builddone

:xst

xrom ROM84 10 14 > ..\src\ROM84_Test.vhd
hex2rom ..\..\..\sw\f84.hex rom84 10b14u > rom84_test.ini
copy ..\out\rom84_test.ini + ..\bin\%name%.pin %name%.ucf

xst -ifn ../bin/%name%.scr -ofn ../log/%name%.srp
ngdbuild -p %target% %name%.ngc

:builddone

move %name%.bld ..\log

map -p %target% -cm speed -c 100 -timing -tx on -o %name%_map %name%
move %name%_map.mrp ..\log\%name%.mrp

par -ol 3 -t 1 -c 0 %name%_map -w %name%
move %name%.par ..\log

trce %name%.ncd -o ../log/%name%.twr %name%_map.pcf

bitgen -w %name%
move %name%.bgn ..\log

cd ..\run
