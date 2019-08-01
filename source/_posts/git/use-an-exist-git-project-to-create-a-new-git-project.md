---
title: use an exist git project to create a new git project
copyright: true
date: 2019-08-01 11:09:56
categories:
    - git
tags:
    - git
---
使用远程git项目创建新的git工程。
clone项目，修改remote地址，删除缓存的远程分支，推送本地分支到新的远程仓库。

<!-- more -->

(1) clone the exist one
git clone https://xxx.com/old.git

now you will get a local branch `master`

(2) checkout the remote branches you want on local
git checkout -b local1 origin/remote1
git checkout -b local2 origin/remote2

now you have `master`, `local1`,`local2`

(3) create a new project on git website

url: https://xxx.com/new.git

(4) change url of the local project to the new website
git remote set-url origin https://xxx.com/new.git

(5) push the local project to website
git push origin master
git push origin local1
git push origin local2

(6) prune cache of other branches
git remote prune origin

(7) change the project name to new