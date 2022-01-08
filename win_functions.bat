@ECHO off

REM Config

chcp 1252

:is_admin
call net session >nul 2>&1
if %errorLevel% == 0 (
    call :p_n "%MANUEL AFINSTALLATION"
    ) else (
    call :p_i "%Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer"
    call :p_i "%Hoejre klikke paa filen og tryk "koer som administrator""
    pause
    exit
    )
EXIT /B 0

:p_n
echo %col_norm%%~1%col_end%
EXIT /B 0

:p_i
echo %col_impor%%~1%col_end%
EXIT /B 0
s
:p_s
echo.
EXIT /B 0