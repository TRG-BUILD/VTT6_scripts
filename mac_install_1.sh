#!/bin/zsh

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

p_s
p_n "Miniconda er er et pakkehåndterings program der kan holde styre på udviklingsmiljøet python du skal arbejde i."
p_s
p_n "Terminalen skal genstartes nu. Derefter skal du afvikle mac_install_2.sh"
p_s
p_i "Tryk på enter, og luk derefter terminalen. Start så den anden installations fil"
read something
