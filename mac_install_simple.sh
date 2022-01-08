#!/bin/zsh


# Import functions to script
. ./shell_functions.sh

# This file installs and configures 3 parts
#     Miniconda and the base python installation, setting up the build conda environment
#     Pycharm and setting it up to the build environment python interpreter
#     Postgres, postgis and PgAdmin, and setting up the vttt database

# Introduction to what is going to happen
cd $root
p_n "Denne fil vil installere python til brug i kurset"
p_s
p_n "Dette program har tre forskellige farver"
p_n "Denne farve er hjaelpe tekst, som guider dig igennem installationen"
echo Denne farve er tekst skrevet af programmerne der installeres
p_i "Denne farve er naar der er noget vigtigt du skal vaere opmaerksom paa"
p_s
p_i "FOER DU GAAR IGANG"
p_i "Hav mindst \1 GB plads ledig. Der gives hjaelp til afinstallation i slutningen af kurset"
p_i "Deaktiver evt. antivirus du har installeret, mens installationen foregaar"
p_i "Efter du trykker enter skal du give muligvis give dit password du bruger til denne computer"
p_s
p_n "Naar du trykker enter, vil miniconda blive downloadet og installeret"
read something

# Download homebrew (only for mac)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Download miniconda sh.
brew install --cask miniconda
conda init "$(basename "${SHELL}")"

p_n "Miniconda er er et program som holder styr paa programmeringssproget python"
p_s
p_n "Alle programmer til dette kursus burde nu være korrekt installeret og opsat"
p_n "Måden du tester det på, er at aabne en terminal og skrive to kommandoer"
p_n "python --version"
p_n "Dette viser hvilken python version der er installeret i miniconda"
p_n "Naar du trykker skulle terminalen gerne lukke, ellers tryk paa X et par gange oeverst til højre"
read something