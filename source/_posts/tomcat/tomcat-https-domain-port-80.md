---
title: tomcat https+domain+port 80
copyright: true
date: 2019-07-31 18:40:35
categories:
    - tomcat
tags:
    - tomcat
---
为tomcat配置域名。
tomcat的host可以配置域名。

<!-- more -->

(1) generate ssl certificate

`keytool -genkeypair -alias "tomcat" -keyalg "RSA" -keystore "/home/admin/tomcat.keystore"`
Notice : remeber first name and last name and password during the generating.

(2)tomcat_home/config/server.xml

+ https and port 80
  
  1) Port `80` is the default port for http connection. Config  `Connector` `port` to 80. And then you don't need to specify the port in your website.

  2) https service need port `443`. So, redirect your http connection to port 443 (original setting is 8443). Config the `Connector` `redirectPort` to 443.
  Default setting about the 443 Connector is commented and you have to uncomment it.
  Other connectors' `redirectPort=8443` also need to be changed to 443. 

  ```xml
  <Connector port="80" URIEncoding="UTF-8" protocol="HTTP/1.1"
                 connectionTimeout="20000"
                 redirectPort="443" />

  <Connector
             protocol="org.apache.coyote.http11.Http11NioProtocol"
             port="443" maxThreads="150" URIEncoding="UTF-8"
             scheme="https" secure="true" SSLEnabled="true"
             keystoreFile="server.keystore" keystorePass="test123"
             clientAuth="false" sslProtocol="TLS"/>
  ```

(3) domain

Domain is specified in `Host`.
And if you want to visit project without specifying project name, a `Conext` is required.

```xml
<Host name="www.abc.com" appBase="webapps" unpackWARs="true" autoDeploy="true" xmlValidation="false" xmlNamespaceAware="false">
...
<Context path="" docBase="project1" reloadble="true">
        </Context>
...
</Host>
```
`docBase`: absolute path or relative path to `tomcat_home/webapps`.