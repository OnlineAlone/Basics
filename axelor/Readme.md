In this guide we will see how to install the official pre-built war package on your favourite Linux system.

Prerequisites
OpenJDK 8

Tomcat 8.5

PostgreSQL 9.4 or later

Install OpenJDK 8
Install OpenJDK 8 on your favourite Linux distribution’s official package manager.

On Debian based system (i.e. Debian, Ubuntu etc.):
```
$ sudo apt-get install openjdk-8-jdk
```
On Fedora based system (i.e. Fedora, CentOS, RHEL etc.):

$ sudo dnf install java-1.8.0-openjdk-devel
On Arch Linux:
```
$ sudo pacman -S jdk8-openjdk
```
Install Tomcat 8.5
There are several ways to setup Tomcat on your system. Here we will see how to install the latest Tomcat 8.5 from the binary distribution package.

For security purposes, Tomcat should be run as an unprivileged user (i.e. not root).

First create a new tomcat group:
```
$ sudo groupadd tomcat
```
Now create a new tomcat user:
```
$ sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
```

Now, download the latest version of Tomcat 8.5 from the Tomcat Downloads page. Under the Binary Distributions section, copy the link to the .tar.gz package.

Follow these commands:
```
$ cd /tmp
$ curl -O https://www-eu.apache.org/dist/tomcat/tomcat-8/v8.5.42/bin/apache-tomcat-8.5.42.tar.gz
$ sudo mkdir -p /opt/tomcat
$ sudo tar -xzf apache-tomcat-*.tar.gz -C /opt/tomcat --strip-components=1
```
Now fix permissions:
```
$ cd /opt/tomcat
$ sudo chgrp -R tomcat /opt/tomcat
$ sudo chmod -R g+r conf
$ sudo chmod g+x conf
$ sudo chown -R tomcat webapps/ work/ temp/ logs/
```

Install PostgreSQL
See PostgreSQL download page for more detailed information about installation process.

You may also require to configure postgresql server to allow password authentication.

Example pg_hba.conf
```
# TYPE  DATABASE        USER            ADDRESS                 METHOD

# "local" is for Unix domain socket connections only
local   all             all                                     trust
# IPv4 local connections:
host    all             all             127.0.0.1/32            md5
# IPv6 local connections:
host    all             all             ::1/128                 md5
```
Once PostgreSQL is configured, create a new database user with password:
```
$ sudo su postgres
$ createuser axelor --no-createdb --no-superuser
$ psql -c "alter user axelor with encrypted password 'axelor'";
```
A new PostgreSQL user axelor is created with the given password. The password used here is just for demonstration. Use your own strong password.

Deploy the WAR
Now as you have all the prerequisites installed, download the pre-built war package of Axelor Open Suite.

Now extract the downloaded package and locate the WEB-INF/classes/application.properties file to change some of the application settings.

Most importantly, you will require to set database settings like this:
```
db.default.driver = org.postgresql.Driver
db.default.ddl = update
db.default.url = jdbc:postgresql://localhost:5432/axelor 
db.default.user = axelor 
db.default.password = axelor 
```
the database connection url
the database user name, as we created previously
the database user password, as we set previously
You may also like to change some other properties like file.upload.dir to change the location where you want to save uploaded files.

Now copy the extracted package directory to /opt/tomcat/webapps like this:
```
$ sudo cp -r axelor-erp-5.0.1 /opt/tomcat/webapps/
$ sudo chown -R tomcat:tomcat /opt/tomcat/webapps/axelor-erp-5.0.1
```
Now start the tomcat server:
```
$ sudo su -c "/opt/tomcat/bin/catalina.sh run" tomcat
```
If everything is fine, you can see application log on terminal and after a while, you may see something like this:

Ready to serve...
The application is now ready and can be accessible at: http://localhost:8080/axelor-erp-5.0.1
