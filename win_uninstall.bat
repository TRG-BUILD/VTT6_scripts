@ECHO off

:: Get variables
call %~dp0win_variables.bat

Rem Introduction to what is going to happen
cd %root%
echo.
call :p_n "Denne fil vil afinstallere alt der er brugt i kurset"
call :p_s
call :p_i "Ønsker du IKKE dette, så luk terminalen UDEN at trykke enter"
pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorLevel% == 0 (
    echo %col_norm% MANUEL AFINSTALLATION
    ) else (
    echo %col_impo% Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer
    echo %col_impo% Hoejre klikke paa filen og tryk "koer som administrator"
    pause
    exit
    )
echo %col_norm% Om lidt starter afinstallationsprogrammerne automatisk, hold øje med om der kommer tre programmer til afinstallering: pgAdmin, PyCharm og miniconda
echo %col_norm% Sker det ikke så gå i:
echo %col_norm% 'Add or Remove Programs' / 'Tilfoej eller Fjern Programmer'
echo %col_norm% Søg efter Pycharm, PgAdmin og Miniconda og afinstaller (i den raekefoelge)
echo %col_norm% Hvis den siger den ikke kan afinstallere pga. programmet er i brug, så luk alle dine programmer, højreklik paa bjælken i bunden af skrivebordet og vælg Taskmanager/Joblisten. Find programmet, højreklik og End Task / Afslut Job og prøv igen
echo.
echo.
echo %col_impo% Efter det kan du trykke videre 2 gange %col_norm%
echo.
pause
echo Første gang, een gang mere
pause

rem fjern pgadmin
call "%root%\AppData\Local\Programs\pgAdmin 4\v6\unins000.exe /VERYSILENT /NORESTART" >> %uninstalllog%
 
rem fjern pycharm
call %root%\Pycharm\bin\Uninstall.exe >> %uninstalllog%

rem Fjern miniconda
call %root%\miniconda3\Uninstall-Miniconda3.exe >> %uninstalllog%

echo %col_impo% Vent med at gå videre til alle afinstallationerne er sket
pause
Rem Uninstall miniconda windows.
rmdir %root%\miniconda3 /s /q
rmdir %root%\PyCharm /s /q
rmdir %root%\pgdatabase /s /q
rmdir %root%\.conda /s /q
rmdir "%USERPROFILE%\AppData\Local\Programs\pgAdmin 4" /s /q
rmdir %USERPROFILE%\AppData\Local\pgadmin4\  /s /q
rmdir %USERPROFILE%\AppData\Local\pgadmin\  /s /q
rmdir %USERPROFILE%\AppData\Roaming\pgadmin\  /s /q

echo.
echo %col_norm% Hvis den siger noget med "delete" eller "not found" er alt korrekt afinstalleret
echo %col_norm% Tryk enter for at lukke terminalen
echo.

pause


EXIT /B %ERRORLEVEL%

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