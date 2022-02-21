@ECHO off
chcp 1252 >nul
call %~dp0win_variables.bat

call %root%\miniconda3\Scripts\activate.bat %root%\miniconda3  >> %logfile%

Rem Create Conda environment
call conda activate build

echo "Starting postgresql database..."
pg_ctl -D %USERPROFILE%/pgdatabase -l logfile start

echo "Pres any key to stop postgresql database..."
pause
pg_ctl -D %USERPROFILE%/pgdatabase -l logfile stop
