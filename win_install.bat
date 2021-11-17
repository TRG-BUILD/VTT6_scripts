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
echo %col_norm%Denne fil vil installere alle de fornoedne programmer til kurset%col_end%
echo %col_norm%Samt give en kort beskrivelse af hvad der bliver installeret, og hvorfor%col_end%
echo %col_norm%Den forventede tid til installation samt opsaetning er ca. en time%col_end%
echo.
echo %col_norm%Dette program har tre forskellige farver%col_end%
echo %col_norm%Denne farve er hjaelpe tekst, som guider dig igennem installationen%col_end%
echo Denne farve er tekst skrevet af programmerne der installeres
echo %col_impo%Denne farve er naar der er noget vigtigt du skal vaere opmaerksom paa%col_end%
echo.
echo %col_impo%FOER DU GAAR IGANG%col_end%
echo %col_impo%Hav mindst 10GB plads ledig. Der gives hjaelp til afinstallation i slutningen af kurset%col_end%
echo %col_impo%Soerg for din antivirus er slaet fra%col_end%
echo %col_impo%Hvis du faar 'Access Denied' er din antivirus ikke slaet fra (og denne fil her kan blive slettet)%col_end%
Rem If using a previous version of windows, AntiVirus will need to be disabled
echo %col_impo%Hvis du bruger en version tidligere end windows 10, saa luk terminalen og hent en hjaelpelaerer%col_end%
echo.
echo %col_norm%Installationen af hvert program vil give lidt tekst til at forstaa hvad der er installeret, samt hvorfor det er relevant%col_end%
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
echo %col_norm%Naar du trykker enter vil der blive oprettet et virtuelt miljoe for python%col_end%
echo %col_impo%Tryk 'y' for at bekraefte oprettelsen af det virtuelle miljoe%col_end%
pause

Rem Activate AnacondaPrompt (only on windows)
call %root%/miniconda3/Scripts/activate.bat %root%\miniconda3

Rem Create Conda environment
call conda create -n build
call conda activate build
call conda config --add channels conda-forge

Echo %col_norm%Virtuelt miljoe build er oprettet%col_end%
echo %col_norm%Et virtuelt miljoe er basalt set en python installation, som holdes adskilt fra andre python installationer%col_end%
echo %col_norm%Det vil sige, at de pakker vi bruger her i kurset til at udvide det basale python, %col_end%
echo %col_norm%ikke vil blive blandet sammen med andre installationer af python%col_end%
echo %col_norm%I loebet af kurset har i kun behov for det ene virtuelle miljoe (build) %col_end%
echo %col_norm%Hernaest vil der blive installeret pakker i build miljoet%col_end%
echo %col_impo%Tryk 'y' for at bekraefte installationen af hver pakke. Der er 8 i alt%col_end%
pause

Rem Download python packages
call conda install -c conda-forge numpy
call conda install -c conda-forge matplotlib
call conda install -c conda-forge xlrd
call conda install -c conda-forge openpyxl
call conda install -c conda-forge pandas
call conda install -c conda-forge geopandas
call conda install -c conda-forge psycopg2
call conda install -c conda-forge requests

echo %col_norm%Alle python pakkerne er installeret korrekt%col_end%
echo %col_norm%En pakke (eller library paa engelsk) er kode som andre har skrevet,%col_end%
echo %col_norm%og gjort tilgaengeligt for andre at bruge. Disse er naesten altid gratis%col_end%
echo %col_norm%I dette kursus er der installeret:%col_end%
echo %col_norm%matplotlib:%col_end%
echo %col_norm%Kan bruges til at lave scatterplot, histogrammer og generelt grafer af data%col_end%
echo %col_norm%pandas:%col_end%
echo %col_norm%Kan indlaese og manipulere data til og fra mange forskellige filformater%col_end%
echo %col_norm%geopandas:%col_end%
echo %col_norm%Udvider pandas til at kunne haandtere 3D koordinator med GIS%col_end%
echo %col_norm%xlrd:%col_end%
echo %col_norm%Udvider pandas til at kunne haandtere excel%col_end%
echo %col_norm%openpyxl:%col_end%
echo %col_norm%En "sikkerhedspakke" for at vaere helt sikker paa at integrationen med excel virker%col_end%
echo %col_norm%psycopg2:%col_end%
echo %col_norm%Goer det muligt at skrive SQL kommandoer til den database i faar installeret%col_end%
echo %col_norm%SQL er et sprog i vil laere mere om i de kommende kursusgange%col_end%
echo %col_norm%numpy:%col_end%
echo %col_norm%En pakke der goer de andre pakker mange gange hurtigere%col_end%
echo %col_norm%Denne installation er ligeledes en "sikkerhedspakke" for at sikre den er med%col_end%
echo %col_norm%requests:%col_end%
echo %col_norm%En pakke der goer det muligt at sende og modtage beskeder fra internettet%col_end%
echo %col_norm%Den kan bruges til at hente data fra datastyrelsen, vejman samt mere til brug i et program%col_end%
pause
echo %col_norm%Python er nu installeret med de korrekte pakker i build miljoet%col_end%
echo %col_norm%For at kunne bruge python, er det smart at bruge en IDE,%col_end%
echo %col_norm%hvor man kan skrive programmerne i, og koere det fra%col_end%
echo %col_norm%Naar du trykker enter, vil PyCharm IDE'en blive installeret%col_end%
pause

Rem Download Pycharm
mkdir %root%\Pycharm
call bitsadmin /create pycharmInstall
call bitsadmin /transfer pycharmInstall https://download.jetbrains.com/python/pycharm-community-2021.1.3.exe %root%\pycharm.exe
call bitsadmin /complete pycharmInstall
echo mode=user > "silent.config"
echo launcer32=0 >> "silent.config"
echo launcer64=1 >> "silent.config"
echo updatePATH=0 >> "silent.config"
echo updateContextMenu=0 >> "silent.config"
echo jre32=0 >> "silent.config"
echo regenerationSharedArchive=1 >> "silent.config"
echo .py=1 >> "silent.config"

echo %col_norm%Pycharm er nu igang med at blive installeret. Vent venligst%col_end%

Rem Install Pycharm
call pycharm.exe /S /CONFIG=%root%\silent.config /D=%root%\Pycharm

echo %col_norm%Pycharm installeret. Overskydende filer slettes%col_end%

Rem Delete leftover files
del /s %root%\silent.config
del /s %root%\pycharm.exe

echo %col_norm%Pycharm er som skrevet en IDE, hvor man kan skrive og koere python%col_end%
echo %col_norm%Et Integrated Development Environment (IDE) er dybest set en tekst editor med ekstra funktioner%col_end%
echo %col_norm%Disse ekstra funktioner vil blive forklaret i en seperat video%col_end%
echo %col_norm%Pycharm holder styr paa filerne indenfor et givet projekt%col_end%
echo %col_norm%I dette kursus er projektet VTT6 oprettet med opgaver, samt mulighed for at i selv kan lave python programmer%col_end%
echo %col_norm%Naar du trykker enter vil VTT6 projektet blive hentet ned%col_end%
echo %col_impo%For at hente VTT6 projektet, bruges programmet git. HUSK at skrive 'y' naar den beder om installationen%col_end%
pause

Rem Get PycharmProjects containing exercises
mkdir %root%\PycharmProjects
cd %root%\PycharmProjects
call conda install -c conda-forge git
git clone https://github.com/TRG-BUILD/VTT6.git
cd %root%

echo %col_norm%VTT6 er nu hentet ned paa computeren%col_end%
echo %col_norm%Dette projekt vil vaere det primaere sted for at lave opgaver og skrive filer%col_end%
echo %col_norm%Sammenkoblingen af alle delene vil ske i slutningen af denne fil gennemgang%col_end%
echo %col_norm%Som det sidste foer sammenkoblingen, vil der blive downloadet postgresql og pgadmin til at haandtere databaser%col_end%
pause

Rem Install Postgres + PostGis
call bitsadmin /create pgadminInstall
call bitsadmin /transfer pgadminInstall https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v5.5/windows/pgadmin4-5.5-x64.exe %root%\pgadmin.exe
call bitsadmin /complete pgadminInstall
call bitsadmin /create postgisInstall
call bitsadmin /transfer postgisInstall http://download.osgeo.org/postgis/windows/pg13/postgis-bundle-pg13-3.1.2x64.zip %root%\postgis-bundle-pg13-3.1.2x64.zip
call bitsadmin /complete postgisInstall
echo %col_norm%Postgresql og PgAdmin er ved at blive installeret. Vent venligst%col_end%
echo %col_norm%Vaelg Install For Me. Derefter vil filer blive udpakket og flyttet%col_end%
call pgadmin.exe /VERYSILENT /NORESTART
call powershell.exe -NoP -NonI -Command "Expand-Archive '.\postgis-bundle-pg13-3.1.2x64.zip' '.\unziped\'"
cd unziped
call Robocopy postgis-bundle-pg13-3.1.2x64 %root%\miniconda3\envs\build\Library /E /Z /MOVE
cd %root%
echo %col_norm%PgAdmin og postgresqlinstalleret. Overskydende filer slettes%col_end%
rmdir %root%\PycharmProjects\VTT6\.git /s /q
rmdir %root%\unziped /s /q
del /s %root%\pgadmin.exe
del /s %root%\postgis-bundle-pg13-3.1.2x64.zip

echo %col_norm%Der opsaettes nu automatisk den database, som skal bruges i kurset%col_end%

Rem Create a database cluster with superuser = %USERNAME% (no password)
mkdir pgdatabase
call initdb --encoding="UTF8" --pgdata=%root%\pgdatabase --auth=trust
call pg_ctl -D %root%\pgdatabase -l logfile start
echo %col_impo%Vaelg 'changeme' som password til den nye rolle (brugeren postgres)%col_end%
echo %col_impo%Indtastningen er USYNLIG, og skal goeres to gange i streg%col_end%
call createuser -P -s -e postgres
call createdb vttt "--owner=postgres --host=localhost --port=5432 --username=postgres --no-password"

echo %col_norm%Postgresql er et program som haandtere databaser, og som du kan styre ved brug af programmeringssproget SQL%col_end%
echo %col_norm%Paa din computer er der nu oprettet en database der hedder 'vttt'%col_end%
echo %col_norm%Denne database er valgt i kurset til at kunne tilgaes med brugernavnet 'postgres' og passwordet 'changeme'%col_end%
echo %col_norm%Den koere paa din computer, hvilket er 'hostes paa localhost' i tekniske termer%col_end%
echo %col_norm%Den lytter desuden paa port 5432, hvilket er det 'sted' paa din computer andre programmer kan kontakte databasen%col_end%
echo %col_norm%Ligeledes er PgAdmin installeret, som kan bruges til at se og bruge databasen%col_end%
pause
echo %col_impo%Der mangler lige den sidste opsaetning der skal laves manuelt%col_end%
echo %col_norm%Naar du trykker enter, vil instruktionerne for de sidste opsaetninger blive skrevet%col_end%
echo %col_norm%Instruktionerne er delt op i 1 step ad gangen%col_end%
pause

echo %col_norm%Databasen som vi har lavet med postgresql skal kunne tilgaes fra PgAdmin%col_end%
echo %col_norm%Til det skal du foelge de her 5 steps:%col_end%
echo %col_norm%1. Aaben PgAdmin (soeg efter PgAdmin)%col_end%
echo %col_norm%   Accepter betingelserne%col_end%
echo %col_impo%   Til 'set master password' indtast 'changeme'%col_end%
pause
echo %col_norm%2. Hoejre klik paa Servers (i oevre venstre hjoerne) - Create - Server%col_end%
pause
echo %col_norm%3. Angiv Name 'vttt', og tryk paa connection%col_end%
echo %col_norm%   Angiv Host name/address 'localhost', og tryk 'Save'%col_end%
pause
echo %col_norm%4. For at udfoere SQL kommandoer til databasen, skal du foerst vaelge databasen %col_end%
echo %col_norm%   Helt ude til venstre, tryk paa vttt - Databases - vttt %col_end%
echo %col_norm%   Derefter se i den oevre blaa bjaelke og tryk paa Tools - Query Tool%col_end%
echo %col_norm%   Copy/paste denne kommando, for at aktivere postgis i databasen:%col_end% create extension postgis;
echo %col_norm%   Tryk derefter paa F5 eller Play knappen oeverst til hoejre, for at sende SQL kommandoen til databasen %col_end%
pause
echo %col_norm%   PgAdmin og databasen vttt burde nu vaere korrekt opsat sammen%col_end%
echo %col_norm%   Desuden er databasen nu opsat til at kunne haandtere GIS data%col_end%
pause
echo %col_norm%build miljoet, der har alle pakkerne installeret, skal kobles sammen med Pycharm%col_end%
echo %col_norm%Til det skal du foelge de her 7 steps%col_end%
echo %col_norm%1. Aaben PyCharm Community Edition (soeg efter Pycharm)%col_end%
echo %col_norm%   Accepter betingelserne.%col_end%
pause
echo %col_norm%2. I popup vinduet, tryk paa "Open" og find projektet VTT6%col_end%
echo %col_norm%   Projektet ligger i %root%\PycharmProjects%col_end%
echo %col_norm%   I vil muligvis faa en besked i nedre hoejre hjoerne om at der mangler en github mappe%col_end%
echo %col_norm%   Den mappe er fjernet, da i ikke har behov for det, saa i kan se bort fra fejlen%col_end%
pause
echo %col_norm%3. Naar projektet er aabent, se da nederst i hoejre hjoerne under 'Event Log'%col_end%
echo %col_norm%   Tryk paa 'No Interpreter' og dernaest tryk paa "Add Interpreter"%col_end%
echo %col_norm%    Der kan godt staa "Python X.X" (hvor X er tal) istedet. Tryk stadig og vaelg Add Interpreter %col_end%
pause
echo %col_norm%4. I popup vinduet skal du trykke paa 'conda environment' i venstre side%col_end%
echo %col_norm%   Dernaest trykker du paa 'existing environments' og find saa en 'Interpreter:' som hedder%col_end%
echo %col_norm%   %root%\miniconda3\envs\build\python.exe %col_end%
echo %col_impo%   HUSK at tryk paa 'make available to all projects'%col_end%
echo %col_norm%   Tryk saa OK, og der burde nu staa 'Python 3.9 (build)' i nedre hoejre hjoerne%col_end%
pause
echo %col_norm%5. Python interpreteren bliver nu sat op i PyCharm. Det kan tage noget tid.
echo %col_norm%   Naar den hvide streg til venstre for Python 3.9 (build) er koert helt igennem, %col_end%
echo %col_norm%   kan du fortsaette med naeste instruktion%col_end%
pause
echo %col_norm%6. I oevre venstre hjoerne, hoejre-klik paa 0test_setup.py%col_end%
echo %col_norm%   Dernaest, tryk paa "Run" for at koere filen%col_end%
pause
echo %col_norm%7. Hvis programmet siger 'Alt korrekt installeret' i terminalen i bunden er alt ok%col_end%
echo %col_norm%   Hvis programmet ikke siger 'Alt korrekt installeret', saa kontakt en hjaelpelaerer%col_end%
pause

echo %col_norm%Alle programmer til dette kursus burde nu vaere korrekt installeret og opsat%col_end%
echo %col_norm%Naar du trykker skulle terminalen gerne lukke, ellers tryk paa X et par gange oeverst til hoejre%col_end%
pause
exit
