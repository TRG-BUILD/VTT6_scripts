#!/bin/zsh

# Config
root=/Users/$USER
col_norm='\033[0;32m'
col_impo='\033[0;31m'
col_end='\033[0m'

echo $col_norm Dette er den anden installationsfil $col_end
echo $col_impo Hvis du ikke er gaaet igennem den foerste installationsfil, saa luk terminalen og start med den $col_end
echo .
echo $col_norm Naar du trykker enter vil der blive oprettet et virtuelt miljoe for python $col_end
echo $col_impo Tryk y for at bekraefte oprettelsen af det virtuelle miljoe $col_end
read something

# Create Conda environment
source /usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh
conda create -n build
conda activate build
conda config --add channels conda-forge

echo $col_norm Virtuelt miljoe build er oprettet $col_end
echo $col_norm Et virtuelt miljoe er basalt set en python installation, som holdes adskilt fra andre python installationer $col_end
echo $col_norm Det vil sige, at de pakker vi bruger her i kurset til at udvide det basale python,  $col_end
echo $col_norm ikke vil blive blandet sammen med andre installationer af python $col_end
echo $col_norm I loebet af kurset har i kun behov for det ene virtuelle miljoe kaldet build  $col_end
echo $col_norm Hernaest vil der blive installeret pakker i build miljoet $col_end
echo $col_impo Tryk 'y' for at bekraefte installationen af hver pakke. Der er 8 i alt $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
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

echo $col_norm Alle python pakkerne er installeret korrekt $col_end
echo $col_norm En pakke eller library paa engelsk er kode som andre har skrevet, $col_end
echo $col_norm og gjort tilgaengeligt for andre at bruge. Disse er naesten altid gratis $col_end
echo $col_norm I dette kursus er der installeret: $col_end
echo $col_norm matplotlib: $col_end
echo $col_norm Kan bruges til at lave scatterplot, histogrammer og generelt grafer af data $col_end
echo $col_norm pandas: $col_end
echo $col_norm Kan indlaese og manipulere data til og fra mange forskellige filformater $col_end
echo $col_norm geopandas: $col_end
echo $col_norm Udvider pandas til at kunne haandtere \3D koordinator med GIS $col_end
echo $col_norm xlrd: $col_end
echo $col_norm Udvider pandas til at kunne haandtere excel $col_end
echo $col_norm openpyxl: $col_end
echo $col_norm En sikkerhedspakke for at vaere helt sikker paa at integrationen med excel virker $col_end
echo $col_norm psycopg2: $col_end
echo $col_norm Goer det muligt at skrive SQL kommandoer til den database i faar installeret $col_end
echo $col_norm SQL er et sprog i vil laere mere om i de kommende kursusgange $col_end
echo $col_norm numpy: $col_end
echo $col_norm En pakke der goer de andre pakker mange gange hurtigere $col_end
echo $col_norm Denne installation er ligeledes en sikkerhedspakke for at sikre den er med $col_end
echo $col_norm requests: $col_end
echo $col_norm En pakke der goer det muligt at sende og modtage beskeder fra internettet $col_end
echo $col_norm Den kan bruges til at hente data fra datastyrelsen, vejman samt mere til brug i et program $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm Python er nu installeret med de korrekte pakker i build miljoet $col_end
echo $col_norm For at kunne bruge python, er det smart at bruge en IDE, $col_end
echo $col_norm hvor man kan skrive programmerne i, og koere det fra $col_end
echo $col_norm Naar du trykker enter, vil PyCharm IDEen blive installeret $col_end
echo $col_impo Du vil blive bedt om at indtaste dit kodeord du bruger paa denne computer $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something

# Download and setup Pycharm
sudo mkdir ~/.matplotlib
sudo chmod -R 755 ~/.matplotlib
sudo chown -R $USER ~/.matplotlib
sudo echo "backend: MacOSX" >> ~/.matplotlib/matplotlibrc
echo $col_norm Pycharm er nu igang med at blive installeret$col_end
brew install --cask pycharm-ce

echo $col_norm Pycharm er som skrevet en IDE, hvor man kan skrive og koere python $col_end
echo $col_norm Et Integrated Development Environment kaldet en IDE er dybest set en tekst editor med ekstra funktioner $col_end
echo $col_norm Disse ekstra funktioner vil blive forklaret i en seperat video $col_end
echo $col_norm Pycharm holder styr paa filerne indenfor et givet projekt $col_end
echo $col_norm I dette kursus er projektet VTT6 oprettet med opgaver, samt mulighed for at i selv kan lave python programmer $col_end
echo $col_norm Naar du trykker enter vil VTT6 projektet blive hentet ned $col_end
echo $col_impo For at hente VTT6 projektet, bruges programmet git. HUSK at skrive y naar den beder om installationen $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something

# Get PycharmProjects containing exercises
sudo mkdir ~/PycharmProjects
sudo chmod -R 755 ~/PycharmProjects
sudo chown -R $USER ~/PycharmProjects
cd $root/PycharmProjects
conda install -c conda-forge git
git clone https://github.com/TRG-BUILD/VTT6.git
cd $root

echo $col_norm VTT6 er nu hentet ned paa computeren $col_end
echo $col_norm Dette projekt vil vaere det primaere sted for at lave opgaver og skrive filer $col_end
echo $col_norm Sammenkoblingen af alle delene vil ske i slutningen af denne fil gennemgang $col_end
echo $col_norm Som det sidste foer sammenkoblingen, vil der blive downloadet postgresql og pgadmin til at haandtere databaser $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something

# Install Postgres + PostGis + PgAdmin
conda install -c conda-forge postgresql
conda install -c conda-forge postgis
brew install --cask pgadmin4

echo $col_norm Der opsaettes nu automatisk den database, som skal bruges i kurset $col_end

# Create a database cluster with superuser = %USERNAME% (no password)
sudo mkdir ~/pgdatabase
sudo chmod -R 755 ~/pgdatabase
sudo chown -R $USER ~/pgdatabase
initdb --encoding="UTF8" --pgdata=$root/pgdatabase --auth=trust
pg_ctl -D $root/pgdatabase -l logfile start
echo $col_impo Vaelg changeme som password til den nye rolle som er brugeren postgres $col_end
echo $col_impo Indtastningen er USYNLIG, og skal goeres to gange i streg $col_end
createuser -P -s -e postgres
createdb vttt --owner=postgres --host=localhost --port=5432 --username=postgres --no-password

echo $col_norm Postgresql er et program som haandtere databaser, og som du kan styre ved brug af programmeringssproget SQL $col_end
echo $col_norm Paa din computer er der nu oprettet en database der hedder vttt $col_end
echo $col_norm Denne database er valgt i kurset til at kunne tilgaes med brugernavnet postgres og passwordet changeme $col_end
echo $col_norm Den koere paa din computer, hvilket hedder hostes paa localhost i tekniske termer $col_end
echo $col_norm Den lytter desuden paa port \5\4\3\2, hvilket er det sted paa din computer andre programmer kan kontakte databasen $col_end
echo $col_norm Ligeledes er PgAdmin installeret, som kan bruges til at se og bruge databasen $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_impo Der mangler lige den sidste opsaetning der skal laves manuelt $col_end
echo $col_norm Naar du trykker enter, vil instruktionerne for de sidste opsaetninger blive skrevet $col_end
echo $col_norm Instruktionerne er delt op i \1 step ad gangen $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something

echo $col_norm Databasen som vi har lavet med postgresql skal kunne tilgaes fra PgAdmin $col_end
echo $col_norm Til det skal du foelge de her \5 steps: $col_end
echo $col_norm \1. Aaben PgAdmin brug evt finder til at soege efter PgAdmin $col_end
echo $col_norm    Sig at du stoler paa programmet, tryk Open $col_end
echo $col_impo    Naar den aabner, saet master password til changeme $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \2. Ctrl klik paa Servers som findes i oevre venstre hjoerne,vaelg Create \-\> Server $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \3. Angiv Name vttt, og tryk paa connection $col_end
echo $col_norm    Angiv Host name/address til at vaere localhost, og tryk Save $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \4. For at udfoere SQL kommandoer til databasen, skal du foerst vaelge databasen  $col_end
echo $col_norm    Helt ude til venstre, tryk paa vttt \-\> Databases \-\> vttt  $col_end
echo $col_norm    Derefter se i den oevre blaa bjaelke og tryk paa Tools \-\> Query Tool $col_end
echo $col_norm    Hvis PgAdmin er aaben i en lille skaerm, er bjaelken gemt i en menu oevre venstre hjoerne $col_end
echo $col_norm    Copy/paste denne kommando, for at aktivere postgis i databasen: $col_end create extension postgis\;
echo $col_norm    Tryk derefter paa F5 eller Play knappen oeverst til hoejre, for at sende SQL kommandoen til databasen $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm    PgAdmin og databasen vttt burde nu vaere korrekt opsat sammen $col_end
echo $col_norm    Desuden er databasen nu opsat til at kunne haandtere GIS data $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm build miljoet, der har alle pakkerne installeret, skal kobles sammen med Pycharm $col_end
echo $col_norm Til det skal du foelge de her \7 steps $col_end
echo $col_norm \1. Aaben PyCharm Community Edition ved brug af Finder eksempelvis $col_end
echo $col_norm    Sig at du stoler paa programmet, tryk Open $col_end
echo $col_norm    Accepter desuden betingelserne $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \2. I popup vinduet, tryk paa Open og find projektet PyCharmProjects $col_end
echo $col_norm    Dobbelt klik og aaben projektet. Der skulle staa VTT6 i oevre venstre hjoerne et sted $col_end
echo $col_norm    I vil muligvis faa en besked i nedre hoejre hjoerne om at der mangler en github mappe $col_end
echo $col_norm    Den mappe er fjernet, da i ikke har behov for det, saa i kan se bort fra fejlen $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \3. Naar projektet er aabent, se da nederst i hoejre hjoerne under Event Log $col_end
echo $col_norm    Tryk paa No Interpreter og dernaest tryk paa Add Interpreter $col_end
echo $col_norm    Der kan godt staa Python X.X \(hvor X er tal\) istedet. Tryk stadig og vaelg Add Interpreter $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \4. I popup vinduet skal du trykke paa conda environment i venstre side $col_end
echo $col_norm    Dernaest trykker du paa existing environments og find saa en Interpreter: som hedder $col_end
echo $col_norm    /usr/local/Caskroom/miniconda/base/envs/build/bin/python  $col_end
echo $col_impo    Det vigtige er at der staar build i navnet $col_end
echo $col_impo    HUSK at tryk paa make available to all projects $col_end
echo $col_norm    Tryk saa OK, og der burde nu staa Python \3.\9 \(build\) i nedre hoejre hjoerne $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \5. Python interpreteren bliver nu sat op i PyCharm. Det kan tage noget tid.
echo $col_norm    Naar den hvide streg til venstre for Python \3.\9 \(build\) er koert helt igennem,  $col_end
echo $col_norm    kan du fortsaette med naeste instruktion $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \6. I oevre venstre hjoerne, ctrl klik paa \0test_setup.py $col_end
echo $col_norm    Dernaest, tryk paa Run for at koere filen $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something
echo $col_norm \7. Hvis programmet siger Alt korrekt installeret i terminalen i bunden er alt ok $col_end
echo $col_impo    Hvis programmet ikke siger Alt korrekt installeret, saa kontakt en hjaelpelaerer og luk IKKE denne terminal $col_end
echo $col_norm Tryk enter for at fortsaette $col_end
read something

echo $col_norm Alle programmer til dette kursus burde nu vaere korrekt installeret og opsat $col_end
echo $col_norm Naar du trykker enter skulle terminalen gerne terminere, og du kan lukke den som almindeligt $col_end
read something
exit