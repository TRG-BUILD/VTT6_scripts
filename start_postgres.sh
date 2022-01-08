#!/bin/zsh


echo "Starting postgresql database..."
pg_ctl -D ~/pgdatabase -l logfile start
