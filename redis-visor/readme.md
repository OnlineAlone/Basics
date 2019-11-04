# Redis Server

```
sudo apt-get install redis-server supervisor
sudo usermod -a -G redis www-data

sudo systemctl enable redis-server
sudo systemctl enable supervisor

```

```


echo 512 > /proc/sys/net/core/somaxconn
echo never > /sys/kernel/mm/transparent_hugepage/enabled
 
nano /etc/rc.local

echo never > /sys/kernel/mm/transparent_hugepage/enabled

nano /etc/sysctl.conf
vm.overcommit_memory = 1
net.core.somaxconn = 512
fs.file-max = 1048576

1691:M 17 Aug 00:30:24.145 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1691:M 17 Aug 00:30:24.145 # Server started, Redis version 3.0.6
1691:M 17 Aug 00:30:24.145 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1691:M 17 Aug 00:30:24.145 * The server is now ready to accept connections at /var/run/redis/redis.sock






nano /etc/redis/redis-gogs.conf

dbfilename redis_gogs.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-gogs.pid
bind 127.0.0.1
port 0


nano /etc/supervisor/conf.d/redis-gogs.conf

[program:redis-gogs]
command=/usr/bin/redis-server /etc/redis/redis-gogs.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-gogs.log
stderr_logfile=/var/log/redis/redis-gogs.error.log
user=redis





DEFAULT
nano /etc/redis/redis-taiga.conf
dbfilename redis_taiga.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-taiga.pid
bind 127.0.0.1
port 6379

=======================
nano /etc/redis/redis-gogs.conf
dbfilename redis_gogs.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-gogs.pid
bind 127.0.0.1
port 6399

nano /etc/supervisor/conf.d/redis-gogs.conf
[program:redis-gogs]
command=/usr/bin/redis-server /etc/redis/redis-gogs.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-gogs.log
stderr_logfile=/var/log/redis/redis-gogs.error.log
user=redis
=======================

=======================
nano /etc/redis/redis-firefly.conf
dbfilename redis_firefly.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-firefly.pid
bind 127.0.0.1
port 6389

nano /etc/supervisor/conf.d/redis-firefly.conf
[program:redis-firefly]
command=/usr/bin/redis-server /etc/redis/redis-firefly.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-firefly.log
stderr_logfile=/var/log/redis/redis-firefly.error.log
user=redis
=======================


=======================
nano /etc/redis/redis-nextcloud.conf
dbfilename redis_nextcloud.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-nextcloud.pid
bind 127.0.0.1
port 0
unixsocket /var/run/redis/redis.sock
unixsocketperm 770

nano /etc/supervisor/conf.d/redis-nextcloud.conf
[program:redis-nextcloud]
command=/usr/bin/redis-server /etc/redis/redis-nextcloud.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-nextcloud.log
stderr_logfile=/var/log/redis/redis-nextcloud.error.log
user=redis
=======================






=======================
nano /etc/redis/redis-ntopng.conf
dbfilename redis_ntopng.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-ntopng.pid
bind 127.0.0.1
port 6369

nano /etc/supervisor/conf.d/redis-ntopng.conf
[program:redis-ntopng]
command=/usr/bin/redis-server /etc/redis/redis-ntopng.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-ntopng.log
stderr_logfile=/var/log/redis/redis-ntopng.error.log
user=redis
=======================


=======================
nano /etc/redis/redis-grav.conf
dbfilename redis_grav.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-grav.pid
bind 127.0.0.1
port 6359

nano /etc/supervisor/conf.d/redis-grav.conf
[program:redis-grav]
command=/usr/bin/redis-server /etc/redis/redis-grav.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-grav.log
stderr_logfile=/var/log/redis/redis-grav.error.log
user=redis
=======================

=======================
nano /etc/redis/redis-bookstack.conf
dbfilename redis_bookstack.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-bookstack.pid
bind 127.0.0.1
port 6339

nano /etc/supervisor/conf.d/redis-bookstack.conf
[program:redis-bookstack]
command=/usr/bin/redis-server /etc/redis/redis-bookstack.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-bookstack.log
stderr_logfile=/var/log/redis/redis-bookstack.error.log
user=redis
=======================


=======================
nano /etc/redis/redis-booktype.conf
dbfilename redis_booktype.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-booktype.pid
bind 127.0.0.1
port 6309

nano /etc/supervisor/conf.d/redis-booktype.conf
[program:redis-booktype]
command=/usr/bin/redis-server /etc/redis/redis-booktype.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-booktype.log
stderr_logfile=/var/log/redis/redis-booktype.error.log
user=redis
=======================


=======================
nano /etc/redis/redis-arastta.conf
dbfilename redis_arastta.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-arastta.pid
bind 127.0.0.1
port 6009

nano /etc/supervisor/conf.d/redis-arastta.conf
[program:redis-arastta]
command=/usr/bin/redis-server /etc/redis/redis-arastta.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-arastta.log
stderr_logfile=/var/log/redis/redis-arastta.error.log
user=redis
=======================

=======================
nano /etc/redis/redis-prestashop.conf
dbfilename redis_prestashop.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-prestashop.pid
bind 127.0.0.1
port 6009

nano /etc/supervisor/conf.d/redis-prestashop.conf
[program:redis-prestashop]
command=/usr/bin/redis-server /etc/redis/redis-prestashop.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-prestashop.log
stderr_logfile=/var/log/redis/redis-prestashop.error.log
user=redis
=======================


=======================
nano /etc/redis/redis-orocrm.conf
dbfilename redis_orocrm.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-orocrm.pid
bind 127.0.0.1
port 6009

nano /etc/supervisor/conf.d/redis-orocrm.conf
[program:redis-orocrm]
command=/usr/bin/redis-server /etc/redis/redis-orocrm.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-orocrm.log
stderr_logfile=/var/log/redis/redis-orocrm.error.log
user=redis
=======================

=======================
nano /etc/redis/redis-orocmc.conf
dbfilename redis_orocmc.rdb
dir /var/lib/redis
pidfile /var/run/redis/redis-orocmc.pid
bind 127.0.0.1
port 6009

nano /etc/supervisor/conf.d/redis-orocmc.conf
[program:redis-orocmc]
command=/usr/bin/redis-server /etc/redis/redis-orocmc.conf
priority=2
autostart=true
autorestart=true
stdout_logfile=/var/log/redis/redis-orocmc.log
stderr_logfile=/var/log/redis/redis-orocmc.error.log
user=redis
=======================
