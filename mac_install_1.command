#!/bin/zsh

# Config
root=/Users/$USER
col_norm='\033[0;32m'
col_impo='\033[0;31m'
col_end='\033[0m'

# This file installs and configures 3 parts
#     Miniconda and the base python installation, setting up the build conda environment
#     Pycharm and setting it up to the build environment python interpreter
#     Postgres, postgis and PgAdmin, and setting up the vttt database

# Introduction to what is going to happen
cd $root
echo $col_norm Denne fil vil installere alle de fornoedne programmer til kurset $col_end
echo $col_norm Samt give en kort beskrivelse af hvad der bliver installeret, og hvorfor $col_end
echo $col_norm Den forventede tid til installation samt opsaetning er ca. en time $col_end
echo .
echo $col_norm Dette program har tre forskellige farver $col_end
echo $col_norm Denne farve er hjaelpe tekst, som guider dig igennem installationen $col_end
echo Denne farve er tekst skrevet af programmerne der installeres
echo $col_impo Denne farve er naar der er noget vigtigt du skal vaere opmaerksom paa $col_end
echo .
echo $col_impo FOER DU GAAR IGANG $col_end
echo $col_impo Hav mindst \1\0GB plads ledig. Der gives hjaelp til afinstallation i slutningen af kurset $col_end
echo $col_impo Efter du trykker enter skal du give dit password du bruger til denne computer $col_end
echo .
echo $col_norm Installationen af hvert program vil give lidt tekst til at forstaa hvad der er installeret, samt hvorfor det er relevant $col_end
echo $col_norm Naar du trykker enter, vil miniconda blive downloadet og installeret $col_end
read something

# Download homebrew (only for mac)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Download miniconda sh.
brew install --cask miniconda
conda init "$(basename "${SHELL}")"

echo $col_norm Miniconda er er et program som holder styr paa programmeringssproget python $col_end
echo $col_norm Grundet mac er som det er, saa kraeves det at terminalen skal genstarte $col_end
echo $col_impo Tryk paa enter, og luk derefter terminalen. Start saa den anden installations fil $col_end
read something