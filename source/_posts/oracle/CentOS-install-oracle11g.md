---
title: CentOS install oracle11g
copyright: true
date: 2019-07-29 14:39:25
categories:
    - oracle
tags:
    - centos
    - oracle
---
oracle数据库在centos上的安装

<!-- more -->

## **1. prepare the runtime environment**

### **1.1 swap partition**

    `~:free` to see swap size
    It shouldn't be less than 2G.
    Change it.

**Note: root user**

+ #### 1.1.1 close the swap

  ```
  ~:swapoff -a
  ```
  
+ #### 1.1.2 create swap file

  ```
  dd if=/dev/zero of=/var/swapfile bs=1M count=4096
  ```
  create a swap file at /var/swapfile, capacity is 4G.

+ #### 1.1.3 make the swap file become swap partition

  ```
  ~:mkswap /var/swapfile
  ```

+ #### 1.1.4 open swap

  ```
  ~:swapon /var/swapfile
  ~:free
  ```

+ #### 1.1.5 mount swap partition when startup

  ==> vim /etc/fstab
  ```
  /var/swapfile	swap	swap	defaults	0 0
  ```

### **1.2 install dependencies**

**Note: root user**

**==>** to see if you've installed the package
`rpm -q package_name`
**==>** install a package
`yum install package_name`
**==>** for example here we install a package of x64 and x86.
`~:yum install -y libaio`
`~:yum install -y libaio*.i686`
**==>** dependencies list
```
binutils-2.17.50.0.6

compat-libstdc++-33-3.2.3

compat-libstdc++-33-3.2.3 (32 bit)

elfutils-libelf-0.125

elfutils-libelf-devel-0.125

gcc-4.1.2

gcc-c++-4.1.2

glibc-2.5-24

-->glibc-2.5-24 (32 bit) 

glibc-common-2.5

glibc-devel-2.5

glibc-devel-2.5 (32 bit) 

glibc-headers-2.5

ksh-20060214

libaio-0.3.106

libaio-0.3.106 (32 bit) 

libaio-devel-0.3.106

libaio-devel-0.3.106 (32 bit)

libgcc-4.1.2

libgcc-4.1.2 (32 bit)

libstdc++-4.1.2

libstdc++-4.1.2 (32 bit)

libstdc++-devel 4.1.2

make-3.81

sysstat-7.0.2

unixODBC-2.2.11 (32-bit) or later

unixODBC-devel-2.2.11 (32-bit) or later

unixODBC-devel-2.2.11 (64-bit) or later

unixODBC-2.2.11 (64-bit) or later
```

### **1.3 add user and group for oracle**

**Note: root user**

```
~:groupadd oinstall
~:groupadd dba
~:useradd -g oinstall -G dba oracle
~:passwd oracle
```

### **1.4 change linux kernal config to adapt oracle**

**Note: root user**

+ #### 1.4.1 change config

    vim /etc/sysctl.conf
    ```
    fs.aio-max-nr = 1048576
    fs.file-max = 6815744
    kernel.shmall = 2097152		# [2048*1024 k] at least 1/4 of RAM
    kernel.shmmax = 536870912  # [4*1024*1024*1024 b] at least 1/2 of RAM, set kernel.shmmax 4G if RAM is small than 4G.
    kernel.shmmni = 4096
    kernel.sem = 250 32000 100 128
    net.ipv4.ip_local_port_range = 9000 65500
    net.core.rmem_default = 262144
    net.core.rmem_max = 4194304
    net.core.wmem_default = 262144
    net.core.wmem_max = 1048576
    ```

+ #### 1.4.2 make the config run

    `~:/sbin/sysctl -p`

### **1.5 limits hard ware usage of oracle**

**Note: root user**

+ #### 1.5.1 limits

    **==>** vim /etc/security/limits.conf 
    ```

    oracle soft nproc 2047

    oracle hard nproc 16384

    oracle soft nofile 1024

    oracle hard nofile 65536

    oracle soft stack 10240
    ```

+ #### 1.5.2 the limits depend on pam

    **==>** vim /etc/pam.d/login
    ```
    session required /lib/security/pam_limits.so

    session required pam_limits.so
    ```

+ #### 1.5.3 other limits

    **==>** vim /etc/profile
    ```
    if [ $USER = "oracle" ]; then

        if [ $SHELL = "/bin/ksh" ]; then

            ulimit -p 16384

            ulimit -n 65536

        else

            ulimit -u 16384 -n 65536

        fi

    fi
    ```

### **1.6 create install direcotry**

**Note: root user**

```
~:cd /usr/local
~:mkdir -p oracle_about/app/
~:chown -R oracle:oinstall oracle_about/app/
~:chmod -R 775 oracle_about/app/
```

### **1.7 create install location describe file**

**Note: root user**

+ #### 1.7.1 create install file

    **==>** vim /etc/oraInst.loc
    ```
    inventory_loc=/usr/local/oracle_about/app/oracle/oraInventory
    inst_group=oinstall
    ```

+ #### 1.7.2 change user and authority of the install location describe file

    ```
    ~:chown oracle:oinstall /etc/oraInst.loc
    ~:chmod 664 /etc/oraInst.loc
    ```

### **1.8 config oracle environment variables**

**Note: oracle user**

```
su - oracle
```

+ #### 1.8.1 config ~/.bash_profile

    **==>** vim ~/.bash_profile
    ```
    export ORACLE_BASE=/usr/local/oracle_about/app/oracle
    export ORACLE_SID=orcl
    ```

+ #### 1.8.2 make it effective

    `~:source .bash_profile`

+ #### 1.8.3 check the environment variables

    `~:env`

### **1.9 unzip install binary file**

**Note: root user**

**==>**
```
~:chown oracle:oinstall 1of2.zip
~:chown oracle:oinstall 2of2.zip
```

**Note: oracle user**

unzip to /home/oracle
then you can see /home/oracle/database

### **1.10 copy reponse template**

**Note: oracle user**

```
~:mkdir etc
~:cp ~/database/response/* ~/etc
# change authority
~:chmod 700 /home/oracle/etc/*.rsp
```

### **1.11 config reponse template**

**Note: oracle user**

**==>** vim /home/oracle/etc/db_install.rsp
```
oracle.install.option=INSTALL_DB_SWONLY // line 29, install type

ORACLE_HOSTNAME=xx12ab4OB21xN // line 37, your hostname, use command hostname to get
UNIX_GROUP_NAME=oinstall // line 42, user's group

INVENTORY_LOCATION=/u01/app/oracle/oraInventory // line 47, INVENTORY derectory

SELECTED_LANGUAGES=en,zh_CN,zh_TW // line 78, language

ORACLE_HOME=/u01/app/oracle/product/11.2.0/db_1 // line 83, oracle_home

ORACLE_BASE=/u01/app/oracle // line 88, oracle_base

oracle.install.db.InstallEdition=EE // line 99, oracle version

oracle.install.db.isCustomInstall=true // line 108, true means you can custom some configrations

oracle.install.db.DBA_GROUP=dba // line 142,  dba group

oracle.install.db.OPER_GROUP=oinstall // line 147,  oper group

oracle.install.db.config.starterdb.type=GENERAL_PURPOSE // line 160,  db type

oracle.install.db.config.starterdb.globalDBName=orcl // line 165,  global DBName

oracle.install.db.config.starterdb.SID=orcl // line 170, SID

oracle.install.db.config.starterdb.memoryLimit=512 // line 192, min ram use

oracle.install.db.config.starterdb.password.ALL=oracle // line 233, all dba user password

DECLINE_SECURITY_UPDATES=true // line 385, security updates
```

## **2. install oracle**

### **2.1 install oracle**

+ #### 2.1.1 oracle user

  1. install

    ```
    ~:cd database
    ~:./runInstaller -silent -responseFile /home/oracle/etc/db_install.rsp
    # installer will install in background, you can see logs 
    ~:cd /usr/local/oracle_about/app/oracle/oraInventory
    ~:tail -100f installActions*.log
    ```

  2. susccsful log

    ```
    ...

    To execute the configuration scripts:

    1. Open a terminal window 

    2. Log in as "root" 

    3. Run the scripts 

    4. Return to this window and hit "Enter" key to continue

    

    Successfully Setup Software.
    ```

  3. root.sh

    **Note: root user**
    ```
    ~:cd /usr/local/oracle_about/app/oracle/product/11.2.0/db_1
    ~:./root.sh
    ```

### **2.2 config oracle environment variables**

**Note: oracle user**

**==>** vim ~/.bash_profile
```
export ORACLE_HOME=$ORACLE_BASE/product/11.2.0/db_1

export TNS_ADMIN=$ORACLE_HOME/network/admin

export PATH=.:${PATH}:$HOME/bin:$ORACLE_HOME/bin

export PATH=${PATH}:/usr/bin:/bin:/usr/bin/X11:/usr/local/bin

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ORACLE_HOME/lib

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:$ORACLE_HOME/oracm/lib

export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/lib:/usr/lib:/usr/local/lib

export CLASSPATH=${CLASSPATH}:$ORACLE_HOME/JRE

export CLASSPATH=${CLASSPATH}:$ORACLE_HOME/JRE/lib

export CLASSPATH=${CLASSPATH}:$ORACLE_HOME/jlib

export CLASSPATH=${CLASSPATH}:$ORACLE_HOME/rdbms/jlib

export CLASSPATH=${CLASSPATH}:$ORACLE_HOME/network/jlib

export LIBPATH=${CLASSPATH}:$ORACLE_HOME/lib:$ORACLE_HOME/ctx/lib

export ORACLE_OWNER=oracle

export SPFILE_PATH=$ORACLE_HOME/dbs

export ORA_NLS10=$ORACLE_HOME/nls/data
```
**==>** source ~/.bash_profile

### **2.3 config listening**

**Note: oracle user**

```
~:$ORACLE_HOME/bin/netca /silent /responseFile /home/oracle/etc/netca.rsp
```

### **2.4 create database**

**Note: oracle user**

+ #### 2.4.1 config template

    **==>** vim /home/oracle/etc/dbca.rsp
    ```
    GDBNAME="orcl.java-linux-test" // line 78, service_name=SID+hostname

    SID="orcl" // line 149, SID

    CHARACTERSET="AL32UTF8" // line 415, charset

    NATIONALCHARACTERSET="UTF8" // line 425, charset
    ```

+ #### 2.4.2 create

    $ORACLE_HOME/bin/dbca -silent -responseFile /home/oracle/dbca.rsp

+ #### 2.4.3 get result

    ps -ef | grep ora_ | grep -v grep | wc -l

### **2.5 start listening**

**Note: oracle user**

```
~:cd /usr/local/oracle_about/app/oracle/product/11.2.0/db_1/bin
~:lsnrctl status
~:lsnrctl start
```

### **2.6 using `dbstart` and `dbshut` to contol listening**

**Note: oracle user**

**==>** vim /etc/oratab

```
racl:/u01/app/oracle/product/11.2.0/db_1:Y // N becomes Y
```
```
~:cd /usr/local/oracle_about/app/oracle/product/11.2.0/db_1/bin
~:dbstart $ORACLE_HOME
~:dbshut	$ORACLE_HOME
~:lsnrctl status
```
