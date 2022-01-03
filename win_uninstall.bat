@ECHO off

:: Get variables
call win_variables.bat

Rem Introduction to what is going to happen
cd %root%
call :p_n "Denne fil vil afinstallere alt der er brugt i kurset"
call :p_s
call :p_i "Ønsker du IKKE dette, så luk terminalen UDEN at trykke enter"
pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorLevel% == 0 (
    call :p_n "%MANUEL AFINSTALLATION"
    ) else (
    call :p_i "%Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer"
    call :p_i "%Hoejre klikke paa filen og tryk "koer som administrator""
    pause
    exit
    )
call :p_n "Søg efter 'Add or Remove Programs' / 'Tilfoej eller Fjern Programmer'"
call :p_n "Søg efter Pycharm, PgAdmin og Miniconda og afinstaller (i den raekefoelge)"
call :p_i "Hvis den siger den ikke kan afinstallere pga. programmet er i brug, "
call :p_i "så luk alle dine programmer, højreklik paa bjælken i bunden af skrivebordet "
call :p_n "og vælg Taskmanager/Joblisten. Find programmet, højreklik og End Task / Afslut Job og prøv igen "
call :p_n "Efter det kan du trykker videre"
echo .
pause

Rem Uninstall miniconda windows.
rmdir %root%\miniconda3 /s /q
rmdir %root%\PyCharm /s /q
rmdir %root%\pgdatabase /s /q
rmdir %root%\.conda /s /q
rmdir "%root%\AppData\Local\Programs\pgAdmin 4" /s /q

call :p_n "%Hvis den siger noget med "delete" eller "not found" er alt korrekt afinstalleret"
call :p_n "%Tryk enter for at lukke terminalen "
pause
EXIT /B %ERRORLEVEL%

call :p_n
echo %col_norm%%~1%col_end%
EXIT /B

call :p_i
echo %col_impor%%~1%col_end%
EXIT /B

call :p_s
echo.
EXIT /B