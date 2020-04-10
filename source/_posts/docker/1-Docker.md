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

    命令格式：docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

    run 命令使用镜像创建容器实例并启动，COMMAND ARGS... 表示任务和任务参数， run命令必须指定任务，但是任务可以在 dockerfile的 Cmd节点配置，所以命令行里是一个可选参数。

    `docker inspect name` 可以查看 dockerfile。

    任务中的前台任务决定了容器的运行时间。docker的机制是如果没有任何前台任务，则认为容器空闲，容器会自动exit。所以对于一些service类型的任务可能需要改到前台执行。

    自定义容器时，一般用一个空的Linux镜像，没有指定任务，为了保持容器运行，一般会指定 /bin/bash, 然后使用 -t 创建一个终端使之在前台运行，但是终端的exit命令会退出终端导致前台任务结束，容器也就停止了。所以要增加一个 -d 守护进程，退出或在后台可以继续保持前台任务执行。 -i 参数可以连接到容器的标准输入，标准输入也是一个前台任务(使用ctrl+c会退出stdin)，一般不单独用。

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
    一般用于自定义容器，对一个容器实例做的任何修改保存为一个新的image。

+ #### 3.12 tag

    ```
    ~:docker tag [repo[:tag]] [repository_name:tag]
    ```
    使用已有镜像创建一个自定义镜像，一般是使用别人的镜像 tag 出一个自己的初始镜像，然后改造。

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

### **6. `exec` execute another terminal**

```
~:docker exec -it <container_id> bash
```
open a new terminal of a docker container.
