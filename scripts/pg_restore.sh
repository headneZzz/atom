#!/bin/bash
sudo -u postgres dropdb atom
sudo -u postgres createdb -O atom atom
sudo -u postgres psql -d atom -f atom_backup.sql
