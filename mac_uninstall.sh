#!/bin/zsh
. ./shell_functions.sh

clear
# Introduction to what is going to happen
cd $root
p_n "Denne fil vil afinstallere miniconda og dermed også python"
p_s
p_n "Dit arbejde under $root/PycharmProjects vil ikke slettes"

p_s
p_i "Efter du trykker enter skal du give dit password du bruger til denne computer"
read something

which -s conda
if [[ $? == 0 ]] ; then
    conda deactivate
    conda deactivate
else
    echo ""
fi

#Rem Uninstall miniconda mac.
brew uninstall --force --cask miniconda
brew uninstall --force --cask pycharm-ce
sed -ie '/>>> conda/,/initialize <<</g' "$shellrc"
sudo rm -r ~/Library/Application Support/JetBrains/PyCharm2021.2
sudo rm -r ~/Library/Caches/JetBrains/PyCharm2021.2
sudo rm -r ~/.matplotlib
#sudo rm -r $root/PycharmProjects
brew uninstall --force --cask pgadmin4
sudo rm -r $root/pgdatabase

p_s
p_n "Alt skulle vaere korrekt afinstalleret"
p_n "Tryk enter for at lukke terminalen"

. "$shellrc"

read something
