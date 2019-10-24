# General

## Update system
```
sudo apt-get update && sudo apt-get upgrade -y
sudo apt-get install software-properties-common
```

```
sudo apt-get install dnsmasq fontconfig git htop libcrypto++-dev libfreetype6-dev liblcms2-dev libwebp-dev libxext6 libxrender1 libxslt1-dev libxslt1.1 libffi-dev ntp postfix python3-dev python-tk screen vim xfonts-75dpi xfonts-base zlib1g-dev apt-transport-https libsasl2-dev libldap2-dev libcups2-dev pv
```

```
sudo apt-get install -y python-dev python-setuptools build-essential python-mysqldb git \
			ntp vim screen htop mariadb-server mariadb-common libmariadbclient-dev \
			libxslt1.1 libxslt1-dev redis-server libssl-dev libcrypto++-dev postfix nginx \
			supervisor python-pip fontconfig libxrender1 libxext6 xfonts-75dpi xfonts-base nodejs
```            

## Adjust DNS

```
/etc/resolvconf/resolv.conf.d/base
```

```
nameserver 208.67.222.222
nameserver 208.67.220.220
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

swap check
```
fatal: [localhost]: FAILED! => {
    "changed": true, 
    "cmd": "echo 1 | tee /proc/sys/vm/swappiness", 
    "delta": "0:00:00.004467", 
    "end": "2019-10-24 13:07:16.177009", 
    "invocation": {
        "module_args": {
            "_raw_params": "echo 1 | tee /proc/sys/vm/swappiness", 
            "_uses_shell": true, 
            "argv": null, 
            "chdir": null, 
            "creates": null, 
            "executable": null, 
            "removes": null, 
            "stdin": null, 
            "stdin_add_newline": true, 
            "strip_empty_ends": true, 
            "warn": true
        }
    }, 
    "msg": "non-zero return code", 
    "rc": 1, 
    "start": "2019-10-24 13:07:16.172542", 
    "stderr": "tee: /proc/sys/vm/swappiness: Permission denied", 
    "stderr_lines": [
        "tee: /proc/sys/vm/swappiness: Permission denied"
    ], 
    "stdout": "1", 
    "stdout_lines": [
        "1"
    ]
}
```
