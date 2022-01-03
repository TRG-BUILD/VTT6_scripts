@ECHO off

:: Get variables 
call win_variables.bat


Rem This file installs and configures 3 parts
Rem     Miniconda and the base python installation, setting up the build conda environment
Rem     Pycharm and setting it up to the build environment python interpreter
Rem     Postgres, postgis and PgAdmin, and setting up the vttt database

Rem Introduction to what is going to happen
cd %root%
call :p_n "Denne fil vil installere alle de forn�dne programmer til kurset"
call :p_n "Samt give en kort beskrivelse af hvad der bliver installeret, og hvorfor"
call :p_n "Den forventede tid til installation samt ops�tning er ca. en time"
call :p_s
call :p_n "Dette program har tre forskellige farver"
call :p_n "Denne farve er hj�lpe tekst, som guider dig igennem installationen"
echo Denne farve er tekst skrevet af programmerne der installeres
call :p_i "Denne farve er n�r der er noget vigtigt du skal v�re opm�rksom p�"
call :p_s
call :p_i "F�R DU G�R IGANG"
call :p_i "Hav mindst 10GB plads ledig. Der gives hj�lp til afinstallation i slutningen af kurset"
call :p_i "S�rg for din antivirus er sl�t fra"
call :p_i "Hvis du f�r 'Access Denied' er din antivirus ikke sl�t fra (og denne fil her kan blive slettet)"
Rem If using a previous version of windows, AntiVirus will need to be disabled
call :p_i "Hvis du bruger en version tidligere end windows 10, s� luk terminalen og hent en hj�lpel�rer"
call :p_s
call :p_n "Installationen af hvert program vil give lidt tekst til at forst� hvad der er installeret, samt hvorfor det er relevant"
call :p_n "N�r du trykker enter, vil miniconda blive downloadet og installeret"
pause

Rem Make sure it is run in admin mode (to reduce errors)
call net session >nul 2>&1
if %errorlevel% == 0 (
    call :p_n "Installation af python p�begynder nu."
    ) else (
    call :p_i "Terminalen er ikke startet i administrator tilstand, hvilket kan give problemer"
    call :p_i "H�jre klikke p� filen og tryk "k�r som administrator""
    pause
    exit
    )




Rem Download files for windows.
mkdir %root%\miniconda3
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


call :p_n " miniconda er downloadet og ved at blive installeret. Vent venligst"
call %miniconda_file% /S /D=%root%\miniconda3

call :p_n "Miniconda installeret. Overskydende filer slettes"


call :p_n "Miniconda er er et program som holder styr p� programmeringssproget python"
call :p_n "N�r du trykker enter vil der blive oprettet et virtuelt milj� for python"
call :p_i "Tryk 'y' for at bekr�fte oprettelsen af det virtuelle milj�"
pause

Rem Activate AnacondaPrompt (only on windows)
call %root%/miniconda3/Scripts/activate.bat %root%\miniconda3

Rem Create Conda environment
call conda create -n build
call conda activate build
call conda config --add channels conda-forge

call :p_n "Virtuelt milj� build er oprettet"
call :p_n "Et virtuelt milj� er basalt set en python installation, som holdes adskilt fra andre python installationer"
call :p_n "Det vil sige, at de pakker vi bruger her i kurset til at udvide det basale python, "
call :p_n "ikke vil blive blandet sammen med andre installationer af python"
call :p_n "I l�bet af kurset har i kun behov for det ene virtuelle milj� (build) "
call :p_n "Hern�st vil der blive installeret pakker i build milj�t"
call :p_i "Tryk 'y' for at bekr�fte installationen af hver pakke. Der er 8 i alt"
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
call :p_n "En pakke (eller library p� engelsk) er kode som andre har skrevet,"
call :p_n "og gjort tilg�ngeligt for andre at bruge. Disse er n�sten altid gratis"
call :p_n "I dette kursus er der installeret:"
call :p_n "matplotlib:"
call :p_n "Kan bruges til at lave scatterplot, histogrammer og generelt grafer af data"
call :p_n "pandas:"
call :p_n "Kan indl�se og manipulere data til og fra mange forskellige filformater"
call :p_n "geopandas:"
call :p_n "Udvider pandas til at kunne h�ndtere gis vectordata"
call :p_n "xlrd:"
call :p_n "Udvider pandas til at kunne h�ndtere excel"
call :p_n "openpyxl:"
call :p_n "En for at v�re helt sikker p� at integrationen med excel virker"
call :p_n "psycopg2:"
call :p_n "G�r det muligt at skrive SQL kommand�r til den database i f�r installeret"
call :p_n "SQL er et sprog i vil l�re mere om i de kommende kursusgange"
call :p_n "numpy:"
call :p_n "En pakke der g�r de andre pakker mange gange hurtigere"
call :p_n "Denne installation er ligeledes en "sikkerhedspakke" for at sikre den er med"
call :p_n "requests:"
call :p_n "En pakke der g�r det muligt at sende og modtage beskeder fra internettet"
call :p_n "Den kan bruges til at hente data fra datastyrelsen, vejman samt mere til brug i et program"
pause
call :p_n "Python er nu installeret med de korrekte pakker i build milj�t"
call :p_n "For at kunne bruge python, er det smart at bruge en IDE,"
call :p_n "hvor man kan skrive programmerne i, og k�re det fra"
call :p_n "N�r du trykker enter, vil PyCharm IDE'en blive installeret"
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



call :p_n "Pycharm er som skrevet en IDE, hvor man kan skrive og k�re python"
call :p_n "Et Integrated Development Environment (IDE) er dybest set en tekst editor med ekstra funktioner"
call :p_n "Disse ekstra funktioner vil blive forklaret i en seperat video"
call :p_n "Pycharm holder styr p� filerne indenfor et givet projekt"
call :p_n "I dette kursus er projektet VTT6 oprettet med opgaver, samt mulighed for at i selv kan lave python programmer"
call :p_n "N�r du trykker enter vil VTT6 projektet blive hentet ned"
call :p_i "For at hente VTT6 projektet, bruges programmet git. HUSK at skrive 'y' n�r den beder om installationen"
pause

Rem Get PycharmProjects containing exercises
mkdir %root%\PycharmProjects
cd %root%\PycharmProjects

call conda install -c conda-forge git
git clone https://github.com/TRG-BUILD/VTT6.git
cd %root%

call :p_n "VTT6 er nu hentet ned p� computeren"
call :p_n "Dette projekt vil v�re det prim�re sted for at lave opgaver og skrive filer"
call :p_n "Sammenkoblingen af alle delene vil ske i slutningen af denne fil gennemgang"
call :p_n "Som det sidste f�r sammenkoblingen, vil der blive downloadet postgresql og pgadmin til at h�ndtere databaser"
pause

Rem Install Postgres + PostGis

call :p_n "Postgresql og PgAdmin er ved at blive installeret. Vent venligst"
call :p_n "V�lg Install For Me. Derefter vil filer blive udpakket og flyttet"
call %pgadmin_file% /VERYSILENT /NORESTART
call powershell.exe -NoP -NonI -Command "Expand-Archive '.\%postgis_file%' '.\unziped\'"
cd unziped
call Robocopy postgis %root%\miniconda3\envs\build\Library /E /Z /MOVE
cd %root%
call :p_n "PgAdmin og postgresqlinstalleret. Overskydende filer slettes"
rmdir %root%\PycharmProjects\VTT6\.git /s /q
rmdir %root%\unziped /s /q


call :p_n "Der ops�ttes nu automatisk den database, som skal bruges i kurset"

Rem Create a database cluster with superuser = %USERNAME% (no password)
mkdir pgdatabase
call initdb --encoding="UTF8" --pgdata=%root%\pgdatabase --auth=trust
call pg_ctl -D %root%\pgdatabase -l logfile start
call :p_i "V�lg 'changeme' som password til den nye rolle (brugeren postgres)"
call :p_i "Indtastningen er USYNLIG, og skal g�res to gange i streg"
call createuser -P -s -e postgres
call createdb vttt "--owner=postgres --host=localhost --port=5432 --username=postgres --no-password"

call :p_n "Postgresql er et program som h�ndtere databaser, og som du kan styre ved brug af programmeringssproget SQL"
call :p_n "P� din computer er der nu oprettet en database der hedder 'vttt'"
call :p_n "Denne database er valgt i kurset til at kunne tilg�s med brugernavnet 'postgres' og passwordet 'changeme'"
call :p_n "Den k�re p� din computer, hvilket er 'hostes p� localhost' i tekniske termer"
call :p_n "Den lytter desuden p� port 5432, hvilket er det 'sted' p� din computer andre programmer kan kontakte databasen"
call :p_n "Ligeledes er PgAdmin installeret, som kan bruges til at se og bruge databasen"

pause

call :p_i "Der mangler lige den sidste ops�tning der skal laves manuelt"
call :p_n "N�r du trykker enter, vil instruktionerne for de sidste ops�tninger blive skrevet"
call :p_n "Instruktionerne er delt op i 1 step ad gangen"

pause

call :p_n "Databasen som vi har lavet med postgresql vil kunne tilg�s fra PgAdmin"
call :p_n "Til det skal du f�lge de her 5 steps:"
call :p_n "----------------------------------------------------------------------"
call :p_n "1. �ben PgAdmin (s�g efter PgAdmin)"
call :p_n "   Accepter betingelserne"
call :p_i "   Til 'set master password' indtast 'changeme'"

pause

call :p_n "2. H�jre klik p� Servers (i �vre venstre hj�rne) - Create - Server"

pause

call :p_n "3. Angiv Name 'vttt', og tryk p� connection"
call :p_n "   Angiv Host name/address 'localhost', og tryk 'Save'"

pause

call :p_n "4. For at udf�re SQL kommandoer til databasen, skal du f�rst v�lge databasen "
call :p_n "   Helt ude til venstre, tryk p� vttt - Databases - vttt "
call :p_n "   Derefter se i den �vre bl� bj�lke og tryk p� Tools - Query Tool"
call :p_n "   Copy/paste denne kommando, for at aktivere postgis i databasen:"
call :p_i "   create extension postgis;"
call :p_n "   Tryk derefter p� F5 eller Play knappen �verst til h�jre, for at sende SQL kommand�n til databasen "

pause

call :p_n "   PgAdmin og databasen vttt burde nu v�re korrekt opsat sammen"
call :p_n "   Desuden er databasen nu opsat til at kunne h�ndtere GIS data"

pause
cls

call :p_n "build milj�t, der har alle pakkerne installeret, skal kobles sammen med Pycharm"
call :p_n "Til det skal du f�lge de her 7 steps"
call :p_n "----------------------------------------------------------------------"
call :p_n "1. �ben PyCharm Community Edition (s�g efter Pycharm)"
call :p_n "   Accepter betingelserne."

pause

call :p_n "2. I popup vinduet, tryk p� "Open" og find projektet VTT6"
call :p_n "   Projektet ligger i %root%\PycharmProjects"
call :p_n "   I vil muligvis f� en besked i nedre h�jre hj�rne om at der mangler en github mappe"
call :p_n "   Den mappe er fjernet, da i ikke har behov for det, s� i kan se bort fra fejlen"

pause

call :p_n "3. N�r projektet er �bent, se da nederst i h�jre hj�rne under 'Event Log'"
call :p_n "   Tryk p� 'No Interpreter' og dern�st tryk p� "Add Interpreter""
call :p_n "   Der kan godt st� 'Python X.X' (hvor X er tal) istedet. Tryk stadig og v�lg Add Interpreter "

pause

call :p_n "4. I popup vinduet skal du trykke p� 'conda environment' i venstre side"
call :p_n "   Dern�st trykker du p� 'existing environments' og find s� en 'Interpreter:' som hedder"
call :p_n "   %root%\miniconda3\envs\build\python.exe "
call :p_i "   HUSK at tryk p� 'make available to all projects'"
call :p_n "   Tryk s� OK, og der burde nu st� 'Python 3.9 (build)' i nedre h�jre hj�rne"
pause
call :p_n "5. Python interpreteren bliver nu sat op i PyCharm. Det kan tage noget tid.
call :p_n "   N�r den hvide streg til venstre for Python 3.9 (build) er k�rt helt igennem, "
call :p_n "   kan du forts�tte med n�ste instruktion"
pause
call :p_n "6. I �vre venstre hj�rne, h�jre-klik p� 0test_setup.py"
call :p_n "   Dern�st, tryk p� "Run" for at k�re filen"
pause
call :p_n "7. Hvis programmet siger 'Alt korrekt installeret' i terminalen i bunden er alt ok"
call :p_n "   Hvis programmet ikke siger 'Alt korrekt installeret', s� kontakt en underviser."
pause

call :p_n "Alle programmer til dette kursus burde nu v�re korrekt installeret og opsat"
call :p_n "Ved n�ste tryk lukker denne terminal, ellers tryk p� X til h�jre"

Rem Delete leftover files
del /s %root%\%miniconda_file%
del /s %root%\silent.config
del /s %root%\%pycharm_file%
del /s %root%\%pgadmin_file%
del /s %root%\%postgis_file%
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