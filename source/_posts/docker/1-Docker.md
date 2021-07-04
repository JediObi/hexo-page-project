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
镜像管理和容器管理。

<!-- more -->

### **1. docker 安装**

```
~:wget -qO- https://get.docker.com/ | sh
~:sudo usermod -aG docker user_group
~:reboot
~:sudo service docker start
~:docker run hello-world
```

```
# 帮助
~:docker [command] --help
```

### **2. docker 镜像管理**

 + #### 2.1 镜像加速 /etc/docker/daemon.json

    ```json
    {
    "registry-mirrors": ["http://hub-mirror.c.163.com"]
    }
    ```


+ #### 2.2 下载镜像 pull
    ```
    ~:docker pull [repository]
    ```
    pull a repository image.

+ #### 2.3 列出本地镜像 images

    ```
    ~:docker images
    ```
    list the images in this computer.


+ #### 2.4 搜索远程仓库镜像 search

    ```
    ~:docker search [string]
    ```
    search specified content such like tomcat or mysql in image repository.

+ #### 2.5 镜像重命名 tag

    ```
    ~:docker tag [repo[:tag]] [repository_name:tag]
    ```
    使用已有镜像创建一个自定义镜像，一般是使用别人的镜像 tag 出一个自己的初始镜像，然后改造。
    比如 k8s，基础组件包含好几个镜像，但是google的镜像下载速度太慢了，我们就下载国内的镜像，但是国内镜像的名称和原版不同，而k8s组件镜像之间互相依赖，名称必须是google定的那几个名字，所以国内镜像下完之后用tag重命名下。

+ #### 2.6 以当前容器为模板创建镜像 commit

    ```
    ~:docker commit -m="commit info" -a="author name" [container_id] [target repository name like 'repository_name:tag']
    ```
    save your changes in this container by create a new container.
    一般用于自定义镜像，以当前容器为模板创建一个镜像。

+ #### 2.7 检查镜像

    ```
    ~:docker inspect image_name
    ```
    用于查看镜像的配置内容，大致可以看出dockerfile的配置

+ #### 2.8 删除镜像

    ```
    ~:docker rmi [image_id or image_gor]
    ```
    按照id或坐标(name:tag)删除镜像。

### **3. docker 容器管理**

+ #### 3.1 创建容器 run 命令

    ```
    ~:docker run -itd --name ubuntu-test -v /etc/localtime:/etc/localtime:ro ubuntu:15.10 /bin/echo "Hello world"
    ```
    run `ubuntu:15.10` and use `/bin/echo` to print "Hello world".

    命令格式：docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

    run 命令使用镜像创建容器实例并启动，COMMAND ARGS... 表示任务和任务参数， run命令必须指定任务，但是任务可以在 dockerfile的 Cmd节点配置，所以命令行里是一个可选参数。

    `docker inspect name` 可以查看 dockerfile。

    ps: 
    任务中的前台任务决定了容器的运行时间。docker的机制是如果没有任何前台任务，则认为容器空闲，容器会自动exit。所以对于一些service类型的任务可能需要改到前台执行。

    自定义容器时，一般用一个空的Linux镜像，没有指定任务，为了保持容器运行，一般会指定 /bin/bash, 然后使用 -t 创建一个终端使之在前台运行，但是终端的exit命令会退出终端导致前台任务结束，容器也就停止了。所以要增加一个 -d 守护进程，退出或在后台可以继续保持前台任务执行。 -i 参数可以连接到容器的标准输入，标准输入也是一个前台任务(使用ctrl+c会退出stdin)，一般不单独用。

    + 指定网络
  
    run ... --network=网络名称

    + 指定ip
    在网络限定的ip段内指定

    run ... --ip 172.17.0.3

+ #### 3.2 容器进程管理 ps 命令

    ```
    ~:docker ps
    ```
    列出正在运行容器

    ```
    ~:docker ps -a
    ```
    列出所有所有容器

+ #### 3.3 查看容器日志 logs 命令

    ```
    # 打印容器日志
    ~:docker logs {name[or container_id]}
    ```
    ```
    # 动态打印容器日志，就像 tail -f
    ~:docker logs -f {}

    ```

+ #### 3.4 停止容器 stop 命令

    ```
    ~:docker stop {name[or container_id]}
    ```

+ #### 3.5 打印容器端口映射关系 port

    ```
    ~:docker port {[name] or [container_id]} {[null] or [container port]}
    ```
    print the port mapping of a container.

+ #### 3.6 删除容器 rm

    ```
    ~:docker rm {[name] or [container_id]}
    ```
    rm a container.

+ #### 3.7 连接容器的输出终端 attach

    ```
    ~:docker attach <container_id>
    ```
    这个用于连接创建容器时打开的终端

+ #### 3.8 连接容器并新建终端 `exec` execute another terminal

    ```
    ~:docker exec -it <container_id> bash
    ```
    open a new terminal of a docker container.

+ #### 3.9 检查容器 inspect

    ```
    ~:docker inspect [container_id or container_name]
    ```
    用于查看容器的一些属性，比如创建(run)时的一些参数(比如mysql的密码)，比如容器的网络地址等。


### **4. 网络管理**


+ #### 4.1 查看所有网卡

    `docker network ls`

+ #### 4.2 查看网卡配置，比如bridge

    `docker network inspect bridge`

    docker有四中网络模式(driver)

    host模式, run --net=host, 容器与宿主机共享网络，你看到的将是宿主机的网络配置

    container, run --net=容器id, 使用另一个宿主机的网卡配置

    none, run --net=none, 容器自有配置，没用过

    bridge, run --net=bridge, 默认的，桥接模式

    这四个模式(driver)是默认存在的，docker默认创建了四中模式同名的network。我们自行创建的网络也是要以这四个driver的一个作为driver。




+ #### 4.3 创建网络

`docker network create --driver bridge --subnet=172.18.0.0/16 --gateway=172.18.0.1 mynet`

创建一个bridge模式的网络
    网络模式在上一节介绍过
网络名称mynet
子网段 172.18.0.0/16
    要指定网段和掩码
网关 172.18.0.1

### **5. 轻量级linux镜像 alpine**


### **6. 注意**

#### 6.1 禁止套娃：容器不能二次虚拟化，所以在容器中无法再次启动docker容器。如果有这种特殊的需求，可以使用 docker in docker 镜像，对应的仓库是 docker-dind


#### 6.2 权限设置
docker 守护进程默认只开启了 unix socket 监听，对应的进程文件为 /var/run/docker.sock，当然你也可以在service文件里修改。默认的这个文件归属于docker用户组和超级用户，普通用户组没有权限操作这个文件，所以普通用户需要添加到docker组。

可能系统默认不开启docker，开启之后会影响性能尤其是安装了k8s之后，所以可能需要手动开启docker进程。

+ 命令：添加到docker用户组
```
~:sudo gpasswd -a user_name docker
```

+ 权限生效，命令或重启电脑
```
# 刷新用户组，只对当前会话有效
~:newgrp docker
```

+ 命令：从docker用户组删除用户
```
~:sudo gpasswd -d user_name docker
```

docker也支持tcp监听，本地测试不需要开启。在service里配置，一般开启远程就是指开启tcp监听，如果需要在远程服务器上上传镜像，一般是需要开启这个的。

#### 6.3 linux上的用户界面 cockpit

manajro 安装cockpit，然后在启动`systemctl start cockpit`。

然后打开浏览器`https://localhost:9090`，用户名与密码就是当前系统的用户名和密码，可以方便的管理容器。

