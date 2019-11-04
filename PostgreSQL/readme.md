

```
nano /etc/apt/sources.list.d/PostgreSQL.list
deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
sudo apt-get update


sudo apt-get install libdbd-pg-perl postgresql postgresql-client postgresql-contrib
```
