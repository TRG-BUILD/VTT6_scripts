# VTT_scripts
Scripts for the _Vej- og trafikdatabehandling (VTT6)_ course, installing all the needed programs and packages.

## How to run
Depending on your operative system, the files should be run differently.

On both windows and mac, it is adviced to have the anti-virus turned off, 
since most anti-virus programs won't accept non-verified installation programs,
and terminate the script.

[Download](https://github.com/TRG-BUILD/VTT6_scripts/releases/latest) the latest source code and unpack the installation files

### Windows

Go to the directory of the files you downloaded using your filehandler.
The file _win_install.bat_ should be right-clicked and set to "run as administrator".

#### UNINSTALL

Run _win_uninstall.bat_ as administrator

### Mac OS X (tested on Big Sur)

Open your Terminal using Spotlight (⌘ + space)

Goto you directory, where you downloaded the installation files.

If it is in your download folder then go to directory by entering:
```
cd ~/Downloads/unzip
VTT6_scripts-1.2.zip 
cd VTT6_scripts-1.2
```

Install by entering:
```
zsh mac_install.sh
```

The files should be self explanatory when run.

#### UNINSTALL

If you wan to uninstall on Mac OS X then run

```
zsh mac_uninstall.sh
```