#!/bin/zsh


echo "Stopping postgresql database..."
pg_ctl -D ~/pgdatabase -l logfile stop

