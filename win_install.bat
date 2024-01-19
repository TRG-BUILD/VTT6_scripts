@ECHO off
chcp 1252 >nul


set stien=%~dp0
set stien=%stien: =LLLLL% 


echo %stien% | FIND /I "LLLLL">Nul && ( 
echo Programmet kan ikke k�re, da installations mappen ligger i en mappe med mellemrum
echo %stien%
pause
exit
 )

:: Get variables 
call %~dp0win_variables.bat

cls

Rem This file installs and configures 3 parts
Rem     Miniconda and the base python installation, setting up the build conda environment
Rem     Pycharm and setting it up to the build environment python interpreter
Rem     Postgres, postgis and PgAdmin, and setting up the vttt database

Rem Introduction to what is going to happen
echo %col_norm% ------------------------- Installation af software til Vej- og trafikdatabehandlingskurset ---------------------------
echo.
echo %col_norm% Denne fil vil installere alle de forn?dne programmer til kurset
echo %col_norm% Samt give en kort beskrivelse af hvad der bliver installeret, og hvorfor
echo %col_norm% Den forventede tid til installation samt ops?tning er ca. en time
echo.

echo %col_norm% Herunder skal du v?lge om du vil have det hele installeret automatisk (anbefales) eller du vil sige ja tak l?bende.
echo %col_impo% Bem?rk du under alle omst?ndigheder skal sige ja ved miniconda installationen og ved ops?tning af postgres
echo.

REM Choose automatic (yes to everything) or guided process for installation
goto start

:start
echo %col_norm%  y. Automatisk installering
echo %col_norm%  n. Guidet process
echo %col_norm%  x. Slut
set choice=
echo.
set /p choice=%col_norm% Hvilken installation vil du have:  %col_end%
if not '%choice%' == '' set choice=%choice:~0,1%
if '%choice%'=='y' goto a_install
if '%choice%'=='n' goto g_install
if '%choice%'=='x' goto end
echo "%choice%" er ikke validt
echo.
goto start
goto end


:a_install
echo.
echo %col_norm%  Du har valgt automatisk installation
echo %col_norm%  ?nsker du et andet valg, s? start dette program forfra
pause
set default=--yes

goto install

:g_install
echo %col_norm% Du har valgt en guidet installation
echo %col_norm% ?nsker du et andet valg, s? start dette program forfra %col_impo% 
set default=

pause
goto install

:install

REM change to %USERPROFILE%
cd %root%

echo.
echo %col_norm% ----------------------------------- Dette program har tre forskellige farver -----------------------------------------
echo %col_norm% Denne farve er hj?lpe tekst, som guider dig igennem installationen.
echo %col_end% Denne farve er tekst skrevet af programmerne der installeres.
echo %col_impo% Denne farve er n?r der er noget vigtigt du skal v?re opm?rksom p?.
echo.
echo %col_norm% F?R DU G?R IGANG
echo %col_norm% Hav mindst 10GB plads ledig. Der gives hj?lp til afinstallation i slutningen af kurset
echo %col_norm% S?rg for din antivirus er sl?et fra
echo %col_impo% Hvis du f?r 'Access Denied' er din antivirus ikke sl?et fra (og denne fil her kan blive slettet)

echo.
echo %col_norm% Installationen af hvert program vil give lidt tekst til at forst? hvad der er installeret, samt hvorfor det er relevant
echo %col_norm% N?r du trykker enter, vil download af programmerne g? igang og derefter selve installationen
echo.


pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorlevel% == 0 (
    echo %col_norm% Installation af python p?begynder nu.
    ) else (
    cls
    echo %col_impo% ----------------------------------------------------------------------------------------------------------------------
    echo %col_impo%                  Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer
    echo %col_impo%                                H?jre klik p? filen og tryk "k?r som administrator
    echo %col_impo% ----------------------------------------------------------------------------------------------------------------------
    pause
    exit
    )

Rem Download files for windows.
echo %col_norm% Download nu 4 installationsfiler ca. 645 mb

if not exist %root%\%miniconda_file% (
echo %col_norm% Downloading miniconda

call bitsadmin /create minicondaInstall > nul
call bitsadmin /transfer minicondaInstall %miniconda_url%  %root%\%miniconda_file% >> %logfile%
call bitsadmin /complete minicondaInstall > nul
)

if not exist %root%\%pycharm_file% (
echo %col_norm% Downloading pycharm... please wait
call bitsadmin /create pycharmInstall  > nul
call bitsadmin /transfer pycharmInstall %pycharm_url% %root%\%pycharm_file% >> %logfile%
call bitsadmin /complete pycharmInstall > nul
 )

if not exist %root%\%pgadmin_file% (
echo %col_norm% Downloading pgadmin... please wait
call bitsadmin /create pgadminInstall  > nul
call bitsadmin /transfer  pgadminInstall %pgadmin_url% %root%\%pgadmin_file% >> %logfile%
call bitsadmin /complete  pgadminInstall  > nul
)

REM if not exist %root%\%postgis_file% (
REM echo %col_norm% Downloading postgis... please wait
REM call bitsadmin /create postgisInstall > nul
REM call bitsadmin /transfer postgisInstall %postgis_url% %root%\%postgis_file% >> %logfile%
REM call bitsadmin /complete postgisInstall > nul
REM )

echo.                                          
echo %col_norm% ---------------------------   Miniconda installeres og det virtuelle milj? ops?ttes   ------------------------------
echo %col_norm% miniconda er downloadet og ved at blive installeret. Vent venligst
mkdir %root%\miniconda3
call %miniconda_file% /S /D=%root%\miniconda3  >> %logfile%
echo.
echo %col_norm% Miniconda installeret
echo %col_norm% Miniconda er er et pakkeh?ndteringsprogram som holder styr p? dit python milj?
echo.

if not '%default%'=='--yes' (
echo.
echo %col_norm% N?r du trykker enter vil der blive oprettet et virtuelt milj? for python
echo %col_impo% Tryk en tast for at bekr?fte oprettelsen af det virtuelle milj?
pause
)

Rem Activate AnacondaPrompt (only on windows)
call %root%\miniconda3\Scripts\activate.bat %root%\miniconda3  >> %logfile%

Rem Create Conda environment
call conda install -c conda-forge -y git >> %logfile%
call conda create %default%  -n %environment_name% >> %logfile%
call conda activate %environment_name% >> %logfile%
echo conda update -n base %default% -c defaults conda >> %logfile%
call conda update -n base %default% -c defaults conda >> %logfile%
call conda config --add channels conda-forge  >> %logfile%


echo.
echo %col_norm% Virtuelt milj? build er oprettet
echo %col_norm% Et virtuelt milj? er basalt set en python installation, som holdes adskilt fra andre python installationer
echo %col_norm% Det vil sige, at de pakker vi skal bruge her i kurset til at udvide det basale python, ikke vil blive blandet sammen med andre installationer af python
echo %col_norm% I l?bet af kurset har i kun behov for det ene virtuelle milj? (build) 
echo %col_norm% Hern?st vil der blive installeret pakker i build milj?t

if not '%default%'=='--yes' (
echo %col_impo% Tryk 'y' for at bekr?fte installationen af hver pakke. Der er 8 i alt
pause
)

echo.
echo %col_impo% Vent venligst.
call conda install -c conda-forge %default% numpy matplotlib xlrd openpyxl pandas geopandas psycopg2 requests sqlite >> %logfile%
REM call conda install -c conda-forge %default% matplotlib  >> %logfile%
REM call conda install -c conda-forge %default% xlrd  >> %logfile%
REM call conda install -c conda-forge %default% openpyxl  >> %logfile%
REM call conda install -c conda-forge %default% pandas  >> %logfile%
REM call conda install -c conda-forge %default% geopandas  >> %logfile%
REM call conda install -c conda-forge %default% psycopg2  >> %logfile%
REM call conda install -c conda-forge %default% requests  >> %logfile%
REM call conda install -c conda-forge %default% sqlite  >> %logfile%

call yes | pip install requests 

echo.
echo %col_norm% Alle python pakkerne er installeret korrekt
echo %col_norm% En pakke (eller library p? engelsk) er kode som andre har skrevet, og gjort tilg?ngeligt for andre at bruge.
echo.
echo %col_norm% I dette kursus er der installeret:
echo %col_norm% matplotlib:
echo %col_norm% Kan bruges til at lave scatterplot, histogrammer og generelt grafer af data
echo %col_norm% pandas:
echo %col_norm% Kan indl?se og manipulere data til og fra mange forskellige filformater
echo %col_norm% geopandas:
echo %col_norm% Udvider pandas til at kunne h?ndtere gis vectordata
echo %col_norm% xlrd:
echo %col_norm% Udvider pandas til at kunne h?ndtere excel
echo %col_norm% openpyxl:
echo %col_norm% En for at v?re helt sikker p? at integrationen med excel virker
echo %col_norm% psycopg2:
echo %col_norm% G?r det muligt at skrive SQL kommand?r til den database i f?r installeret"
echo %col_norm% SQL er et sprog i vil l?re mere om i de kommende kursusgange"
echo %col_norm% numpy:"
echo %col_norm%  "En pakke der g?r de andre pakker mange gange hurtigere"
echo %col_norm% Denne installation er ligeledes en "sikkerhedspakke" for at sikre den er med
echo %col_norm% requests:
echo %col_norm% En pakke der g?r det muligt at sende og modtage beskeder fra internettet
echo %col_norm% Den kan bruges til at hente data fra datastyrelsen, vejman samt mere til brug i et program

if not '%default%'=='--yes' (
pause
)

echo %col_norm% Python er nu installeret med de korrekte pakker i build milj?t hvor man kan skrive programmerne i, og k?re det fra
echo %col_norm% N?r du trykker enter, vil PyCharm IDE'en blive installeret

if not '%default%'=='--yes' (
pause
)

mkdir %root%\Pycharm

echo mode=user > "silent.config"
echo launcer32=0 >> "silent.config"
echo launcer64=1 >> "silent.config"
echo updatePATH=0 >> "silent.config"
echo updateContextMenu=0 >> "silent.config"
echo jre32=0 >> "silent.config"
echo regenerationSharedArchive=1 >> "silent.config"
echo .py=1 >> "silent.config"

echo.
echo %col_norm% Pycharm er nu igang med at blive installeret. Vent venligst
call %pycharm_file% /S /CONFIG=%root%\silent.config /D=%root%\Pycharm  >> %logfile%
echo %col_norm% Pycharm er installeret.

echo.
echo %col_norm% ---------------------------- PgAdmin skal nu s?ttes op til at bruge postgres databasen -------------------------------
echo %col_norm% Pycharm er som skrevet en IDE, hvor man kan skrive og k?re python
echo %col_norm% Et Integrated Development Environment (IDE) er dybest set en tekst editor med ekstra funktioner
echo %col_norm% Disse ekstra funktioner vil blive forklaret i en seperat video
echo %col_norm% PyCharm holder styr p? filerne indenfor et givet projekt
echo.





if not '%default%'=='--yes' (
pause
)

Rem Get PycharmProjects containing exercises
mkdir %root%\PycharmProjects
cd %root%\PycharmProjects


echo.
echo %col_norm% I dette kursus er projektet VTT6 oprettet med opgaver, samt mulighed for at i selv kan lave python programmer
echo %col_norm% N?r du trykker enter vil VTT6 projektet blive hentet ned
echo %col_impo% For at hente VTT6 projektet, bruges versionstyringsprogrammet git. HUSK at skrive 'y' n?r den beder om installationen


echo conda install -c conda-forge -y git >> %logfile%
call conda install -c conda-forge -y git >> %logfile%
echo git clone https://github.com/TRG-BUILD/VTT6.git >> %logfile%
call git clone https://github.com/TRG-BUILD/VTT6.git >> %logfile%
cd %root%



echo.
echo %col_norm% VTT6 er nu hentet ned p? computeren
echo %col_norm% Dette projekt vil v?re det prim?re sted for at lave opgaver og skrive filer
echo %col_norm% Sammenkoblingen af alle delene vil ske i slutningen af denne fil gennemgang
echo %col_norm% Som det sidste f?r sammenkoblingen, vil der blive downloadet postgresql og pgadmin til at h?ndtere databaser
echo.


Rem Install Postgres + PostGis
echo.
echo %col_norm% Postgresql og PgAdmin er ved at blive installeret. Vent venligst
echo %col_norm% V?lg Install For Me. Derefter vil filer blive udpakket og flyttet

REM echo %pgadmin_file% /VERYSILENT /NORESTART >> %logfile%
REM call %pgadmin_file% /VERYSILENT /NORESTART /DIR=%root%\pgAdmin >> %logfile%
REM echo powershell.exe -NoP -NonI -Command "Expand-Archive '.\%postgis_file%' '.\unziped\'" >> %logfile%
REM call powershell.exe -NoP -NonI -Command "Expand-Archive '.\%postgis_file%' '.\unziped\'" >> %logfile%
REM cd unziped
REM echo Robocopy %postgis_file:~0,-4% %USERPROFILE%\miniconda3\envs\build\Library /E /Z /MOVE >> %logfile%
REM call Robocopy %postgis_file:~0,-4% %USERPROFILE%\miniconda3\envs\build\Library /E /Z /MOVE >> %logfile%
cd %root%
REM echo %col_norm% PgAdmin og postgresqlinstalleret. Overskydende filer slettes



echo.
echo %col_norm% Der ops?ttes nu automatisk den database, som skal bruges i kurset
mkdir %root%\pgdatabase
echo initdb --encoding="UTF8" --pgdata=%root%\pgdatabase --auth=trust >> %logfile%
call initdb --encoding="UTF8" --pgdata=%root%\pgdatabase --auth=trust >> %logfile%
echo pg_ctl -D %USERPROFILE%\pgdatabase -l logfile start >> %logfile%
call pg_ctl -D %USERPROFILE%\pgdatabase -l logfile start


REM echo.
REM echo %col_impo% V?lg 'changeme' som password til den nye rolle (brugeren postgres)
REM echo %col_impo% Indtastningen er USYNLIG, og skal g?res to gange i streg
REM echo.
REM echo "createuser -P -s -e postgres"
REM call createuser -P -s -e postgres
REM echo createdb vttt "--owner=postgres --host=localhost --port=5432 --username=postgres --no-password" >> %logfile%
REM call createdb vttt "--owner=postgres --host=localhost --port=5432 --username=postgres --no-password"

echo.
echo %col_impo% ER DU N�ET HER TIL, men der st�r en fejl ovenfor, s� skal du _ikke_ geninstallere, men kontakte underviser

echo.
echo %col_norm% Postgresql er et program som h?ndtere databaser, og som du kan styre ved brug af programmeringssproget SQL
echo %col_norm% P? din computer er der nu oprettet en database der hedder 'vttt'
echo %col_norm% Denne database er valgt i kurset til at kunne tilg?s med brugernavnet 'postgres' og passwordet 'changeme'
echo %col_norm% Den k?re p? din computer, hvilket er 'hostes p? localhost' i tekniske termer
echo %col_norm% Den lytter desuden p? port 5432, hvilket er det 'sted' p? din computer andre programmer kan kontakte databasen
echo %col_norm% Ligeledes er PgAdmin installeret, som kan bruges til at se og bruge databasen


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_impo% Der mangler lige den sidste ops?tning der skal laves manuelt
echo %col_norm% N?r du trykker enter, vil instruktionerne for de sidste ops?tninger blive skrevet
echo %col_norm% Instruktionerne er delt op i 1 step ad gangen

if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% --------------------------- PgAdmin skal nu s?ttes op til at bruge postgres databasen ------------------------------

REM echo sqlite3 %USERPROFILE%\AppData\Roaming\pgadmin\pgadmin4.db "INSERT INTO server ("user_id", "servergroup_id", ssl_mode, "name", "host", "port", "maintenance_db", "username") VALUES ( 1, 1, 'prefer','vttt', 'localhost', '5432', 'postgres', 'postgres')"  >> %logfile%
REM sqlite3 %USERPROFILE%\AppData\Roaming\pgadmin\pgadmin4.db "INSERT INTO server ("user_id", "servergroup_id", ssl_mode, "name", "host", "port", "maintenance_db", "username") VALUES ( 1, 1, 'prefer','vttt', 'localhost', '5432', 'postgres', 'postgres')"
REM echo psql -U postgres -d vttt -c "CREATE EXTENSION postgis;"
REM psql -U postgres -d vttt -c "CREATE EXTENSION postgis;"

echo %col_norm% Til det skal du f?lge de her 5 steps:
echo %col_norm% 1. ?ben PgAdmin (s?g efter PgAdmin)
echo %col_norm%    Accepter betingelserne
echo %col_impo%    Til 'set master password' indtast 'changeme'


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 2. H?jre klik p? Servers (i ?vre venstre hj?rne) - Create - Server


if not '%default%'=='--yes' (
pause
)


echo.
echo %col_norm% 3. Angiv Name 'vttt', og tryk p? connection
echo %col_norm%    Angiv Host name/address 'localhost', og tryk "Save"


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 4. For at udf?re SQL kommandoer til databasen, skal du f?rst v?lge databasen 
echo %col_norm%    Helt ude til venstre, tryk p? vttt - Databases - vttt 
echo %col_norm%    Derefter se i den ?vre bl? bj?lke og tryk p? Tools - Query Tool
echo %col_norm%    Copy/paste denne kommando, for at aktivere postgis i databasen:
echo %col_impo%    create extension postgis;
echo %col_norm%    Tryk derefter p? F5 eller Play knappen ?verst til h?jre, for at sende SQL kommandoen til databasen 


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm%    PgAdmin er nu klar til at arbejde med data i databasen 'vttt'


if not '%default%'=='--yes' (
pause
)


echo.
echo %col_norm% ---------------------- PyCharm skal indstilles til at bruge conda's virtuelle milj? 'build' ------------------------
echo %col_norm% Til det skal du f?lge de her 7 steps
echo.
echo %col_norm% 1. ?ben PyCharm Community Edition (s?g efter Pycharm)
echo %col_norm%    Accepter betingelserne."


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 2. I popup vinduet, tryk p? "Open" og find projektet VTT6
echo %col_norm%    Projektet ligger i %root%\PycharmProjects
echo %col_norm%    I vil muligvis f? en besked i nedre h?jre hj?rne om at der mangler en github mappe
echo %col_norm%    Den mappe er fjernet, da i ikke har behov for det, s? i kan se bort fra fejlen


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 3. N?r projektet er ?bent, se da nederst i h?jre hj?rne under 'Event Log'
echo %col_norm%    Tryk p? 'No Interpreter' og dern?st tryk p? 'Add Interpreter'
echo %col_norm%    Der kan godt st? 'Python X.X' (hvor X er tal) istedet. Tryk stadig og v?lg 'Add Interpreter'


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 4. I popup vinduet skal du trykke p? 'conda environment' i venstre side
echo %col_norm%    Dern?st trykker du p? 'existing environments' og find s? en "Interpreter:" som hedder
echo %col_norm%    %root%\miniconda3\envs\build\python.exe 
echo %col_impo%    HUSK at tryk p? 'make available to all projects'
echo %col_norm%    Tryk s? OK, og der burde nu st? "Python 3.9 (build)" i nedre h?jre hj?rne


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 5. Python interpreteren bliver nu sat op i PyCharm. Det kan tage noget tid.
echo %col_norm%    N?r den hvide streg til venstre for Python 3.9 (build) er k?rt helt igennem,
echo %col_norm%    kan du forts?tte med n?ste instruktion


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 6. I ?vre venstre hj?rne, h?jre-klik p? 0test_setup.py
echo %col_norm%    Dern?st, tryk p? "Run" for at k?re filen


if not '%default%'=='--yes' (
pause
)

echo.
echo %col_norm% 7. Hvis programmet siger 'Alt korrekt installeret' i terminalen i bunden er alt ok
echo %col_norm%    Hvis programmet ikke siger 'Alt korrekt installeret', s? kontakt en underviser.


if not '%default%'=='--yes' (
pause
)


echo.
echo %col_norm% Alle programmer til dette kursus burde nu v?re korrekt installeret og opsat
echo %col_norm% Ved n?ste tryk lukker denne terminal, ellers tryk p? X til h?jre

::rmdir %root%\PycharmProjects\VTT6\.git /s /q
rmdir %root%\unziped /s /q

Rem Delete leftover files
del /s %root%\%miniconda_file%
del /s %root%\silent.config
del /s %root%\%pycharm_file%
del /s %root%\%pgadmin_file%
del /s %root%\%postgis_file%


goto end



:end

echo %col_norm% -------------------------------------------- Test af installationen --------------------------------------------------

call python %~dp0test_setup.py

echo.
echo "Installationen slutter"
pause
echo %col_impo% Lukker vinduet ikke s? brug krydset
