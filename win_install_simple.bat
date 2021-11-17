@ECHO off

REM Config
Rem an overview of all non-constant variables
set root=C:\Users\%USERNAME%
set col_impo=[91m
set col_norm=[92m
set col_end=[0m

Rem This file installs and configures 3 parts
Rem     Miniconda and the base python installation, setting up the build conda environment
Rem     Pycharm and setting it up to the build environment python interpreter
Rem     Postgres, postgis and PgAdmin, and setting up the vttt database

Rem Introduction to what is going to happen
cd %root%
echo %col_norm%Denne fil vil installere python til brug i kurset%col_end%
echo.
echo %col_norm%Dette program har tre forskellige farver%col_end%
echo %col_norm%Denne farve er hjaelpe tekst, som guider dig igennem installationen%col_end%
echo Denne farve er tekst skrevet af programmerne der installeres
echo %col_impo%Denne farve er naar der er noget vigtigt du skal vaere opmaerksom paa%col_end%
echo.
echo %col_impo%FOER DU GAAR IGANG%col_end%
echo %col_impo%Hav mindst 1GB plads ledig. Der gives hjaelp til afinstallation i slutningen af kurset%col_end%
echo %col_impo%Soerg for din antivirus er slaet fra, mens installationen foregaar%col_end%
echo %col_impo%Hvis du faar 'Access Denied' er din antivirus ikke slaet fra (og denne fil her kan blive slettet)%col_end%
echo %col_impo%Hvis du bruger en version tidligere end windows 10, saa luk terminalen og hent en hjaelpelaerer%col_end%
echo.
echo %col_norm%Naar du trykker enter, vil miniconda blive downloadet og installeret%col_end%
pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorlevel% == 0 (
    echo %col_norm%Installation af python paabegynder nu.%col_end%
    ) else (
    echo %col_impo%Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer%col_end%
    echo %col_impo%Hoejre klikke paa filen og tryk "koer som administrator"%col_end%
    pause
    exit
    )

Rem Download and install miniconda windows.
mkdir %root%\miniconda3
call bitsadmin /create minicondaInstall
call bitsadmin /transfer minicondaInstall https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe %root%\miniconda.exe
call bitsadmin /complete minicondaInstall
echo %col_norm% miniconda er downloadet og ved at blive installeret. Vent venligst%col_end%
call miniconda.exe /S /D=%root%\miniconda3
echo %col_norm%Miniconda installeret. Overskydende filer slettes%col_end%
del /s %root%\miniconda.exe

echo %col_norm%Miniconda er er et program som holder styr paa programmeringssproget python%col_end%
echo .
echo %col_norm%Alle programmer til dette kursus burde nu vaere korrekt installeret og opsat%col_end%
echo %col_norm% Maaden du tester det paa, er at aabne en terminal og skrive to kommandoer %col_end%
echo %col_norm% python --version %col_end%
echo %col_norm% Dette viser hvilken python version der er installeret i miniconda %col_end%
echo %col_norm%Naar du trykker skulle terminalen gerne lukke, ellers tryk paa X et par gange oeverst til hoejre%col_end%
pause
exit
