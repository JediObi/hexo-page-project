---
title: (1) Docker
copyright: true
date: 2019-07-25 19:04:51
categories:
    - docker
tags:
    - docker
---
docker的安装配置。  
操作，镜像管理。    
连接实例。终端融合。

<!-- more -->

### **1. install docker**

```
~:wget -qO- https://get.docker.com/ | sh
~:sudo usermod -aG docker user_group
~:reboot
~:sudo service docker start
~:docker run hello-world
```

### **2. docker mirrors**

 + #### 2.1 /etc/docker/daemon.json

    ```json
    {
    "registry-mirrors": ["http://hub-mirror.c.163.com"]
    }
    ```

### **3. docker command**

+ #### 3.1 run

    ```
    ~:docker run ubuntu:15.10 /bin/echo "Hello world"
    ```
    run `ubuntu:15.10` and use `/bin/echo` to print "Hello world".

+ #### 3.2 ps

    ```
    ~:docker ps
    ```
    list the running containers.

+ #### 3.3 logs

    ```
    ~:docker logs {name[or container_id]}
    ~:docker logs -f {}
    ```
    pirnt the specified container's logs.   
    `logs -f` just like `tail -f`.

+ #### 3.4 stop

    ```
    ~:docker stop {name[or container_id]}
    ```
    stop the specified container.

+ #### 3.5 --help

    ```
    ~:docker [command] --help
    ```
    print help info of a docker command.

+ #### 3.6 pull
    ```
    ~:docker pull [repository]
    ```
    pull a repository image.

+ #### 3.7 images

    ```
    ~:docker images
    ```
    list the images in this computer.

+ #### 3.8 port

    ```
    ~:docker port {[name] or [container_id]} {[null] or [container port]}
    ```
    print the port mapping of a container.

+ #### 3.9 rm

    ```
    ~:docker rm {[name] or [container_id]}
    ```
    rm a container.

+ #### 3.10 search

    ```
    ~:docker search [string]
    ```
    search specified content such like tomcat or mysql in image repository.

+ #### 3.11 commit

    ```
    ~:docker commit -m="commit info" -a="author name" [container_id] [target repository name like 'repository_name:tag']
    ```
    save your changes in this container by create a new container.

+ #### 3.12 tag

    ```
    ~:docker tag [container_id] [repository_name:tag]
    ```
    create a new container by new tag.

### **4. docker arguments**

```
-t    create a terminal in the container
-i     open stdin
-d    container work in background
-p    docker run -p 5000:5000 {} {} --> mapping container port to specified host port.
-P   docker run -P {} {} --> mapping container port to random host port.
run --name     docker run --name [name] {} {} --> run a container and make a name for it.
```

### **5. `attach` the same docker terminal**

```
~:docker attach <container_id>
```
open the same terminal of a container.

### **6. ```exec``` execute another terminal**

```
~:docker exec -it <container_id> bash
```
open a new terminal of a docker container.
