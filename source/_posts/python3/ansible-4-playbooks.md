---
title: ansible (4) playbooks
copyright: true
date: 2019-07-31 11:34:42
categories:
      - python3
tags:
      - python3
      - python
      - ansible
      - ssh
---
剧本是ansible最重要的概念。
剧本定义了所有远端操作的内容。

<!-- more -->

(1) playbooks 剧本

所有要执行的操作流程写到playbooks
ansible会为指定的服务器执行playbooks里的所有操作

(2) playbooks 内容

+ local.yml
  
    ```yml
    - hosts: 127.0.0.1
    connection: local
    vars:
        project_name: xxx
        project_dir: xxx
        mvn_settings_dir: xxx
        module_dir_name: xxx
    tasks:
        - name: build file
        shell: mvn -s {{mvn_settings_dir}} -f {{project_dir}}/{{module_dir_name}}/pom.xml clean compile package -DskipTests
        register: mvnInfo
        - name: print package
        debug: var=mvnInfo.stdout_lines verbosity=0
    ```
    ```
    ~:ansible-playbook -i ../hosts local.yml
    ```

+ remote.yml
  
    ```yml
    - hosts: '{{profile}}'
    vars:
        project_name: xxx
        project_dir: xxx
        mvn_settings_dir: xxx
        module_dir_name: xxxx
        file_name: xxx
    tasks:
        - name: file exist test
        shell: test -e {{upload_dir}}/{{file_name}};echo $?
        register: outputInfo
        - name: get format time
        shell: date +'%Y-%m-%d-%H-%M-%S'
        register: timeInfo
        - name: backup file if exist
        shell: mv '{{upload_dir}}/{{file_name}}' '{{upload_dir}}/{{file_name}}.bak.{{timeInfo.stdout}}'
        when: outputInfo.stdout.find("0")!=-1
        register: backupInfo
        - name: print backup process info
        debug: var=backupInfo verbosity=0
        - name: upload file
        copy: 
            src: '{{project_dir}}/{{module_dir_name}}/target/{{file_name}}'
            dest: '{{upload_dir}}'
    ```
    ```
    ~:ansible-playbook -i ../hosts local.yml -e "profile=prod upload_dir=/home/user/upload"
    ```
