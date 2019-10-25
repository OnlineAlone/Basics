

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

```
