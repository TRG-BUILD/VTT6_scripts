#!/bin/zsh

# Config
root=/Users/$USER
col_norm='\033[0;32m'
col_impo='\033[0;31m'
col_end='\033[0m'

# Introduction to what is going to happen
cd $root
echo $col_norm Denne fil vil afinstallere miniconda og dermed ogsaa python $col_end
echo $col_impo ADVARSEL: Den vil desuden ogsaa slette alle din Pycharm Projekt filer $col_end
echo $col_impo Hvis du flytter filerne du oensker at gemme, ud paa skrivebordet vil de ikke blive slettet $col_end
echo $col_impo Oensker du at flytte filer, saa luk terminalen UDEN at trykke enter, inden du flytter filerne $col_end
echo .
echo $col_impo Efter du trykker enter skal du give dit password du bruger til denne computer $col_end
read something

#Rem Uninstall miniconda mac.
brew uninstall --force --cask miniconda
brew uninstall --force --cask pycharm-ce
sudo rm -r ~/Library/Application Support/JetBrains/PyCharm2021.2
sudo rm -r ~/Library/Caches/JetBrains/PyCharm2021.2
sudo rm -r ~/.matplotlib
sudo rm -r $root/PycharmProjects
brew uninstall --force --cask pgadmin4
sudo rm -r $root/pgdatabase

echo $col_norm Alt skulle vaere korrekt afinstalleret $col_end
echo $col_norm Tryk enter for at lukke terminalen $col_end
read something