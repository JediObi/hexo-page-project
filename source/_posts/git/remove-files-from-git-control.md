---
title: remove files from git control
copyright: true
date: 2019-08-01 11:12:18
categories:
    - git
tags:
    - git
---
添加ignore文件。
已被本地git管理的文件加入ignore。
已被远程git管理的文件加入ignore。

<!-- more -->

Add a file name into gitignore but the file has alredy been tracked;

(1) add into .gitignore
a.txt
dir/

(2) remove cache
git rm -r --cached .
or git rm -rf --cached .

(3) if the file has been pushed to remote
delete remote file.
then remove cache