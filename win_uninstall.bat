@ECHO off

REM Config
set help_mail=some@mail.com
set root=C:\Users\%USERNAME%
set col_impo=[91m
set col_norm=[92m
set col_end=[0m


Rem Introduction to what is going to happen
cd %root%
echo %col_norm%Denne fil vil afinstallere alt der er brugt i kurset%col_end%
echo %col_impo%ADVARSEL: Den vil desuden ogsaa slette alle din Pycharm Projekt filer%col_end%
echo %col_impo%Hvis du flytter filerne du oensker at gemme, ud paa skrivebordet vil de ikke blive slettet %col_end%
echo %col_impo%Oensker du at flytte filer, saa luk terminalen UDEN at trykke enter, inden du flytter filerne %col_end%
pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorLevel% == 0 (
    echo %col_norm%MANUEL AFINSTALLATION%col_end%
    ) else (
    echo %col_impo%Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer%col_end%
    echo %col_impo%Hoejre klikke paa filen og tryk "koer som administrator"%col_end%
    pause
    exit
    )
echo %col_norm%Soeg efter 'Add or Remove Programs' / 'Tilfoej eller Fjern Programmer'%col_end%
echo %col_norm%Soeg efter Pycharm, PgAdmin og Miniconda og afinstaller (i den raekefoelge)%col_end%
echo %col_impo%Hvis den siger den ikke kan afinstallere pga. programmet er i brug, %col_end%
echo %col_impo%saa luk alle dine programmer, hoejreklik paa bjaelken i bunden af skrivebordet %col_end%
echo %col_norm%og vaelg Taskmanager/Joblisten. Find programmet, hoejreklik og End Task / Afslut Job og proev igen %col_end%
echo %col_norm%Efter det kan du trykker videre%col_end%
echo .
echo %col_norm%Programmet vil fjerne alle de mapper som der er data fra kurset%col_end%
echo %col_norm%Hvis du er sikker, saa tryk enter%col_end%
pause

Rem Uninstall miniconda windows.
rmdir %root%\miniconda3 /s /q
rmdir %root%\PyCharm /s /q
rmdir %root%\PycharmProjects /s /q
rmdir %root%\pgdatabase /s /q
rmdir %root%\.conda /s /q
rmdir "%root%\AppData\Local\Programs\pgAdmin 4" /s /q

echo %col_norm%Hvis den siger noget med "delete" eller "not found" er alt korrekt afinstalleret%col_end%
echo %col_norm%Tryk enter for at lukke terminalen %col_end%
pause
exit
