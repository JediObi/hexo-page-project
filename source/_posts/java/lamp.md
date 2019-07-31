---
title: lamp
copyright: true
date: 2019-07-31 11:02:37
categories:
    - java
tags:
    - java
    - php
---
linux + apache2 + php + mysql 的开发环境配置。

<!-- more -->

apache2
php 7.2
mariadb 10.2

(1) install mariadb

(2) install apache2
```
~:sudo apt-get install apache2
```

Apache2 will listen port 80 when it started.
If 80 is already in use, disable it and use another port and config.

+ #### port
cd /etc/apache2
vim ports.conf
```
#Listen 80
Listen 9080
```
+ #### root dir
cd /etc/apache2/sites-available
cp 000-default.conf 9080-php.conf
vim 9080-php.conf
```
ServerName localhost

DocumentRoot /home/hm70/work/shop
<Directory "/home/hm70/work/shop">
		Options Indexes FollowSymLinks
	    	AllowOverride None
	    	Require all granted
</Directory>
```
ln -s /etc/apache2/sites-available/9080-php.conf /etc/apache2/sites-enable/9080-php.conf

+ localhost:9080

(3) php 

```
~:sudo apt-get install php7.2
# mysql support
~:sudo apt-get install php7.2-mysql
# picture(jpeg,gif,png) support
~:sudo apt-get install php7.2-gd
```
(4) index.php
```php
<?php
if(mysqli_connect("localhost","root","root")){
  echo "success";
}else {
  echo "failed";
}
?>
```
+ localhost:9080


