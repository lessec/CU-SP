# BBSJSP
The Secure Progamming Project

---
## Syetem pecifications
1) OS --------- CentOS 8 Stream (minimal)
2) Server ----- Apache
3) Lang ------- OpenJDK 17.0.0
4) Platform --- VMWare Fusion
5) Location --- -
6) CPU -------- 1v
7) Ram -------- 2GB
8) Disk ------- 10GiB(SSD)


---
## 1. System update & dependency
```sh
$ sudo dnf update -y && sudo dnf install -y curl wget unzip gcc gcc-c++ make git
```


---
## 2. Apache
```sh
$ sudo dnf install -y httpd && sudo systemctl enable httpd && sudo systemctl start httpd
```


---
## 3. Tomcat
### Install Java17(OpenJDK) and Tomcat
```sh
$ sudo dnf install -y java-17-openjdk-devel && java --version
$ wget https://dlcdn.apache.org/tomcat/tomcat-10/v10.0.12/bin/apache-tomcat-10.0.12.tar.gz && sudo tar -zxvf apache-tomcat*tar.gz -C /opt && cd /opt && sudo mv apache-tomcat* tomcat
$ cd /opt/tomcat && sudo groupadd tomcat && sudo useradd -M -s /bin/nologin -g tomcat -d /opt/tomcat tomcat && sudo chgrp -R tomcat /opt/tomcat && sudo chmod -R g+r conf && sudo chmod g+x conf && sudo chown -R tomcat:tomcat webapps/ work/ temp/ logs/
```

### User
```sh
$ sudo vi /etc/systemd/system/tomcat.service
```
```sh
[Unit]
Description=Apache Tomcat Web Application Container
After=syslog.target network.target
 
[Service]
Type=forking

Environment=JAVA_HOME=/usr/lib/jvm/java-17-openjdk
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment='CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC'
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd=file:/dev/./urandom'

ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/stop.sh

User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always

[Install]
WantedBy=multi-user.target
```

### Tomat add systemctl 
```sh
$ sudo systemctl daemon-reload && sudo systemctl enable tomcat && sudo systemctl start tomcat
```


---
## 4. Integration 80 port
### Install mod_jk
```sh
$ sudo dnf install -y httpd-devel redhat-rpm-config
$ cd /tmp && wget https://dlcdn.apache.org/tomcat/tomcat-connectors/jk/tomcat-connectors-1.2.48-src.tar.gz && tar -zxvf tomcat-connectors-* && cd /tmp/tomcat-connectors-*/native && ./configure --with-apxs=/usr/bin/apxs && make && sudo make install && sudo chcon -u system_u -r object_r -t httpd_modules_t /etc/httpd/modules/mod_jk.so && sudo ls -al /etc/httpd/modules/mod_jk.so
```

### Add apache module
```sh
sudo vi /etc/httpd/conf.modules.d/00-base.conf
```
```apache
LoadModule jk_module modules/mod_jk.so
```

### Virtual Host
```sh
$ sudo vi /etc/httpd/conf.d/vhost.conf
```
```apache
<VirtualHost *:80>
        ServerName bbsjsp.tryto.be
        DocumentRoot "/opt/tomcat/webapps/ROOT"

        <Directory "/opt/tomcat/webapps/ROOT">
                AllowOverride None
                Require all granted
        </Directory>

        DirectoryIndex index.html index.jsp

        JkMount /*.jsp worker1
        JkMount /*.json worker1
        JkMount /*.xml worker1
        JkMount /*.do worker1

</VirtualHost>
```

### Add mod_jk Configure
```sh
$ sudo vi /etc/httpd/conf.d/mod_jk.conf
```
```apache
<IfModule mod_jk.c>
        # Where to find workers.properties
        JkWorkersFile conf/workers.properties

        # Add shared memory: JkShmFile run/mod_jk.shm
        JkShmFile /var/cache/httpd/mod_jk.shm

        # Where to put jk logs
        JkLogFile logs/mod_jk_log

        # Set the jk log level [debug/error/info]
        JkLogLevel error

        # Select the log format
        JkLogStampFormat  "[%a %b %d %H:%M:%S %Y]"

        # JkOptions indicates to send SSK KEY SIZE
        JkOptions +ForwardKeySize +ForwardURICompat -ForwardDirectories

        # JkRequestLogFormat
        JkRequestLogFormat "%w %V %T"

        # Add jkstatus for managing runtime data
        <Location /jkstatus>
                JkMount status
                Order deny,allow
                Deny from all
                Allow from 127.0.0.1
        </Location>
        #<Location /jkmanager>
        #        JkMount jkmanager
        #        Order deny,allow
        #        Deny from all
        #        Allow from 127.0.0.1
        #</Location>
</IfModule>
```

### Change Appace Configure
```sh
$ sudo vi /etc/httpd/conf/httpd.conf
```
```apache
User tomcat
Group tomcat
ServerName 127.0.0.1
```

### Add workers.properties
```sh
$ sudo vi /etc/httpd/conf/workers.properties
```
```apache
# Define real worker using ajp13
worker.list=worker1

# Set properties for worker (ajp13)
worker.worker1.type=ajp13
worker.worker1.host=localhost
worker.worker1.port=8009
worker.worker1.lbfactor=1
```

### Conntec Tomcat
```sh
$ sudo vi /opt/tomcat/conf/server.xml
```
```xml
    <!-- Define an AJP 1.3 Connector on port 8009 -->
    <Connector protocol="AJP/1.3"
               address="::1"
               secretRequired="false"
               port="8009"
               redirectPort="8443" />
```

### Restart Apache and Tomcat
```sh
$ sudo systemctl restart httpd && sudo systemctl restart tomcat
$ sudo setenforce 0
```

### Disable SELinux
```sh
$ sudo vi /etc/selinux/config
```
```sh
SELINUX=disabled
```


---
## 5. MySQL
### Install MySQL
#### 1) CentOS 8 
```sh
$ sudo dnf install -y mysql-server && sudo systemctl enable mysqld && sudo systemctl start mysqld
```


---
## 6. Setup Database
```sh
$ mysql -u root -p
```
```sql
CREATE DATABASE BBS;

USE BBS;

CREATE TABLE USER (
userID VARCHAR(20),
userPassword VARCHAR(70),
userSalt VARCHAR(40),
userName VARCHAR(40),
userGender VARCHAR(10),
userEmail VARCHAR(40),
userFail INT,
userLock INT,
PRIMARY KEY (userID)
);
  
CREATE TABLE BOARD (
boardID INT,
boardTitle VARCHAR(50),
userID VARCHAR(20),
boardDate DATETIME,
boardContent VARCHAR(2048),
boardAvailable INT,
PRIMARY KEY (boardID)
);

exit;
```


---
## 7. Deploy on server
```sh
$ sudo mv /opt/tomcat/webapps/ROOT /opt/tomcat/webapps/ROOT.bck && sudo rm -rf /opt/tomcat/webapps/ROOT
$ cd ~ && git clone https://github.com/leelsey/WeekBBSJSP && sudo cp ~/WeekBBSJSP/out/artifacts/bbsjsp_war/bbsjsp_war.war ~/WeekBBSJSP/out/artifacts/bbsjsp_war/ROOT.war && sudo mv ~/WeekBBSJSP/out/artifacts/bbsjsp_war/ROOT.war /opt/tomcat/webapps && sudo chown -R tomcat:tomcat /opt/tomcat && sudo ls -al /opt/tomcat/webapps
```