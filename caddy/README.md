# Caddy HTTP Server

```
curl https://getcaddy.com | bash
```

```
sudo chown root:root /usr/local/bin/caddy
sudo chmod 755 /usr/local/bin/caddy
sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy
```

```
sudo mkdir /etc/caddy
sudo chown -R root:www-data /etc/caddy
```

```
sudo mkdir /etc/caddy/tls
sudo chown -R www-data:root /etc/caddy/tls
sudo chmod 0770 /etc/caddy/tls
```

```
sudo touch /etc/caddy/Caddyfile
sudo chown www-data:www-data /etc/caddy/Caddyfile
sudo chmod 444 /etc/caddy/Caddyfile
```

```
nano /etc/init/caddy.conf
description "HTTP Server"

start on runlevel [2345]
stop on runlevel [016]

console log

setuid www-data
setgid www-data

respawn
respawn limit 10 5

reload signal SIGUSR1

# Let's Encrypt certificates will be written to this directory.
env CADDYPATH=/etc/caddy/tls

limit nofile 1048576 1048576

script
		cd /etc/caddy
		rootdir="$(mktemp -d -t "caddy-run.XXXXXX")"
		exec /usr/local/bin/caddy -agree -log=stdout -conf=/etc/caddy/Caddyfile -root=$rootdir
end script
```

```
sudo cp caddy.service /etc/systemd/system/
sudo chown root:root /etc/systemd/system/caddy.service
sudo chmod 744 /etc/systemd/system/caddy.service
sudo systemctl daemon-reload
sudo systemctl start caddy.service
sudo systemctl enable caddy.service

sudo systemctl restart caddy.service
sudo systemctl stop caddy.service
journalctl -f -u caddy.service
journalctl --boot -u caddy.service
```










SysVinit conf for Caddy

Usage

Download the appropriate Caddy binary in /usr/local/bin/caddy or use curl https://getcaddy.com | bash.
Save the SysVinit config file in /etc/init.d/caddy.
Ensure that the folder /etc/caddy exists and that the folder /etc/ssl/caddy is owned by www-data.
Create a Caddyfile in /etc/caddy/Caddyfile
Now you can use service caddy start|stop|restart|reload|status as root.



