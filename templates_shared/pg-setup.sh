#!/bin/bash

PG_VERSION='9.4'
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
PG_CONF_PREF="/etc/postgresql/$PG_VERSION/main/postgresql_preferred.conf"
PG_HBA="/etc/postgresql/$PG_VERSION/main/pg_hba.conf"
PG_HBA_PREF="/etc/postgresql/$PG_VERSION/main/pg_hba_preferred.conf"

sudo cp $PG_CONF_PREF $PG_CONF
sudo cp $PG_HBA_PREF $PG_HBA
sudo service postgresql restart