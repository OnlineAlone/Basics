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
```

If you have multiple Java installations to change the default version, use the update-alternatives tool as shown below:
```
sudo update-alternatives --config java
```

There are 3 choices for the alternative java (providing /usr/bin/java).
```
  Selection    Path                                            Priority   Status
------------------------------------------------------------
* 0            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      auto mode
  1            /usr/lib/jvm/java-11-openjdk-amd64/bin/java      1111      manual mode
  2            /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java   1081      manual mode

Press <enter> to keep the current choice[*], or type selection number:
```
To change the default Java version just enter the version number (the number in the Selection column) and press Enter.

Set the JAVA_HOME Environment Variable
Some applications written in Java are using the JAVA_HOME environment variable to determine the Java installation location.

To set the JAVA_HOME environment variable, first, you need to find out the Java installation paths using the update-alternatives command
```
sudo update-alternatives --config java
```
In our case, the installation paths are as follows:


OpenJDK 11 is located at /usr/lib/jvm/java-11-openjdk-amd64/bin/java
OpenJDK 8 is located at /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
Copy the installation path of your preferred installation. Next, open the /etc/environment file:
```
sudo nano /etc/environment
```
Add the following line, at the end of the file:

```
JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
```
Make sure you replace the path with the path to your preferred Java version.

You can either log out and log in or run the following source command to apply the changes to your current session:
```
source /etc/environment
```
To verify that the JAVA_HOME environment variable is correctly set, run the following echo command:

```
echo $JAVA_HOME

/usr/lib/jvm/java-11-openjdk-amd64
```
end
