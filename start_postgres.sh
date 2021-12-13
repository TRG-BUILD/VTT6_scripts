#!/bin/zsh


echo "Starting postgresql database..."
pg_ctl -D $HOME/pgdatabase -l logfile start

