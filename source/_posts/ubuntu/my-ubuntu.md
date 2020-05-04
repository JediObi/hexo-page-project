---
title: my ubuntu
copyright: true
date: 2019-07-29 10:02:28
categories:
    - ubuntu
tags:
    - ubuntu
---
本文介绍了ubuntu18的安装，报货单系统安装， 以及和win10并存的双系统安装。        
一些常用的界面美化配置和常用软件，以及开发环境的安装。

<!-- more -->

### **1. Install Ubuntu 16.04 x64 under UEFI**

#### **1.1 windows uefi install ubuntu**

##### **1.1.1 BIOS settings**

+ ###### 1. disable secure boot
+ ###### 2. usb bootstrap

##### **1.1.2 reboot and install**

+ ###### 1. install ubuntu
+ ###### 2. partition

    ```
    efi or biosgrub 1G
    /	 50G
    swap	 8G
    /home	 70G
    ```

+ ###### 3. install to biosgrub

+ ###### 4. high resolution of grub2
  
    sudo vim /etc/default/grub
    ```
    GRUB_TERMINAL=gfxterm
    GRUB_GFXMODE=1920x1080
    ```
    sudo update-grub
    reboot

#### **1.2 ubuntu only**

+ ###### 1. bios->secure boot disable, bios->boot uefi only

+ ###### 2. partition
  
    ```
    efi partition 1G
    /	 50G
    swap	 8G
    /home	 70G
    ```

+ ###### 3. install to efi partition

### **2. Install Softwares**

#### **2.1 oh my zsh**

+ ###### 1. install zsh
  
    `~:sudo apt-get install zsh`
    init zsh config
    `~:zsh`
    change to zsh,no sudo
    `~:chsh -s /bin/zsh`

+ ###### 2. install git

    `~:sudo apt-get install git`
    clone oh my zsh
    `~:git clone git://github.com/robbyrussell/oh-my-zsh.git`
    cp oh my zsh config to zsh
    `~:cp ~/oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc`
    install oh my zsh
    `~:cd oh-my-zsh/tools`
    `~:./install.sh`
    `~:reboot`

+ ###### 3. powerline

  + install pip

    ```
    ~:sudo apt-get install python3-pip
    ~:mkdir .pip
    ~:vim .pip/pip.conf
    [global]
    timeout = 6000
    index-url = https://pypi.tuna.tsinghua.edu.cn/simple
    trusted-host = pypi.tuna.tsinghua.edu.cn
    ```

  + install powerline (not necessary)

    ```
    #~:sudo apt-get install powerline
    #~:pip3  install powerline-status
    #~:sudo pacman -S powerline
    #~:sudo pacman -S powerline-fonts
    #~:sudo pacman -S powerline-vim
    ```
    
  + install powerline for zsh

    zsh install powerlevel9k plugin
    ```
    ~:cd ~/.oh-my-zsh/custom/themes
    ~:git clone https://github.com/bhilburn/powerlevel9k.git
    ~:cd ~
    ~:vim .zshrc

    ZSH_THEME="powerlevel9k/powerlevel9k"
    ```
    source .zshrc

  + zsh history time stamp

    .vimrc
    ```
    HIST_STAMPS="mm/dd/yyyy"
    ```

  + install gnome-tweak

  + install dash to dock

  + install powerline for vim

    **==>** download powerline fonts 
    `https://github.com/powerline/fonts`
    ```
    ~:cd /user/share/fonts
    ~sudo :mkdir myfonts
    ~:cd myfonts
    ~:sudo  cp ~/Download/Noto Mono for Powerline.ttf ./
    ~:sudo mkfontscale
    ~:sudo mkfontdir
    ~:sudo fc-cache -fv
    ```
    **==>** install vundle plugin
    ```
    ~: cd .vim/bundle
    ~:git clone https://github.com/VundleVim/Vundle.vim.git
    ~:cd ~
    ~:vim .vimrc


    set nocompatible              " be iMproved, required
    filetype off                  " required

    " set the runtime path to include Vundle and initialize
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
    " alternatively, pass a path where Vundle should install plugins
    "call vundle#begin('~/some/path/here')

    " let Vundle manage Vundle, required
    Plugin 'VundleVim/Vundle.vim'

    " The following are examples of different formats supported.
    " Keep Plugin commands between vundle#begin/end.
    " plugin on GitHub repo
    Plugin 'tpope/vim-fugitive'
    " plugin from http://vim-scripts.org/vim/scripts.html
    " Plugin 'L9'
    " Git plugin not hosted on GitHub
    Plugin 'git://git.wincent.com/command-t.git'
    " git repos on your local machine (i.e. when working on your own plugin)
    Plugin 'file:///home/gmarik/path/to/plugin'
    " The sparkup vim script is in a subdirectory of this repo called vim.
    " Pass the path to set the runtimepath properly.
    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
    " Install L9 and avoid a Naming conflict if you've already installed a
    " different version somewhere else.
    " Plugin 'ascenator/L9', {'name': 'newL9'}

    Plugin 'vim-airline/vim-airline'

    " All of your Plugins must be added before the following line
    call vundle#end()            " required
    filetype plugin indent on    " required
    " To ignore plugin indent changes, instead use:
    "filetype plugin on
    "
    " Brief help
    " :PluginList       - lists configured plugins
    " :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
    " :PluginSearch foo - searches for foo; append `!` to refresh local cache
    " :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
    "
    " see :h vundle for more details or wiki for FAQ
    " Put your non-Plugin stuff after this line
    ```
    ```
    ~:vim

    :PluginInstall
    ```
    ```
    ~:vim .vimrc


    let g:airline_powerline_fonts = 1
    ```

  + install powerline for vscode

    You have installed mono for powerline fonts before. Now change settings for vscode.
    ```
    ctrl+shift+p=>open user settings
    setting.json => "terminal.integrated.fontFamily": "Noto Mono for Powerline"
    ```


#### **2.2 vim**

+ ##### 1. install

    `~:sudo apt-get install vim`

#### **2.3 sogou input**

+ ##### 1. install fcitx

    `1) system setting->language support`
    `2) change keyboard input method system`
    `3) choose fcitx`

+ ##### 2. install sogou input

    `~:sudo dpkg -i sogou.deb`
    If dependencies error occured, force install
    `~:sudo apt-get -f install`
    restart system
    `~:reboot`
    change language at status bar
    **Note:** Ubuntu 18.04 configure input method at keyboard icon.

#### **2.4 theme and icons**

+ ##### 1. install unity-tweak-tool

    `~:sudo apt-get install unity-tweak-tool`
    **Note:** workspace in unity-tweak-tool didn't work on Ubuntu 18.04.

+ ##### 2. install numix icon-theme-circle

    `~:sudo add-apt-repository ppa:numix/ppa`
    `~:sudo apt-get update`
    **Note:** maybe you need to reboot system or you can't tab for numix-icon-theme-circle
    `~:sudo apt-get install numix-icon-theme-circle`

    If ppa is not available,
    install manually:
    icons:
    ```
    # folder icons soft link source
    ~:git clone https://github.com/numixproject/numix-icon-theme.git
    ~:sudo cp -r numix-icon-theme/Numix /usrshar/icons
    ~:git clone https://github.com/numixproject/numix-icon-theme-circle.git
    ~:sudo cp -r numix-icon-theme-circle/Numix-Circle /usr/share/icons
    ```
    change folder icon color
    ```
    ~:~:git clone https://github.com/numixproject/numix-folders.git
    ~:cd numix-folders
    ~:sudo ./numix-folders
    ```
    You can config colors yourself in README.MD

+ ##### 3. install arc--theme

    `~:sudo apt-get install arc-theme`

    install manually:
    ```
    ~:git clone https://github.com/horst3180/arc-theme.git
    ~:./autogen.sh --prefix=/usr
    ~:sudo make install
    ```
    more info on github.

+ ##### 4. install  papirus-icon-theme

    ```
    sudo add-apt-repository ppa:papirus/papirus
    sudo apt-get update
    sudo apt-get install papirus-icon-theme
    ```

    If ppa is not available,
    install manually:
    ```
    ~:git clone https://github.com/PapirusDevelopmentTeam/papirus-icon-theme.git
    ~:sudo cp -r Papirus-Dark /usr/share/icons
    ```

#### **2.5 lantern**

+ ##### 1. download lantern

+ ##### 2. install

    `~:sudo dpkg -i lantern.deb`

#### **2.6 chrome**

+ ##### 1. download chrome dev

+ ##### 2. install chrome

    `~:sudo dpkg -l chrome.deb`
    **Note:** dependencies error, command instead with
    `~:sudo apt-get -f install`

+ ##### 3. plugins need lantern

+ ##### 4. `Advanced Rest Client` restful client

    install from source
    **==>**
    ```
    ~:git clone https://github.com/advanced-rest-client/arc-electron.git
    ~:cd arc-electron
    ~:npm i
    ```
    **<==**

+ ##### 5. `vimium` vim 

    Install from source
    **==>** build
    ```
    ~:git clone https://github.com/philc/vimium.git
    ~:sudo npm install -g coffeescript@1.12.7
    ~:cd vimium
    # 2020-04-04 更新,构建脚本已经改变,依托与coffeescirpt 1.x, 然后直接使用目录中的js脚本构建
    # ~:cake build
    ~:./make.js build
    ```
    chrome浏览器开启开发者模式,然后把 build过的 vimium文件夹打包成插件,然后拖动到chrome里安装.
    chrome developer mode **==>** package the directory into an extension and install 
    **<==**

+ ##### 6. React Developer Tool

    install from source
    **==>**
    ```
    ~:git clone https://github.com/facebook/react-devtools.git
    ~:cd react-devtools
    ~:npm i
    ~:npm run build:extension:chrome
    ```
    shells/chrome/build/unpacked
    **<==**

+ ##### 7. `fehelper` json format

+ ##### 8. `qrcode`

#### **2.7 vsftpd**

ftp server

+ ##### 1. install

    `~:sudo apt-get install vsftpd`

+ ##### 2. add user

    create root dir for this user
    `~:sudo makdir -p /home/ftp`
    add new user and specify root dir
    `~:sudo useradd -d /home/ftp -s /bin/bash my_ftp`
    set password for new user
    `~:sudo passwd my_ftp`

+ ##### 3. vsftpd config

    `~:sudo vim /etc/vsftpd.conf`
    when userlist_enable=YES and userlist_deny=NO, ftp will only acccpt users in userlist file, and will eject users in /etc/ftpusers.
    ```conf
    # enable userlist
    # ftp server will only accept connections from users who are in userlist file
    userlist_enable=YES
    # close userlist deny
    userlist_deny=NO
    # figure list file
    userlist_file=/etc/vsftpd_allowed_users
    # close sandbox
    seccomp_sandbox=NO
    ```
    add user to userlist file
    `~:sudo vim /etc/vsftpd_allowed_users`
    ```
    my_ftp
    ```
    eject users
    `~:sudo vim /etc/ftpusers`

#### **2.8 nginx**

##### **2.8.1 install dependencies**

+ ###### 1. install openssl

    `~:sudo apt-get install oepnssl`

+ ##### 2. install pcre

    `~:sudo apt-get install libpcre3 libpcre3-dev`

+ ##### 3. install zlib

    `~:sudo apt-get install zlib1g-dev`

##### **2.8.2 install nginx**

+ ###### 1. download nginx

+ ###### 2. unzip and cd in

+ ###### 3. configure and specify a dir for install

    `~:./configure --prefix=/usr/local/bin/nginx`

+ ###### 4. make code

    `~:make`

+ ###### 5. install

    `~:sudo make install`

+ ###### 6. test

    `~:cd /usr/local/bin/nginx/sbin`
    `~:sudo ./nginx`
    http://localhost-->welcome to nginx!

##### **2.8.3 an nginx exmple -- image server**

+ ###### 1. add a server node in `nginx.conf` http node

    `~:cd /usr/local/bin/ginx/conf`
    `~:sudo vim nginx.conf`
    ```conf
        server {
            listen       80;
            server_name  img.mall.com;
        
            location / {
                root   D:/ftp/img/;
                index  index.html index.htm;
            } 
        }
    ```

+ ###### 2. specify the website to local ip

    `~:sudo vim /etc/hosts`
    ```
            127.0.0.1	img.mall.com
    ```

#### **2.9 status bar indicator-sysmonitor**

+ ##### 1. install

    `~:sudo add-apt-repository ppa:fossfreedom/indicator-sysmonitor`
    `~:sudo apt-get update`
    `~:sudo apt-get install indicator-sysmonitor`
    `~:indicator-sysmonitor`

#### **2.10 mysql mariadb 10.2 stable**

**use these commands to specify the version**
**Note:** Ubuntu 18.04
Any problems please see other topics of mysql( or mariadb ) in my blog.

```
~:sudo apt-get install software-properties-common
~:sudo apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
~:sudo add-apt-repository 'deb [arch=amd64] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.3/ubuntu bionic main'
~:sudo apt update
~:sudo apt install mariadb-server
```

#### **2.11 mysql workbench**

+ ##### 1. install

    `~:sudo apt-get install mysql-workbench`

#### **2.12 jdk8**

+ ##### 1. install

    `~:sudo tar xzvf jdk8.tar.gz -C /usr/local/lib`

+ ##### 2. environment variables

    `~:sudo vim /etc/profile`
    ```
    JAVA_HOME=/usr/local/lib/jdk1.8.0_121
    JRE_HOME=${JAVA_HOME}/jre
    CLASSPATH=.:${JAVA_HOME}/lib:${JRE_HOME}/lib
    PATH=${JAVA_HOME}/bin:$PATH
    export PATH JAVA_HOME CLASSPATH
    ```
    or
    ```
    export JAVA_HOME=/usr/local/lib/jdk1.8.0_121
    export CLASSPATH=.:${JAVA_HOME}/lib:${JAVA_HOME}/jre/lib
    export PATH=${JAVA_HOME}/bin:$PATH
    ```

    config system alternatives -> some applications will use alternative command only,such like fabric.
    ```
    ~:sudo update-alternatives –install /usr/local/bin/java java [your_java_home]/bin/java 0
    ~:sudo update-alternatives –install /usr/local/bin/javac javac [your_java_home]/bin/javac 0

    ~:update-alternatives --display java
    ```

+ ##### 3. reboot system

+ ##### 4. test

	java -version

#### **2.13 maven 3.5.0**

+ ##### 1. install

    `~:sudo tar xzvf apache-maven.tar.gz -C /usr/local/bin`

+ ##### 2. environment variables

    `~:sudo vim /etc/profile`
    ```
    MAVEN_HOME=/usr/local/bin/apache-maven-3.5.0
    PATH=${MAVEN_HOME}/bin:${PATH}
    export PATH
    ```

+ ##### 3. reboot system

#### **2.14 netease-cloud-music.deb**

#### **2.15 idea.tar.gz**

#### **2.16 termius**

+ ##### 1. install `snapd` and dependencies

    `~:sudo apt install snapd`
    `~:sudo apt install pulseaudio`
    `~:sudo apt install snapd-xdg-open`

+ ##### 2. use snapd to insall termius

    show if there's termius-app
    `~:snap find termius`
    install termius
    `~:sudo snap install termius-app`

+ ##### 3. create desktop if it is necessary.

    application
    `~:sudo cp /snap/termius-app/current/meta/gui/termius.desktop /usr/share/applications`
    icon
    `~:sudo vim /usr/share/applications/termius.desktop`

#### **2.17 filezilla**

+ ##### 1. install

    `~:sudo apt-get install filezilla`

#### **2.18 shutter**

+ ##### 1. install

    `~:sudo apt-get install shutter`

+ ##### 2. shotcut

    ```
    keyboard:ctrl+alt+a -> shutter -s
    ```

#### **2.19 gcc g++**

+ ##### 1. install

    ```
    ~:sudo apt-get install build-essential
    ~:sudo apt-get install g++-8
    ```

#### **2.20 cmake**

+ ##### 1. download cmake.tar.gz

+ ##### 2. unzip

+ ##### 3. make soft link

    ```
    ~:sudo ln -s cmake_home/bin/cmake /usr/local/bin/cmake
    ```

#### **2.21 nodejs**

+ ##### 1. download cmake.tar.xz

+ ##### 2. unzip

+ ##### 3. make soft link

    ```
    ~:sudo ln -s node_home/bin/node /usr/local/bin/node
    ~:sudo ln -s node_home/bin/npm /usr/local/bin/npm
    ```

+ ##### 4. use taobao mirror

    ```
    ~:npm config get registry
    ~:npm config set registry "https://registry.npm.taobao.org"
    ```

#### **2.22 vscodes**

+ ##### 1. install

    ```
    ~:sudo dpkg -i vscode.deb
    ```

+ ##### 2. install plug-in

    [插件目录](https://www.jianshu.com/p/3041871f6024)

#### **2.23 Ubuntu 18 nvidia driver**

    ```
    ~:sudo ubuntu-drivers autoinstall
    ```
    This could stop the fan noise.
