---
title: 查看reset消失的commit id
copyright: true
date: 2019-08-01 11:17:09
categories:
    - git
tags:
    - git
    - reset
    - 误删回退
---
有时候本地分支是tracked远程分支，那么对远程commit执行reset会删除掉本地没有提到远程的commit，
这些误删的commit 在log里不会显示，但是可以通过本文介绍的命令查看。

<!-- more -->

`git fsck --lost-found`

`git show <commit-id>`