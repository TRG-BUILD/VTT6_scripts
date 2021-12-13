#!/bin/zsh


echo "Stopping postgresql database..."
pg_ctl -D $HOME/pgdatabase -l logfile stop

