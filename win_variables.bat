@ECHO off

REM Config

chcp 1252

Rem an overview of all non-constant variables
set root=C:\Users\%USERNAME%
set col_impo=[91m
set col_norm=[92m
set col_end=[0m

set logfile=install.txt
set uninstalllog=uninstall.txt

set miniconda_url=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
set miniconda_file=miniconda.exe
set miniconda_logfile=miniconda.log

set pycharm_url=https://download.jetbrains.com/python/pycharm-community-2021.1.3.exe
set pycharm_file=pycharm.exe
set pycharm_logfile=pycharm.log

set postgis_url=https://download.osgeo.org/postgis/windows/pg14/archive/postgis-bundle-pg14-3.1.4x64.zip
set postgis_file=postgis-bundle-pg14-3.1.4x64.zip
set postgis_logfile=postgis.log
		
set pgadmin_url=https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v6.3/windows/pgadmin4-6.3-x64.exe
set pgadmin_file=pgadmin.exe
set pgadmin_logfile=pgadmin.log


IF "%~1%" == "test" (
echo Downloading miniconda
call bitsadmin /create minicondaInstall > nul
call bitsadmin /transfer minicondaInstall %miniconda_url%  %root%\%miniconda_file% > nul
call bitsadmin /complete minicondaInstall > nul

echo Downloading pycharm... please wait
call bitsadmin /create pycharmInstall > nul
call bitsadmin /transfer pycharmInstall %pycharm_url% %root%\%pycharm_file% > pycharm.txt
call bitsadmin /complete pycharmInstall > nul

echo Downloading pgadmin... please wait
call bitsadmin /create pgadminInstall > nul
call bitsadmin /transfer pgadminInstall %pgadmin_url% %root%\%pgadmin_file% > nul
call bitsadmin /complete pgadminInstall > nul

echo Downloading postgis... please wait
call bitsadmin /create postgisInstall > nul
call bitsadmin /transfer postgisInstall %postgis_url% %root%\%postgis_file% > nul
call bitsadmin /complete postgisInstall > nul

)