You need to add the following PPA to your Ubuntu system. This PPA contains a package oracle-java11-installer having the Java installation script.
```
sudo add-apt-repository ppa:linuxuprising/java
```
Then install Java 11 using the script provided in this packages. This script downloads the Java archive from the official site and configures on your system
```
sudo apt update
sudo apt install oracle-java11-installer
```
Also, install the following package to configure Java 11 as default Java version on your Ubuntu 18 system.
```
sudo apt install oracle-java11-set-default
```
Step 3 – Verify Java Version
Check the installed Java version on your system using the following command.
```
java -version
```
java version "11.0.2" 2019-01-15 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.2+9-LTS, mixed mode)
