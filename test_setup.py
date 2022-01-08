#!/usr/bin/python
# -*- coding: WINDOWS-1252 -*-
from sys import platform

try:
    import numpy
    import matplotlib
    import xlrd
    import openpyxl
    import pandas
    import geopandas
    import pscopg2
    import requests

    connect_to_database = psycopg2.connect(
        dbname="vttt",
        host="localhost",
        user="postgres",
        password="changeme"
    )

    print("Alt korrekt installeret")
except Exception as e:
    print(e)
    print("\n\n")
    print("Ikke installeret korrekt. Kontakt underviser og vis den ovenstående fejl")

    if "No module named" in str(e):
        pass #print(f"""Installer de manglende pakker med pip install {e.name}""")

    if "Connection refused" in str(e):
        print("databasen er ikke startet")
        print("Windows:")

        if platform.startswith('win'):
            print("""Start din 'Anaconda Promt (miniconda3)'
                conda activate build
                pg_ctl -D %USERPROFILE%\pgdatabase -l logfile start""")
        else:
            print("""Start din terminal
                conda activate build
                pg_ctl -D ~\pgdatabase -l logfile start""")

