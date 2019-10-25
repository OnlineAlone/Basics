

```
dpkg -l iptables-persistent
sudo apt-get install iptables-persistent
ls /etc/iptables

iptables -L

dpkg-reconfigure iptables-persistent
iptables -L
ip6tables -L

sudo iptables -I INPUT 7 -p tcp --dport 8080 -m state --state NEW -j ACCEPT
sudo iptables -D INPUT 7




sudo ufw default deny incoming
$ sudo ufw default allow outgoing
sudo ufw allow ssh

sudo ufw allow 2222

sudo ufw allow http
sudo ufw allow 80

sudo ufw allow https
sudo ufw allow 443

sudo ufw deny from 203.0.123.5

sudo ufw enable
sudo ufw status verbose








```
