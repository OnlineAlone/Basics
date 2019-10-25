
```
$ sudo apt-get install axel
```
```
sudo add-apt-repository ppa:apt-fast/stable
sudo apt-get update
sudo apt-get -y install apt-fast
```

Add mirrors
```
sudo nano /etc/apt-fast.conf

MIRRORS=( ‘http://archive.ubuntu.com/Ubuntu, http://de.archive.ubuntu.com/ubuntu’)
+ /etc/apt/sources.list
```

```
sudo apt-fast update
sudo apt-fast upgrade
sudo apt-fast install package_name
sudo apt-fast remove package_name
```
