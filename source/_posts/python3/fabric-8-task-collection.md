---
title: fabric (8) task collection
copyright: true
date: 2019-07-31 11:27:45
categories:
      - python3
tags:
      - python3
      - python
      - fabric
      - ssh
---
fabric可以通过指定脚本文件运行特定的任务，这样不同的环境就可以执行不同的脚本。

最新版本可能是通过指定文件夹的方式指定运行的脚本目录。
在之前的版本里可以直接指定脚本文件。

<!-- more -->

(1) collection

collection is a task list like fabfile

+ myTasks.py
  
    ```
    @task
    def task1(c):
    ...

    @task
    def task2(c):
    ...
    ```

+ fabfile.py

    ```
    @task
    def task3(c):
    ...

    @task
    def task4(c):
    ...
    ```
    
(2) specify collection

use `-c` to specify a task collection
```
~:fab -l
task3
task4

~:fab -c myTasks -l
task1
task2
```