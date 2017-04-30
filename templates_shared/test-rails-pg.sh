#!/bin/bash

# This script creates a basic Rails app that uses a PostgreSQL database.
# PURPOSE: Provide confirmation that Ruby on Rails and PostgreSQL are properly set up.

# REFERENCE: https://github.com/jackdb/pg-app-dev-vm

sudo service postgresql restart
APP_DB_NAME=database1
APP_DB_USER=user1
APP_DB_PASS=password1

# Just making sure Ruby, Rails, and Node are working as expected.
sh /home/winner/shared/info.sh

# This is the same test app as the one at http://elinux.org/RPi_Ruby_on_Rails 
# but with PostgreSQL instead of SQLite.

echo '*******************************************************'
echo 'rails new school_pg --database=postgresql --skip-spring'
cd /home/winner/shared && rails new school_pg --database=postgresql --skip-spring
wait

echo '*******************************'
echo 'Configuring config/database.yml'
cd /home/winner/shared/school_pg && mv config/database.yml config/database-orig.yml
cd /home/winner/shared/school_pg && echo 'default: &default' > config/database.yml
cd /home/winner/shared/school_pg && echo '  adapter: postgresql' >> config/database.yml
cd /home/winner/shared/school_pg && echo '  encoding: unicode' >> config/database.yml
cd /home/winner/shared/school_pg && echo '  pool: 5' >> config/database.yml
cd /home/winner/shared/school_pg && echo "  database: $APP_DB_NAME" >> config/database.yml
cd /home/winner/shared/school_pg && echo "  username: $APP_DB_USER" >> config/database.yml
cd /home/winner/shared/school_pg && echo "  password: $APP_DB_PASS" >> config/database.yml
cd /home/winner/shared/school_pg && echo '' >> config/database.yml
cd /home/winner/shared/school_pg && echo 'development:' >> config/database.yml
cd /home/winner/shared/school_pg && echo '  <<: *default' >> config/database.yml
cd /home/winner/shared/school_pg && echo '' >> config/database.yml
cd /home/winner/shared/school_pg && echo 'test:' >> config/database.yml
cd /home/winner/shared/school_pg && echo '  <<: *default' >> config/database.yml
cd /home/winner/shared/school_pg && echo '' >> config/database.yml
cd /home/winner/shared/school_pg && echo 'production:' >> config/database.yml
cd /home/winner/shared/school_pg && echo '  <<: *default' >> config/database.yml

echo '**********************************************'
echo 'rails g scaffold Pupil name:string form:string'
cd /home/winner/shared/school_pg && rails g scaffold Pupil name:string form:string
wait

echo '----------------------------------------'
echo "Creating role and database in PostgreSQL"
sudo -u postgres psql -c"CREATE ROLE $APP_DB_USER WITH CREATEDB LOGIN PASSWORD '$APP_DB_PASS';"
sudo -u postgres psql -c"CREATE DATABASE $APP_DB_NAME WITH OWNER=$APP_DB_USER;"
wait

echo '*************************'
echo 'rake db:create db:migrate'
cd /home/winner/shared/school_pg && rake db:migrate
wait

cat /home/winner/shared/ports.txt
echo '**********************'
echo 'OPEN YOUR WEB BROWSER.'
echo 'GO TO THE FOLLOWING URL:'
echo 'http://<IP Address>:<Port Number>/pupils'
echo "If Docker is installed directly in your host OS, use the IP address 'localhost'."
echo "If you are using Docker Machine, use Docker Machine's dedicated IP address (probably 192.168.99.100)."
echo 'Use the host port number that corresponds to port 3000 in Docker.'
echo '*************************************************************************************'
echo 'From your host machine, you can use access the database in this app by using pgAdmin.'
echo 'Host: <IP Address>'
echo 'Port: <PostgreSQL Port Number>'
echo 'Maintenance DB: postgres'
echo "Username: $APP_DB_USER"
echo "Password: $APP_DB_PASS"
echo "Database name: $APP_DB_NAME"
echo "If Docker is installed directly in your host OS, use the IP address 'localhost'."
echo "If you are using Docker Machine, use Docker Machine's dedicated IP address (probably 192.168.99.100)."
echo 'Use the host port number that corresponds to port 5432 in Docker.'
echo '*****************************************************************'
cd /home/winner/shared/school_pg && rails s -b 0.0.0.0 -p 3000
