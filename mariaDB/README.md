# MariaDB

```
sudo apt-get install software-properties-common

nano /etc/apt/sources.list.d/MariaDB.list


**Ubuntu 16.04**
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8

deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu xenial main



**Ubuntu 14.04**
sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db

deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu trusty main


sudo apt-get update
sudo apt-get install mariadb-server

ln -s /var/lib/mysql/mysql.sock /var/run/mysqld/mysqld.sock


vZerro#7SQL

vZerro#7Apps

mysql -u root -p
CREATE DATABASE nextcloud CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
GRANT ALL ON nextcloud.* to 'nextcloud'@'localhost' IDENTIFIED BY 'Zerro7SQL';
FLUSH PRIVILEGES;

transaction-isolation 	= READ-COMMITTED
default_storage_engine	= InnoDB
innodb_large_prefix	= on
innodb_file_format	= barracuda
binlog_format		= mixed

```

`nano /etc/mysql/my.cnf`
