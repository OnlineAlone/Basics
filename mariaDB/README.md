# MariaDB

```
sudo apt-get install software-properties-common

nano /etc/apt/sources.list.d/MariaDB.list


**Ubuntu 18.04**
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.4/ubuntu bionic main

**Ubuntu 16.04**
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.4/ubuntu xenial main

**Ubuntu 14.04**
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.4/ubuntu trusty main


sudo apt-get update
sudo apt-get -y install mariadb-server mariadb-client libmysqlclient-dev

ln -s /var/lib/mysql/mysql.sock /var/run/mysqld/mysqld.sock

sudo mysql_secure_installation

mysql -u root -p
CREATE DATABASE database CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL ON database.* to 'database'@'localhost' IDENTIFIED BY 'Zero';
FLUSH PRIVILEGES;
exit;
```

`nano /etc/mysql/my.cnf`

```
transaction-isolation 	= READ-COMMITTED
default_storage_engine	= InnoDB
innodb_large_prefix	= on
innodb_file_format	= barracuda
binlog_format		= mixed
```
