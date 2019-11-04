
# PostgreSQL

```
PostgreSQL

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

nano /etc/apt/sources.list.d/PostgreSQL.list

deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main

deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main

sudo apt-get update

sudo apt-get install libdbd-pg-perl postgresql postgresql-client postgresql-contrib

sudo apt-get install libdbd-pg-perl postgresql-9.4 postgresql-client-9.4 postgresql-contrib-9.4

sudo apt-get install libdbd-pg-perl postgresql-9.6 postgresql-client-9.6 postgresql-contrib-9.6 postgresql-server-dev-9.6

sudo -i -u postgres
psql
CREATE DATABASE NameDB;
CREATE USER UserDB WITH password 'Zerro7SQL';
GRANT ALL privileges ON DATABASE NameDB TO UserDB;
\q
exit
nano /etc/postgresql/9.4/main/postgresql.conf

log_timezone = 'GMT'
port = 5432
max_connections = 512
```


```
nano /etc/apt/sources.list.d/PostgreSQL.list
deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update


sudo apt-get install libdbd-pg-perl postgresql postgresql-client postgresql-contrib
```
