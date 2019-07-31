---
title: ansible (1) install by pip
copyright: true
date: 2019-07-31 11:29:51
categories:
      - python3
tags:
      - python3
      - python
      - ansible
      - ssh
---
ansible也是一款高级ssh操作的包。
ansible的优点是，不需要写python脚本，友好的文本输出，可回滚。
使用yaml编写任务内容，这在ansible里称为剧本。

<!-- more -->

(1) install ansible

```
~:sudo pip3 install ansible
```

(2) use ssh pass

```
~:sudo apt-get install sshpass
```

(3) create /etc/ansible/hosts

```
~:sudo mkdir -p /etc/ansible
```

+ /etc/ansible/hosts

    ```
    [test]
    192.168.0.100  ansible_ssh_user=root  ansible_ssh_pass=root123

    [server1]
    192.168.0.101 ansible_ssh_user=root  ansible_ssh_pass=root123
    ```

(4) usage ping

```
~:ansible test -m ping
192.168.0.100 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}

~:ansible all -m ping
192.168.0.100 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
192.168.0.101 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```
