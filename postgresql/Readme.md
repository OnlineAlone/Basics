
```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | sudo apt-key add -

sudo apt-get update
sudo apt-get install postgresql postgresql-common postgresql-contrib postgresql-9.5 libpq-dev
```



Ubuntu 18.04

```
nano /etc/apt/sources.list.d/PostgreSQL.list
```
add a line for the repository
```
## PostgreSQL
deb http://apt.postgresql.org/pub/repos/apt/ `lsb_release -cs`-pgdg main
##
```
Import the repository signing key, and update the package lists
```
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

For more information about the apt repository, including answers to frequent questions, please see the PostgreSQL Apt Repository page on the wiki.

Included in distribution
Ubuntu includes PostgreSQL by default. To install PostgreSQL on Ubuntu, use the apt-get (or other apt-driving) command:
```
sudo apt-get update && sudo apt-get install postgresql-11
```
