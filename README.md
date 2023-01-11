# VTT_scripts
Scripts for the _Vej- og trafikdatabehandling (VTT6)_ course, installing all the needed programs and packages.

## How to run
Depending on your operative system, the files should be run differently.

On both windows and mac, it is adviced to have antivirus software turned off, 
since most antivirus programs won't accept non-verified installation programs,
and terminate the script.

[Download](https://github.com/TRG-BUILD/VTT6_scripts/releases/latest) the latest source code and unpack the installation files

### Windows

Go to the directory where you downloaded the file, unpack it.

**!! Make sure** there no spaces " " in your parent directory names (eg. "OneDrive - Aalborg Universitet" is forbidden).

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

# Installation Errors

Test installation by runnign python script in:
PycharmProjects/VTT6/test_setup.py

| Problem                                     | OS      | Explanation                                               | Solution                                                                                                                                                             |
|---------------------------------------------|---------|-----------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| No colored text in Commonadpromt            | Windows | Installations i placed in a illegal directory             | Move to a directory without spaces in name                                                                                                                           |
| Brugeen findes ikke (postgres)              | Both    | Installation failed to create a user in postgres database | Open a terminal with Conda Environment Build activated and run: <br> $ createuser -P -s -e postgres                                                                  |
| Database dosent exist                       | Both    | Installation failed to create a database                  | Open a terminal with Conda Environment Build activated and run: <br> $ createdb vttt --owner=postgres --host=localhost --port=5432 --username=postgres --no-password |
| Cant activate build environment in terminal | Windows |            | Find Anaconda Promt <br> $ conda activate build                                                                                                                      |
| Cant activate build environment in terminal | Mac    |            | Open Terminal <br> $ conda activate build                                                                                                                            |
| No module named                             | Both.  | Python packages have not been properly installed | $ pip install packagename |
