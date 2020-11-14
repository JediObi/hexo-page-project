---
title: docker-mysql8
copyright: true
mathjax: false
date: 2020-11-06 22:50:06
categories:
tags:
---
文章简介

<!-- more -->

正文
docker run -d --name mysql8-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
 -v /home/user/work/docker_data/mysql/conf/:/etc/mysql \
 -v /home/user/work/docker_data/mysql/mysql-files:/var/lib/mysql-files \
 -v /home/user/work/docker_data/mysql/logs:/var/log/mysql \
 -v /home/user/work/docker_data/mysql/data:/var/lib/mysql \
 -v /etc/localtime:/etc/localtime:ro \
 mysql:8 --character-set-server=utf8 --collation-server=utf8_bin

 docker run -d --name mysql-test -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 \
 -v /usr/local/docker/mysql/conf:/etc/mysql \
 -v /usr/local/docker/mysql/logs:/var/log/mysql \
 -v /usr/local/docker/mysql/data:/var/lib/mysql \
 -v /etc/localtime:/etc/localtime:ro \
 mysql:5.7 --character-set-server=utf8 --collation-server=utf8_bin