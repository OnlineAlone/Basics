# General

## Update system
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install software-properties-common
```

## webmin Panel
```
nano /etc/apt/sources.list.d/Webmin.list

## Webmin Panel
deb http://download.webmin.com/download/repository sarge contrib
##
```

```
wget http://www.webmin.com/jcameron-key.asc
sudo apt-key add jcameron-key.asc
sudo apt-get update
sudo apt-get install webmin libsocket6-perl libnet-inet6glue-perl
```

## git Utility

```
sudo apt-get -y install git
```
Configure git,
```
git config --global user.email "USER@DOMAIN.COM"
git config --global user.name "USER"
```


## swap Allocation
```
nano swap.sh
```
check out swap.sh file for details,

adjust file permissions and execute, 
```
chmod a+x swap.sh
./swap.sh
```
check out allocated swap size,
```
free -m
```

```
nano /etc/systemd/system/swap.service
```
check out swap.service file for details.

adjust permissions,
```
chmod 664 /etc/systemd/system/swap.service
```
allow systemd for start-up,
```
systemctl daemon-reload
systemctl enable swap.service
systemctl start swap.service
```
