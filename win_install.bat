@ECHO off

:: Get variables 
call win_variables.bat


Rem This file installs and configures 3 parts
Rem     Miniconda and the base python installation, setting up the build conda environment
Rem     Pycharm and setting it up to the build environment python interpreter
Rem     Postgres, postgis and PgAdmin, and setting up the vttt database

Rem Introduction to what is going to happen
cd %root%
call :p_n "Denne fil vil installere alle de fornødne programmer til kurset"
call :p_n "Samt give en kort beskrivelse af hvad der bliver installeret, og hvorfor"
call :p_n "Den forventede tid til installation samt opsætning er ca. en time"
call :p_s
call :p_n "Dette program har tre forskellige farver"
call :p_n "Denne farve er hjælpe tekst, som guider dig igennem installationen"
echo Denne farve er tekst skrevet af programmerne der installeres
call :p_i "Denne farve er når der er noget vigtigt du skal være opmærksom på"
call :p_s
call :p_i "FØR DU GÅR IGANG"
call :p_i "Hav mindst 10GB plads ledig. Der gives hjælp til afinstallation i slutningen af kurset"
call :p_i "Sørg for din antivirus er slæt fra"
call :p_i "Hvis du får 'Access Denied' er din antivirus ikke slæt fra (og denne fil her kan blive slettet)"
Rem If using a previous version of windows, AntiVirus will need to be disabled
call :p_i "Hvis du bruger en version tidligere end windows 10, så luk terminalen og hent en hjælpelærer"
call :p_s
call :p_n "Installationen af hvert program vil give lidt tekst til at forstå hvad der er installeret, samt hvorfor det er relevant"
call :p_n "Når du trykker enter, vil miniconda blive downloadet og installeret"
pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorlevel% == 0 (
    call :p_n "Installation af python påbegynder nu."
    ) else (
    call :p_i "Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer"
    call :p_i "Højre klikke på filen og tryk "kør som administrator""
    pause
    exit
    )




Rem Download files for windows.
mkdir %root%\miniconda3
call bitsadmin /create minicondaInstall
call bitsadmin /transfer minicondaInstall %miniconda_url%  %root%\%miniconda_file%
call bitsadmin /complete minicondaInstall

call bitsadmin /create pycharmInstall
call bitsadmin /transfer pycharmInstall https://download.jetbrains.com/python/pycharm-community-2021.1.3.exe %root%\pycharm.exe
call bitsadmin /complete pycharmInstall

call bitsadmin /create pgadminInstall
call bitsadmin /transfer pgadminInstall https://ftp.postgresql.org/pub/pgadmin/pgadmin4/v6.3/windows/pgadmin4-6.3-x64.exe %root%\pgadmin.exe
call bitsadmin /complete pgadminInstall

call bitsadmin /create postgisInstall
call bitsadmin /transfer postgisInstall http://download.osgeo.org/postgis/windows/pg13/postgis-bundle-pg13-3.1.2x64.zip %root%\postgis-bundle-pg13-3.1.2x64.zip
call bitsadmin /complete postgisInstall


call :p_n " miniconda er downloadet og ved at blive installeret. Vent venligst"
call %miniconda_file% /S /D=%root%\miniconda3

call :p_n "Miniconda installeret. Overskydende filer slettes"


call :p_n "Miniconda er er et program som holder styr på programmeringssproget python"
call :p_n "Når du trykker enter vil der blive oprettet et virtuelt miljø for python"
call :p_i "Tryk 'y' for at bekræfte oprettelsen af det virtuelle miljø"
pause

Rem Activate AnacondaPrompt (only on windows)
call %root%/miniconda3/Scripts/activate.bat %root%\miniconda3

Rem Create Conda environment
call conda create -n build
call conda activate build
call conda config --add channels conda-forge

call :p_n "Virtuelt miljø build er oprettet"
call :p_n "Et virtuelt miljø er basalt set en python installation, som holdes adskilt fra andre python installationer"
call :p_n "Det vil sige, at de pakker vi bruger her i kurset til at udvide det basale python, "
call :p_n "ikke vil blive blandet sammen med andre installationer af python"
call :p_n "I løbet af kurset har i kun behov for det ene virtuelle miljø (build) "
call :p_n "Hernæst vil der blive installeret pakker i build miljøt"
call :p_i "Tryk 'y' for at bekræfte installationen af hver pakke. Der er 8 i alt"
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

call :p_n "Alle python pakkerne er installeret korrekt"
call :p_n "En pakke (eller library på engelsk) er kode som andre har skrevet,"
call :p_n "og gjort tilgængeligt for andre at bruge. Disse er næsten altid gratis"
call :p_n "I dette kursus er der installeret:"
call :p_n "matplotlib:"
call :p_n "Kan bruges til at lave scatterplot, histogrammer og generelt grafer af data"
call :p_n "pandas:"
call :p_n "Kan indlæse og manipulere data til og fra mange forskellige filformater"
call :p_n "geopandas:"
call :p_n "Udvider pandas til at kunne håndtere gis vectordata"
call :p_n "xlrd:"
call :p_n "Udvider pandas til at kunne håndtere excel"
call :p_n "openpyxl:"
call :p_n "En for at være helt sikker på at integrationen med excel virker"
call :p_n "psycopg2:"
call :p_n "Gør det muligt at skrive SQL kommandør til den database i får installeret"
call :p_n "SQL er et sprog i vil lære mere om i de kommende kursusgange"
call :p_n "numpy:"
call :p_n "En pakke der gør de andre pakker mange gange hurtigere"
call :p_n "Denne installation er ligeledes en "sikkerhedspakke" for at sikre den er med"
call :p_n "requests:"
call :p_n "En pakke der gør det muligt at sende og modtage beskeder fra internettet"
call :p_n "Den kan bruges til at hente data fra datastyrelsen, vejman samt mere til brug i et program"
pause
call :p_n "Python er nu installeret med de korrekte pakker i build miljøt"
call :p_n "For at kunne bruge python, er det smart at bruge en IDE,"
call :p_n "hvor man kan skrive programmerne i, og køre det fra"
call :p_n "Når du trykker enter, vil PyCharm IDE'en blive installeret"
pause

Rem Download Pycharm
mkdir %root%\Pycharm

echo mode=user > "silent.config"
echo launcer32=0 >> "silent.config"
echo launcer64=1 >> "silent.config"
echo updatePATH=0 >> "silent.config"
echo updateContextMenu=0 >> "silent.config"
echo jre32=0 >> "silent.config"
echo regenerationSharedArchive=1 >> "silent.config"
echo .py=1 >> "silent.config"

call :p_n "Pycharm er nu igang med at blive installeret. Vent venligst"

Rem Install Pycharm
call %pycharm_file% /S /CONFIG=%root%\silent.config /D=%root%\Pycharm

call :p_n "Pycharm installeret. Overskydende filer slettes"



call :p_n "Pycharm er som skrevet en IDE, hvor man kan skrive og køre python"
call :p_n "Et Integrated Development Environment (IDE) er dybest set en tekst editor med ekstra funktioner"
call :p_n "Disse ekstra funktioner vil blive forklaret i en seperat video"
call :p_n "Pycharm holder styr på filerne indenfor et givet projekt"
call :p_n "I dette kursus er projektet VTT6 oprettet med opgaver, samt mulighed for at i selv kan lave python programmer"
call :p_n "Når du trykker enter vil VTT6 projektet blive hentet ned"
call :p_i "For at hente VTT6 projektet, bruges programmet git. HUSK at skrive 'y' når den beder om installationen"
pause

Rem Get PycharmProjects containing exercises
mkdir %root%\PycharmProjects
cd %root%\PycharmProjects

call conda install -c conda-forge git
git clone https://github.com/TRG-BUILD/VTT6.git
cd %root%

call :p_n "VTT6 er nu hentet ned på computeren"
call :p_n "Dette projekt vil være det primære sted for at lave opgaver og skrive filer"
call :p_n "Sammenkoblingen af alle delene vil ske i slutningen af denne fil gennemgang"
call :p_n "Som det sidste før sammenkoblingen, vil der blive downloadet postgresql og pgadmin til at håndtere databaser"
pause

Rem Install Postgres + PostGis

call :p_n "Postgresql og PgAdmin er ved at blive installeret. Vent venligst"
call :p_n "Vælg Install For Me. Derefter vil filer blive udpakket og flyttet"
call %pgadmin_file% /VERYSILENT /NORESTART
call powershell.exe -NoP -NonI -Command "Expand-Archive '.\%postgis_file%' '.\unziped\'"
cd unziped
call Robocopy postgis %root%\miniconda3\envs\build\Library /E /Z /MOVE
cd %root%
call :p_n "PgAdmin og postgresqlinstalleret. Overskydende filer slettes"
rmdir %root%\PycharmProjects\VTT6\.git /s /q
rmdir %root%\unziped /s /q


call :p_n "Der opsættes nu automatisk den database, som skal bruges i kurset"

Rem Create a database cluster with superuser = %USERNAME% (no password)
mkdir pgdatabase
call initdb --encoding="UTF8" --pgdata=%root%\pgdatabase --auth=trust
call pg_ctl -D %root%\pgdatabase -l logfile start
call :p_i "Vælg 'changeme' som password til den nye rolle (brugeren postgres)"
call :p_i "Indtastningen er USYNLIG, og skal gøres to gange i streg"
call createuser -P -s -e postgres
call createdb vttt "--owner=postgres --host=localhost --port=5432 --username=postgres --no-password"

call :p_n "Postgresql er et program som håndtere databaser, og som du kan styre ved brug af programmeringssproget SQL"
call :p_n "På din computer er der nu oprettet en database der hedder 'vttt'"
call :p_n "Denne database er valgt i kurset til at kunne tilgæs med brugernavnet 'postgres' og passwordet 'changeme'"
call :p_n "Den køre på din computer, hvilket er 'hostes på localhost' i tekniske termer"
call :p_n "Den lytter desuden på port 5432, hvilket er det 'sted' på din computer andre programmer kan kontakte databasen"
call :p_n "Ligeledes er PgAdmin installeret, som kan bruges til at se og bruge databasen"

pause

call :p_i "Der mangler lige den sidste opsætning der skal laves manuelt"
call :p_n "Når du trykker enter, vil instruktionerne for de sidste opsætninger blive skrevet"
call :p_n "Instruktionerne er delt op i 1 step ad gangen"

pause

call :p_n "Databasen som vi har lavet med postgresql vil kunne tilgås fra PgAdmin"
call :p_n "Til det skal du følge de her 5 steps:"
call :p_n "----------------------------------------------------------------------"
call :p_n "1. åben PgAdmin (søg efter PgAdmin)"
call :p_n "   Accepter betingelserne"
call :p_i "   Til 'set master password' indtast 'changeme'"

pause

call :p_n "2. Højre klik på Servers (i øvre venstre hjørne) - Create - Server"

pause

call :p_n "3. Angiv Name 'vttt', og tryk på connection"
call :p_n "   Angiv Host name/address 'localhost', og tryk 'Save'"

pause

call :p_n "4. For at udføre SQL kommandoer til databasen, skal du først vælge databasen "
call :p_n "   Helt ude til venstre, tryk på vttt - Databases - vttt "
call :p_n "   Derefter se i den øvre blå bjælke og tryk på Tools - Query Tool"
call :p_n "   Copy/paste denne kommando, for at aktivere postgis i databasen:"
call :p_i "   create extension postgis;"
call :p_n "   Tryk derefter på F5 eller Play knappen øverst til højre, for at sende SQL kommandøn til databasen "

pause

call :p_n "   PgAdmin og databasen vttt burde nu være korrekt opsat sammen"
call :p_n "   Desuden er databasen nu opsat til at kunne håndtere GIS data"

pause
cls

call :p_n "build miljøt, der har alle pakkerne installeret, skal kobles sammen med Pycharm"
call :p_n "Til det skal du følge de her 7 steps"
call :p_n "----------------------------------------------------------------------"
call :p_n "1. åben PyCharm Community Edition (søg efter Pycharm)"
call :p_n "   Accepter betingelserne."

pause

call :p_n "2. I popup vinduet, tryk på "Open" og find projektet VTT6"
call :p_n "   Projektet ligger i %root%\PycharmProjects"
call :p_n "   I vil muligvis få en besked i nedre højre hjørne om at der mangler en github mappe"
call :p_n "   Den mappe er fjernet, da i ikke har behov for det, så i kan se bort fra fejlen"

pause

call :p_n "3. Når projektet er åbent, se da nederst i højre hjørne under 'Event Log'"
call :p_n "   Tryk på 'No Interpreter' og dernæst tryk på "Add Interpreter""
call :p_n "   Der kan godt stå 'Python X.X' (hvor X er tal) istedet. Tryk stadig og vælg Add Interpreter "

pause

call :p_n "4. I popup vinduet skal du trykke på 'conda environment' i venstre side"
call :p_n "   Dernæst trykker du på 'existing environments' og find så en 'Interpreter:' som hedder"
call :p_n "   %root%\miniconda3\envs\build\python.exe "
call :p_i "   HUSK at tryk på 'make available to all projects'"
call :p_n "   Tryk så OK, og der burde nu stå 'Python 3.9 (build)' i nedre højre hjørne"
pause
call :p_n "5. Python interpreteren bliver nu sat op i PyCharm. Det kan tage noget tid.
call :p_n "   Når den hvide streg til venstre for Python 3.9 (build) er kørt helt igennem, "
call :p_n "   kan du fortsætte med næste instruktion"
pause
call :p_n "6. I øvre venstre hjørne, højre-klik på 0test_setup.py"
call :p_n "   Dernæst, tryk på "Run" for at køre filen"
pause
call :p_n "7. Hvis programmet siger 'Alt korrekt installeret' i terminalen i bunden er alt ok"
call :p_n "   Hvis programmet ikke siger 'Alt korrekt installeret', så kontakt en underviser."
pause

call :p_n "Alle programmer til dette kursus burde nu være korrekt installeret og opsat"
call :p_n "Ved næste tryk lukker denne terminal, ellers tryk på X til højre"

Rem Delete leftover files
del /s %root%\%miniconda_file%
del /s %root%\silent.config
del /s %root%\%pycharm_file%
del /s %root%\%pgadmin_file%
del /s %root%\%postgis_file%
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