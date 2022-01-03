@ECHO off

REM Config

chcp 1252

Rem an overview of all non-constant variables
set root=C:\Users\%USERNAME%
set col_impo=[91m
set col_norm=[92m
set col_end=[0m

set miniconda_url=https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe
set miniconda_file=miniconda.exe

set pycharm_url=https://download.jetbrains.com/python/pycharm-community-2021.1.3.exe
set pycharm_file=pycharm.exe

set postgis_url=http://download.osgeo.org/postgis/windows/pg14/postgis-bundle-pg14-3.1.4x64.zip
set postgis_file=postgis.zip

set pgadmin_url=https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v6.3/windows/pgadmin4-6.3-x64.exe
set pgadmin_file=pgadmin.exe


IF "%~1%" == "test" (
call bitsadmin /create minicondaInstall
call bitsadmin /transfer minicondaInstall %miniconda_url%  %root%\%miniconda_file%
call bitsadmin /complete minicondaInstall

call bitsadmin /create pycharmInstall
call bitsadmin /transfer pycharmInstall %pycharm_url% %root%\%pycharm_file%
call bitsadmin /complete pycharmInstall

call bitsadmin /create pgadminInstall
call bitsadmin /transfer pgadminInstall %pgadmin_url% %root%\%pgadmin_file%
call bitsadmin /complete pgadminInstall

call bitsadmin /create postgisInstall
call bitsadmin /transfer postgisInstall %postgis_url% %root%\%postgis_file%
call bitsadmin /complete postgisInstall

)