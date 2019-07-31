---
title: oracle operation
copyright: true
date: 2019-07-31 10:34:32
categories:
    - oracle
tags:
    - oralce
---
oracle数据库常用操作。远程登录，授权和表空间。

<!-- more -->

### **1. oracle user**

```
su - oracle
```

### **2. local login as dba**

```
sqlplus / as sysdba
```

### **3. common login**

```
sqlplus user/password
```

### **4. remote login**

```
sqlplus user/password@ip:port/service_name
```

### **5. create user and grant**

```
create user user1 identified by 123456;
alter user user1 default tablespace user1_ts;
create user user1 identified by 123456 default tablespace user1_ts;
grant connect,resource,dba to user1;
drop user user1 cascade;
```

### **6. table space**

```
create tablespace user1_ts datafile 'oracle_home/oradata/user1_ts.dbf' size 300m autoextend on;
select * from v$tablespace;
select * from sys.dba_tablespaces;
select count(*) from sys.v_$session；
```
