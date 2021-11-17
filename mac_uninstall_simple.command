#!/bin/zsh

# Config
root=/Users/$USER
col_norm='\033[0;32m'
col_impo='\033[0;31m'
col_end='\033[0m'

# Introduction to what is going to happen
cd $root
echo $col_norm Denne fil vil afinstallere alt der er brugt i kurset $col_end
echo .
echo $col_impo Efter du trykker enter skal du muligvis give dit password du bruger til denne computer $col_end
read something

#Rem Uninstall miniconda mac.
brew uninstall --force --cask miniconda

echo $col_norm Alt skulle vaere korrekt afinstalleret $col_end
echo $col_norm Tryk enter for at lukke terminalen $col_end
read something