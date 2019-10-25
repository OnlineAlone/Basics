#!/bin/bash

# Usage :
# Install a fresh Debian Jessie, then execute following shell command as root user
# wget --no-check-certificate -O - https://gist.githubusercontent.com/lspg/018425712d6d437def68922c2717f8af/raw | bash

############
# Settings #
############

export LOCALE="fr_FR.UTF-8"
export TIMEZONE="Europe/Paris"
export DB_HOST="localhost"
export DB_NAME="axelor"
export DB_PASSWORD="axelor"
export DB_USER="axelor"
export JAVA_VERSION=8
export JAVA_METHOD="oracle"
export TOMCAT_VERSION=7
export MEM_XMS=$((1024))
export MEM_XMX=$((1024*2))
export PORT_HTTP="80"
export PORT_HTTPS="8443"
export MODE="prod"
export LOGOFILE="axelor.png"
export HOMEURL="http://www.axelor.com"
export UPLOADMAXSIZE="50"
export IMPORTDATA="false"
export AXELORINSTALL="manual"
export ADKVERSION="4.1.8"
export APPVERSION="4.1.1"
export APPSRC="/opt/abs-webapp"

#############
# Functions #
#############

# Colors
c1="\e[39m" # Normal
c2="\e[91m" # Red
c3="\e[92m" # Light Green
c4="\e[36m" # Cyan
c5="\e[31m" # Light Red
c6="\e[93m" # Yellow
c7="\e[32m" # Green
c8="\e[97m" # White

function tst {
	echo -e "${c7}   => $*${c4}"
	if ! $*; then
		echo -e "${c5}Exiting script due to error from: $*${c1}"
		exit 1
	fi
	echo -en "${c1}"
}

function out {
	if [ ! $CNT ]; then CNT=0; fi
	CNT=$((CNT+1))
	printf -v NUM "%02d" $CNT
	echo -e "${c3}${NUM} => $*${c1}"
}

function conf {
	echo "$*" | debconf-set-selections
}

# FIND ABSOLUTE SCRIPT PATH
SOURCE="${BASH_SOURCE[0]}"

while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	SOURCE="$(readlink "$SOURCE")"
	[[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
ROOT="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

echo -e "${c3}*****************************************"	
echo -e      "*** Axelor Business Suite 4.1 install ***"
echo -e      "*****************************************${c1}"

#############
# Bootstrap #
#############"
out "Repositories"
cat <<EOF > /etc/apt/sources.list
deb http://httpredir.debian.org/debian/ jessie main contrib
deb http://httpredir.debian.org/debian/ jessie-updates main contrib
deb http://security.debian.org jessie/updates main contrib
EOF
tst apt update -qq
tst apt install -yq debconf-utils

out "Bash customization"
sed -f- -i ~/.bashrc <<- EOF
s|^# export LS_OPTIONS=.*|export LS_OPTIONS=\'--color=auto\'|;
s|^# eval \"\`dircolors\`\"|eval \"\`dircolors\`\"|;
s|^# alias l=.*|alias l=\'ls $LS_OPTIONS -lA\'|;
EOF
tst . /root/.bashrc

out "SSH Config"
sed -f- -i /etc/ssh/sshd_config <<- EOF
s|^#AuthorizedKeysFile.*|AuthorizedKeysFile     %h/.ssh/authorized_keys|;
s|^PermitRootLogin.*|PermitRootLogin yes|;
EOF
tst service ssh restart

out "Locales"
sed -i "s/# en_US.UTF-8/en_US.UTF-8/g" /etc/locale.gen
sed -i "s/# ${LOCALE}/${LOCALE}/g" /etc/locale.gen
tst locale-gen
tst dpkg-reconfigure -f noninteractive locales
echo "Language=${LOCALE}" > /etc/environment
tst . /etc/environment

out "Timezone"
echo ${TIMEZONE} > /etc/timezone
tst dpkg-reconfigure -f noninteractive tzdata

out "System upgrade"
tst apt update -qq
tst apt upgrade -yq
tst apt-get -yq autoremove --purge

##############
# PostgreSQL #
##############"
out "PostgreSQL 9.4"
tst apt install -yq postgresql sudo
sudo -u postgres psql -c "CREATE DATABASE ${DB_NAME};"
sudo -u postgres psql -c "CREATE USER ${DB_USER} WITH SUPERUSER PASSWORD '${DB_PASSWORD}';"
cat <<EOF > /etc/postgresql/9.4/main/pg_hba.conf
local all all trust
host all all 0.0.0.0/0 md5
EOF
tst mkdir -p "/var/run/postgresql/9.4-main.pg_stat_tmp"
tst chown postgres: "/var/run/postgresql/9.4-main.pg_stat_tmp"

##############
# ORACLE JDK #
##############
out "Oracle JDK"
apt remove -yq ".*(openjdk).*"
if [ ! $(command -v java) ] ; then
	tst apt install -yq ca-certificates
	if [ ${JAVA_METHOD} == "webupd8" ]; then
		out "Installing Oracle JAVA : using webupd8team apt repository"
		# https://www.it-connect.fr/installer-java-sous-debian-8-via-apt-get/
		echo "oracle-java${JAVA_VERSION}-installer shared/accepted-oracle-license-v1-1 boolean true" | debconf-set-selections
		tst apt install -yq software-properties-common
		add-apt-repository -y "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main"
		tst apt -q update
		tst apt install -yq oracle-java${JAVA_VERSION}-installer
		if [ ${JAVA_VERSION} == 7 ]; then
			# https://askubuntu.com/questions/920106/webupd8-oracle-java-7-installer-failing-with-404
			tst rm -rf /var/cache/oracle-jdk7-installer/jdk-7*
			tst wget -O /var/cache/oracle-jdk7-installer/jdk-7u80-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz
			tst apt install -yq oracle-java7-set-default
		fi
	elif [ ${JAVA_METHOD} == "duinsoft" ]; then
		out "Installing Oracle JAVA : using duinsoft apt repository"
		echo "deb http://www.duinsoft.nl/pkg debs all" >> /etc/apt/sources.list
		tst apt-key adv --keyserver keys.gnupg.net --recv-keys 0xE18CE6625CB26B26
		tst apt update -q
		tst apt install update-sun-jre
		tst update-sun-jre -c -r install
	elif [ ${JAVA_METHOD} == "oracle" ]; then
		out "Installing Oracle JAVA : using jdk .tar.gz"
		tst apt install -yqq java-package libxslt1.1
		tst apt remove -yqq ".*(openjdk).*"
		if [ ${JAVA_VERSION} == 7 ]; then
			tst wget -O /tmp/jdk-7u80-linux-x64.tar.gz http://ftp.osuosl.org/pub/funtoo/distfiles/oracle-java/jdk-7u80-linux-x64.tar.gz
			sudo su -c "cd /tmp; make-jpkg /tmp/jdk-7u80-linux-x64.tar.gz" postgres
			tst dpkg -i oracle-java8-jdk_7u80_amd64.deb
		elif [ ${JAVA_VERSION} == 8 ]; then
			out "Downloading JDK from Oracle's web site..."
			wget -O /tmp/jdk-8u152-linux-x64.tar.gz --no-cookies --no-check-certificate --header 'Cookie: oraclelicense=accept-securebackup-cookie' 'http://download.oracle.com/otn-pub/java/jdk/8u152-b16/aa0333dd3019491ca4f6ddbe78cdb6d0/jdk-8u152-linux-x64.tar.gz'
			out "Creation of .deb installer package"
			sudo su -c "cd /tmp; make-jpkg /tmp/jdk-8u152-linux-x64.tar.gz" postgres 
			tst dpkg -i /tmp/oracle-java8-jdk_8u152_amd64.deb
		fi
		tst . /etc/environment
	fi

	JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")
	JAVA_HOME=${JAVA_HOME:0:${#JAVA_HOME}-1}

	echo "JAVA_HOME=${JAVA_HOME}" >> /etc/environment
	. /etc/environment
	echo "export JAVA_HOME=${JAVA_HOME}" >> ~/.bashrc
fi

##########
# Tomcat #
##########"
if [ $(command -v java) ] ; then
	out "Tomcat"
	if [ ! -n ${JAVA_HOME} ]; then
		JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:bin/javac::")
		JAVA_HOME=${JAVA_HOME:0:${#JAVA_HOME}-1}
		export JAVA_HOME=${JAVA_HOME}
	fi
	tst apt install -yq tomcat${TOMCAT_VERSION} ssl-cert
	sed -f- -i /etc/default/tomcat${TOMCAT_VERSION} <<- EOF
	s|^#JAVA_HOME=.*|JAVA_HOME=${JAVA_HOME}|;
	#s|^JAVA_OPTS=.*|JAVA_OPTS="-classpath /usr/share/tomcat${TOMCAT_VERSION}/bin/bootstrap.jar:/usr/share/tomcat${TOMCAT_VERSION}/bin/tomcat-juli.jar -Dcatalina.base=/var/lib/tomcat${TOMCAT_VERSION} -Dcatalina.home=/usr/share/tomcat${TOMCAT_VERSION} -Djava.awt.headless=true -Djava.endorsed.dirs=/usr/share/tomcat${TOMCAT_VERSION}/endorsed -Djava.io.tmpdir=/tmp/tomcat${TOMCAT_VERSION}-tomcat${TOMCAT_VERSION}-tmp -Djava.util.logging.config.file=/var/lib/tomcat${TOMCAT_VERSION}/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xms${MEM_XMS}m -Xmx${MEM_XMX}m -XX:+UseConcMarkSweepGC"|;
	s|^#AUTHBIND=.*|AUTHBIND=yes|;
	EOF
	sed -i "s|8080|${PORT_HTTP}|g;" /etc/tomcat${TOMCAT_VERSION}/server.xml
	sed -i "s|8443|${PORT_HTTPS}|g;" /etc/tomcat${TOMCAT_VERSION}/server.xml
	if [ ${PORT_HTTP} -lt 1024 ]; then
		tst touch /etc/authbind/byport/${PORT_HTTP}
		tst chmod 500 /etc/authbind/byport/${PORT_HTTP}
		tst chown tomcat${TOMCAT_VERSION}: /etc/authbind/byport/${PORT_HTTP}
	fi
	if [ ${PORT_HTTPS} -lt 1024 ]; then
		tst touch /etc/authbind/byport/${PORT_HTTPS}
		tst chmod 500 /etc/authbind/byport/${PORT_HTTPS}
		tst chown tomcat${TOMCAT_VERSION}: /etc/authbind/byport/${PORT_HTTPS}
	fi
	tst dpkg-reconfigure -f noninteractive tomcat${TOMCAT_VERSION}
else
	out "Error : JAVA NOT FOUND ! Exiting script..."
	exit 0
fi

##########
# Axelor #
##########"
out "Axelor"
tst apt install -yq curl bsdtar ca-certificates
tst service tomcat${TOMCAT_VERSION} stop
# AUTO-INSTALLER
if [ ${AXELORINSTALL} == "auto" ]; then
	curl -fLsS "http://download.axelor.com/abs/autoInstaller/axelor-business-suite-${APPVERSION}-FR-linux-x64.run" | sed -e '1,/^exit 0$/d' | bsdtar -xf- -C /var/lib/tomcat${TOMCAT_VERSION}/webapps/ROOT/ --strip-components 4 ./var/www/axelor
	cp /var/lib/tomcat${TOMCAT_VERSION}/webapps/ROOT/WEB-INF/classes/application.properties /etc/tomcat${TOMCAT_VERSION}/axelor-application.properties
	sed -f- -i /var/lib/tomcat${TOMCAT_VERSION}/webapps/ROOT/WEB-INF/classes/module.properties <<- EOF
		s|^depends =.*|depends = axelor-core, axelor-exception, axelor-message, axelor-base, axelor-bank-payment, axelor-purchase, axelor-crm, axelor-account, axelor-supplychain, axelor-supplier-management, axelor-tool, axelor-sale, axelor-stock, axelor-project, axelor-client-portal, axelor-human-resource, axelor-cash-management, axelor-studio, axelor-marketing, axelor-production, axelor-business-project, axelor-business-production, axelor-l10n-en, axelor-l10n-fr, axelor-admin|;
		s|^installs =.*|installs = axelor-supplier-management, axelor-project, axelor-client-portal, axelor-base, axelor-bank-payment, axelor-purchase, axelor-account, axelor-cash-management, axelor-marketing, axelor-business-production, axelor-supplychain, axelor-stock, axelor-crm, axelor-l10n-en, axelor-l10n-fr, axelor-sale, axelor-business-project, axelor-human-resource, axelor-production, axelor-studio, axelor-admin, axelor-message, axelor-exception, axelor-tool|;
EOF
# MANUAL INSTALL
else
	# GET ADK
	out "Downloading Axelor Development kit"
	echo -e "${c7}"
	wget -qO- https://github.com/axelor/axelor-development-kit/archive/v${ADKVERSION}.tar.gz | tar xvz -C /opt
	echo -e "${c1}"
	cd /opt/axelor-development-kit-${ADKVERSION}
	tst ./gradlew installDist
	tst export AXELOR_HOME=/opt/axelor-development-kit-${ADKVERSION}/build/install/axelor-development-kit
	echo "AXELOR_HOME=${AXELOR_HOME}" >> /etc/environment
	echo "export AXELOR_HOME=${AXELOR_HOME}" >> ~/.bashrc
	echo 'export PATH=${JAVA_HOME}/bin:${AXELOR_HOME}/bin:$PATH' >> ~/.bashrc
	echo 'PATH=${JAVA_HOME}/bin:${AXELOR_HOME}/bin:$PATH' >> /etc/environment
	. /etc/environment

	# GET WEBAPP
	tst apt install -yq git unzip
	tst rm -Rf ${APPSRC}
	tst git clone https://github.com/axelor/abs-webapp.git ${APPSRC}
	cd ${APPSRC}
	sed -i 's|git@github.com:|https://github.com/|g' ${APPSRC}/.gitmodules
	tst git submodule init
	tst git submodule update
	tst git submodule foreach git checkout master
	tst git submodule foreach git pull origin master

	out "Build app"
	tst axelor build

	out "Application configuration"
	cd ${APPSRC}/build/libs
	tst unzip abs-webapp-4.1.1.war *.properties
	
	out "Config application"
	cp ${APPSRC}/build/libs/WEB-INF/classes/application.properties /etc/tomcat${TOMCAT_VERSION}/axelor-application.properties
	sed -f- -i /etc/tomcat${TOMCAT_VERSION}/axelor-application.properties <<- EOF
		#s|^db.default.ddl = .*|db.default.ddl = none|;
		s|^db.default.url = .*|db.default.url = jdbc:postgresql://${DB_HOST}:5432/${DB_NAME}|;
		s|^db.default.user = .*|db.default.user = ${DB_USER}|;
		s|^db.default.password = .*|db.default.password = ${DB_PASSWORD}|;
		s|^application.home = .*|application.home = ${HOMEURL}|;
		s|^application.mode = .*|application.mode = ${MODE}|;
		s|^date.timezone = .*|date.timezone = ${TIMEZONE}|;
		s|^application.logo = .*|application.logo = img/${LOGOFILE}|;
		s|^temp.dir = .*|temp.dir = {java.io.tmpdir}|;
		s|^file.upload.dir = .*|file.upload.dir = {user.home}|;
		s|^file.upload.size = .*|file.upload.size = ${UPLOADMAXSIZE}|;
	EOF
	cat <<EOF >> /etc/tomcat${TOMCAT_VERSION}/axelor-application.properties

	# Specify whether to import demo data
	# ~~~~~
	data.import.demo-data = ${IMPORTDATA}
EOF
	sed -f- -i /etc/default/tomcat${TOMCAT_VERSION} <<- EOF
		s|^JAVA_OPTS=.*|JAVA_OPTS="-classpath /usr/share/tomcat${TOMCAT_VERSION}/bin/bootstrap.jar:/usr/share/tomcat${TOMCAT_VERSION}/bin/tomcat-juli.jar -Daxelor.config=/etc/tomcat${TOMCAT_VERSION}/axelor-application.properties -Dcatalina.base=/var/lib/tomcat${TOMCAT_VERSION} -Dcatalina.home=/usr/share/tomcat${TOMCAT_VERSION} -Djava.awt.headless=true -Djava.endorsed.dirs=/usr/share/tomcat${TOMCAT_VERSION}/endorsed -Djava.io.tmpdir=/tmp/tomcat${TOMCAT_VERSION}-tomcat${TOMCAT_VERSION}-tmp -Djava.util.logging.config.file=/var/lib/tomcat${TOMCAT_VERSION}/conf/logging.properties -Djava.util.logging.manager=org.apache.juli.ClassLoaderLogManager -Xms${MEM_XMS}m -Xmx${MEM_XMX}m -XX:+UseConcMarkSweepGC"|;
	EOF

	out "Setup actives modules"
	sed -f- -i ${APPSRC}/build/libs/WEB-INF/classes/module.properties <<- EOF
		s|^depends = .*|depends = axelor-account, axelor-admin, axelor-bank-payment, axelor-base, axelor-business-production, axelor-business-project, axelor-cash-management, axelor-client-portal, axelor-core, axelor-crm, axelor-demo-en, axelor-demo-fr, axelor-exception, axelor-human-resource, axelor-l10n-en, axelor-l10n-fr, axelor-marketing, axelor-message, axelor-production, axelor-project, axelor-purchase, axelor-stock, axelor-studio, axelor-supplier-management, axelor-supplychain, axelor-tool, axelor-sale|;
		s|^installs = .*|installs = axelor-account, axelor-admin, axelor-bank-payment, axelor-base, axelor-business-production, axelor-business-project, axelor-cash-management, axelor-client-portal, axelor-core, axelor-crm, axelor-exception, axelor-human-resource, axelor-l10n-en, axelor-l10n-fr, axelor-marketing, axelor-message, axelor-production, axelor-project, axelor-purchase, axelor-stock, axelor-studio, axelor-supplier-management, axelor-supplychain, axelor-tool, axelor-sale|;
	EOF

	out "Update .war"
	tst jar uf abs-webapp-${APPVERSION}.war WEB-INF/classes/*.properties
	rm -Rf 

	tst rm -Rf /var/lib/tomcat${TOMCAT_VERSION}/webapps/ROOT
	out "Copy ROOT.war"
	tst cp ${APPSRC}/build/libs/abs-webapp-${APPVERSION}.war /var/lib/tomcat${TOMCAT_VERSION}/webapps/ROOT.war
fi

tst mkdir -p /usr/share/tomcat${TOMCAT_VERSION}/common/classes
tst chown -R tomcat${TOMCAT_VERSION}: /usr/share/tomcat${TOMCAT_VERSION}/common
tst mkdir -p /usr/share/tomcat${TOMCAT_VERSION}/server/classes
tst chown -R tomcat${TOMCAT_VERSION}: /usr/share/tomcat${TOMCAT_VERSION}/server
tst mkdir -p /usr/share/tomcat${TOMCAT_VERSION}/shared/classes
tst chown -R tomcat${TOMCAT_VERSION}: /usr/share/tomcat${TOMCAT_VERSION}/shared

out "Post-install config"
echo "" > /var/log/tomcat${TOMCAT_VERSION}/catalina.out
service tomcat${TOMCAT_VERSION} start
until tail /var/log/tomcat${TOMCAT_VERSION}/catalina.out | grep -m 1 "INFO: Server startup in"; do : echo "" ; done
sed -f- -i /etc/tomcat${TOMCAT_VERSION}/axelor-application.properties <<- EOF
	s|^db.default.ddl = .*|db.default.ddl = none|;
EOF
out "Restarting Tomcat"
service tomcat${TOMCAT_VERSION} restart

###########
# Cleanup #
###########
out "Cleanup"
tst apt-get autoremove -qy --purge
tst apt-get clean -qy
tst rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*
