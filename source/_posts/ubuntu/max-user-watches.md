---
title: max_user_watches
copyright: true
date: 2019-07-29 11:22:33
categories:
    - ubuntu
tags:
    - ubuntu
    - vscode
---
max_user_watches参数限制了系统对活动文件监测数量的上限。
如果数值过小，ide工具(vscode等)可能失去对文件变化的监听，比如文件变化引起的git状态变化和webpack等工具的热加载。

<!-- more -->

```
~:sudo vim /etc/sysctl.conf
fs.inotify.max_user_watches=524288
```