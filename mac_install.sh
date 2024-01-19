#!/bin/zsh

# Set variables
export CONDA_ALWAYS_YES="true"

# Import functions to script
. ./shell_functions.sh

# This file installs and configures 3 parts
#     Miniconda and the base python installation, setting up the build conda environment
#     Pycharm and setting it up to the build environment python interpreter
#     Postgres, postgis and PgAdmin, and setting up the vttt database

clear

# Introduction to what is going to happen
p_n "Der skal afvikles to filer for at installere alt software til brug i kurset Vej- og Trafikdatabehandling"
p_n "Denne fil vil installere to pakkehåndteringsprogrammer, homebrew og miniconda, hvor igennem vi installere resten af softwaren."
p_s
p_n "Den forventede tid til den samlede installation samt opsætning er ca. en time"
p_s
p_n "Dette program har tre forskellige farver"
p_n "Denne farve er hjælpe tekst, som guider dig igennem installationen"
echo Denne farve er tekst skrevet af programmerne der installeres
p_i "Denne farve er når der er noget vigtigt du skal være opmærksom på"
p_s
p_i "----------------------------------"
p_i "FØR DU GÅR IGANG"
p_i "Hav mindst 10GB ledig plads."
p_i "Nogle af programmerne vil kræve dit password til denne computer, du vil blive bedt om det når det er nødvendigt."
p_i "----------------------------------"
p_s
p_n "Installationen af hvert program vil præsenterer lidt tekst til at forstå hvad der er installeret, samt hvorfor det er relevant"
p_n "Når du trykker enter, vil miniconda blive downloadet og installeret"
read something

# Download homebrew (only for mac)
cd $root
which -s brew
if [[ $? != 0 ]] ; then
    # Install Homebrew
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    echo "Homebrew er allerede installeret, skipper installation af den."
    #brew update
fi

p_s
# Download miniconda sh.

which -s conda
if [[ $? != 0 ]] ; then
    # Install miniconda
    brew install --cask miniconda
    conda init "$(basename "${SHELL}")"
else
    echo "conda er allerede installet, skipper installation af den."
fi

source "$shellrc"
source /usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh
conda update -n base -c defaults conda
conda create -n "${environment_name}"
conda activate "${environment_name}"
conda config --add channels conda-forge

#p_s
#p_n "Miniconda er er et pakkehåndterings program der kan holde styre på udviklingsmiljøet python du skal arbejde i."
#p_s
#p_n "Terminalen skal genstartes nu. Derefter skal du afvikle mac_install_2.sh"
#p_s
#p_i "Tryk på enter, og luk derefter terminalen. Start så den anden installations fil"
#read something

p_n "Virtuelt miljø build er oprettet "
p_n "Et virtuelt miljø er basalt set en python installation, som holdes adskilt fra andre python installationer "
p_n "Det vil sige, at de pakker vi bruger her i kurset til at udvide det basale python,  "
p_n "ikke vil blive blandet sammen med andre installationer af python "
p_n "I løbet af kurset har i kun behov for det ene virtuelle miljø kaldet build  "
p_n "Hernæst vil der blive installeret pakker i build miljøt "
p_i "Tryk 'y' for at bekræfte installationen af hver pakke. Der er 8 i alt "
p_n "Tryk enter for at fortsætte "
read something

# Download python packages
conda install -c conda-forge numpy
conda install -c conda-forge matplotlib
conda install -c conda-forge xlrd
conda install -c conda-forge openpyxl
conda install -c conda-forge pandas
conda install -c conda-forge geopandas
conda install -c conda-forge psycopg2
conda install -c conda-forge requests


p_n "Alle python pakkerne er installeret korrekt "
p_n "En pakke eller library på engelsk er kode som andre har skrevet, "
p_n "og gjort tilgængeligt for andre at bruge. Disse er næsten altid gratis "
p_n "I dette kursus er der installeret: "
p_n "matplotlib: "
p_n "Kan bruges til at lave scatterplot, histogrammer og generelt grafer af data "
p_n "pandas: "
p_n "Kan indlæse og manipulere data til og fra mange forskellige filformater "
p_n "geopandas: "
p_n "Udvider pandas til at kunne håndtere \3D koordinator med GIS "
p_n "xlrd: "
p_n "Udvider pandas til at kunne håndtere excel "
p_n "openpyxl: "
p_n "En sikkerhedspakke for at være helt sikker på at integrationen med excel virker "
p_n "psycopg2: "
p_n "Gør det muligt at skrive SQL kommandør til den database i får installeret "
p_n "SQL er et sprog i vil lære mere om i de kommende kursusgange "
p_n "numpy: "
p_n "En pakke der gør de andre pakker mange gange hurtigere "
p_n "Denne installation er ligeledes en sikkerhedspakke for at sikre den er med "
p_n "requests: "
p_n "En pakke der gør det muligt at sende og modtage beskeder fra internettet "
p_n "Den kan bruges til at hente data fra datastyrelsen, vejman samt mere til brug i et program "
p_n "Tryk enter for at fortsætte "
read something
p_n "Python er nu installeret med de korrekte pakker i build miljøt "
p_n "For at kunne bruge python, er det smart at bruge en IDE, "
p_n "hvor man kan skrive programmerne i, og køre det fra "
p_n "Når du trykker enter, vil PyCharm IDEen blive installeret "
p_i "Du vil blive bedt om at indtaste dit kodeord du bruger på denne computer "
p_n "Tryk enter for at fortsætte "
read something

# Download and setup Pycharm
sudo mkdir ~/.matplotlib
sudo chmod -R 755 ~/.matplotlib
sudo chown -R $USER ~/.matplotlib
sudo echo "backend: MacOSX" >> ~/.matplotlib/matplotlibrc

p_n "Pycharm er nu igang med at blive installeret"
brew install --cask pycharm-ce

p_n "Pycharm er som skrevet en IDE, hvor man kan skrive og køre python "
p_n "-----"
p_n "Et Integrated Development Environment kaldet en IDE er dybest set en tekst editor med ekstra funktioner "
p_n "Disse ekstra funktioner vil blive forklaret i en seperat video "
p_n "Pycharm holder styr på filerne indenfor et givet projekt "
p_n "I dette kursus er projektet VTT6 oprettet med opgaver, samt mulighed for at i selv kan lave python programmer "
p_n "Når du trykker enter vil VTT6 projektet blive hentet ned "
p_i "For at hente VTT6 projektet, bruges programmet git. HUSK at skrive y når den beder om installationen "
p_n "Tryk enter for at fortsætte "
read something

# Get PycharmProjects containing exercises
sudo mkdir ~/PycharmProjects
sudo chmod -R 755 ~/PycharmProjects
sudo chown -R $USER ~/PycharmProjects
cd $root/PycharmProjects
conda install -c conda-forge git
git clone https://github.com/TRG-BUILD/VTT6.git
cd $root

p_n "VTT6 er nu hentet ned på computeren "
p_n "Dette projekt vil være det primære sted for at lave opgaver og skrive filer "
p_n "Sammenkoblingen af alle delene vil ske i slutningen af denne fil gennemgang "
p_n "Som det sidste før sammenkoblingen, vil der blive downloadet postgresql og pgadmin til at håndtere databaser "
p_n "Tryk enter for at fortsætte "
read something

# Install Postgres + PostGis + PgAdmin
#conda install -c conda-forge postgresql=14.1
#conda install -c conda-forge postgis
brew install --cask pgadmin4

#p_n "Der opsættes nu automatisk den database, som skal bruges i kurset "

# Create a database cluster with superuser = %USERNAME% (no password)
#sudo mkdir ~/pgdatabase
#sudo chmod -R 755 ~/pgdatabase
#sudo chown -R $USER ~/pgdatabase
#initdb --encoding="UTF8" --pgdata=$root/pgdatabase --auth=trust
#pg_ctl -D $root/pgdatabase -l logfile start
#p_i "Vælg changeme som password til den nye rolle som er brugeren postgres "
#p_i "Indtastningen er USYNLIG, og skal gøres to gange i streg "
#createuser -P -s -e postgres
#createdb vttt --owner=postgres --host=localhost --port=5432 --username=postgres --no-password

#p_n "Postgresql er et program som håndtere databaser, og som du kan styre ved brug af programmeringssproget SQL "
#p_n "På din computer er der nu oprettet en database der hedder vttt "
#p_n "Denne database er valgt i kurset til at kunne tilgæs med brugernavnet postgres og passwordet changeme "
#p_n "Den køre på din computer, hvilket hedder hostes på localhost i tekniske termer "
#p_n "Den lytter desuden på port 5432, hvilket er det sted på din computer andre programmer kan kontakte databasen "
#p_n "Ligeledes er PgAdmin installeret, som kan bruges til at se og bruge databasen "
#p_n "Tryk enter for at fortsætte "
#read something

clear

p_i "Der mangler lige den sidste opsætning der skal laves manuelt "
p_n "Når du trykker enter, vil instruktionerne for de sidste opsætninger blive skrevet "
p_n "Instruktionerne er delt op i 1 step ad gangen "
p_n "Tryk enter for at fortsætte "
read something

p_n "Databasen som vi har lavet med postgresql skal kunne tilgås fra PgAdmin "
p_n "Til det skal du følge de her 5 steps: "
p_n "1. åben PgAdmin brug evt finder til at søge efter PgAdmin "
p_n "   Sig at du stoler på programmet, tryk Open "
p_i "   Når den åbner, sæt master password til changeme "
p_n "Tryk enter for at fortsætte "
read something

p_n "2. Ctrl klik på Servers som findes i øvre venstre hjørne, vælg Create -> Server "
p_n "Tryk enter for at fortsætte "
read something

p_n "3. Angiv Name vttt, og tryk på connection "
p_n "   Angiv Host name/address til at være localhost, og tryk Save "
p_n "Tryk enter for at fortsætte "
read something

p_n "4. For at udføre SQL kommandør til databasen, skal du først vælge databasen  "
p_n "   Helt ude til venstre, tryk på vttt -> Databases -> vttt  "
p_n "   Derefter se i den øvre blå bjælke og tryk på Tools -> Query Tool "
p_n "   Hvis PgAdmin er åben i en lille skærm, er bjælken gemt i en menu øvre venstre hjørne "
p_n "   Copy/paste denne kommando, for at aktivere postgis i databasen: " create extension postgis\;
p_n "   Tryk derefter på F5 eller Play knappen øverst til højre, for at sende SQL kommandøn til databasen "
p_n "Tryk enter for at fortsætte "
read something

p_n "   PgAdmin og databasen vttt burde nu være korrekt opsat sammen "
p_n "   Desuden er databasen nu opsat til at kunne håndtere GIS data "
p_n "Tryk enter for at fortsætte "
read something

p_n "build miljøt, der har alle pakkerne installeret, skal kobles sammen med Pycharm "
p_n "Til det skal du følge de her \7 steps "
p_n "1. åben PyCharm Community Edition ved brug af Finder eksempelvis "
p_n "   Sig at du stoler på programmet, tryk Open "
p_n "   Accepter desuden betingelserne "
p_n "Tryk enter for at fortsætte "
read something

p_n "2. I popup vinduet, tryk på Open og find projektet PyCharmProjects "
p_n "   Dobbelt klik og åben projektet. Der skulle stå VTT6 i øvre venstre hjørne et sted "
p_n "Tryk enter for at fortsætte "
read something

p_n "3. Når projektet er åbent, se da nederst i højre hjørne under Event Log "
p_n "   Tryk på No Interpreter og dernæst tryk på Add Interpreter "
p_n "   Der kan godt stå Python X.X \(hvor X er tal\) istedet. Tryk stadig og vælg Add Interpreter "
p_n "Tryk enter for at fortsætte "
read something

p_n "4. I popup vinduet skal du trykke på conda environment i venstre side "
p_n "   Dernæst trykker du på existing environments og find så en Interpreter: som hedder "
p_n "   /usr/local/Caskroom/miniconda/base/envs/build/bin/python  "
p_i "   Det vigtige er at der står build i navnet "
p_i "   HUSK at tryk på make available to all projects "
p_n "   Tryk så OK, og der burde nu stå Python \3.\10 \(build\) i nedre højre hjørne "
p_n "Tryk enter for at fortsætte "
read something

p_n "5. Python interpreteren bliver nu sat op i PyCharm. Det kan tage noget tid.
p_n "   Når den hvide streg til venstre for Python \3.\10101010101010101010 \(build\) er kørt helt igennem,  "
p_n "   kan du fortsætte med næste instruktion "
p_n "Tryk enter for at fortsætte "
read something

p_n "6. I øvre venstre hjørne, ctrl klik på \0test_setup.py "
p_n "   Dernæst, tryk på Run for at køre filen "
p_n "Tryk enter for at fortsætte "
read something

p_n "7. Hvis programmet siger Alt korrekt installeret i terminalen i bunden er alt ok "
p_i "   Hvis programmet ikke siger Alt korrekt installeret, så kontakt en hjælpelærer og luk IKKE denne terminal "
p_n "Tryk enter for at fortsætte "
read something

p_n "Alle programmer til dette kursus burde nu være korrekt installeret og opsat "
p_n "Når du trykker enter skulle terminalen gerne terminere, og du kan lukke den som almindeligt "
read something

unset CONDA_ALWAYS_YES 

exit

