# Apache Web Server

```
sudo apt-get install apache2 apache2-bin apache2-data apache2-utils
sudo apt-get install libapache2-mod-jk

sudo a2enmod rewrite
sudo a2enmod headers
sudo a2enmod env
sudo a2enmod dir
sudo a2enmod mime
sudo a2enmod proxy
sudo a2enmod proxy_wstunnel
sudo a2enmod proxy_http
sudo a2enmod ssl
sudo service apache2 restart
```

```
sudo a2enmod rewrite headers env dir mime proxy proxy_wstunnel proxy_http ssl
sudo service apache2 restart
```
