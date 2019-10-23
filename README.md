### General
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
