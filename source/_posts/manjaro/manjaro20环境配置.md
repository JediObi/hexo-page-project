---
title: manjaro20环境配置
copyright: true
date: 2020-08-09 03:01:40
mathjax: true
categories:
    - manjaro
tags:
    - arch
    - linux
    - tensorflow
    - cuda
    - win7
---
manjaro20的安装与开发环境搭建。安装过程中比较麻烦的是与win7组双系统的设置问题。

<!-- more -->

## 1. 安装

### 1.1 独立安装

+ u盘制作

`utralISO`或者`rufus`，U盘格式化为`fat32`，使用`raw`格式写入镜像，成功后U盘的大多数空间会被隐藏，通过磁盘管理工具分配盘符即可使用。

+ bios模式

    `UEFI`

+ 系统盘分区表

    GPT或MBR都可以

+ 分区
```yaml
分区1:
    说明: grub启动分区
    容量: 1GB
    格式: fat32
    挂载点: 无
    Flags:
        - boot
分区2:
    说明: 交换分区，与内存等量或稍小
    容量: 8GB
    格式: linuxswap
    挂载点: 无
    Flags:
        - swap
分区3:
    说明: 系统分区
    容量: 50GB
    格式: ext4
    挂载点: /
    Flags:
        - 无
分区4:
    说明: home分区目录
    容量: 一般是系统盘剩余空间
    格式: ext4
    挂载点: /home
    Flags:
        - 无
```
系统安装到`分区1`

### 1.2 双系统安装

#### 1.2.1 win7 + manjaro20

manjaro的系统盘分区表和分区可以参考`独立安装`的分区，不过`分区1grub启动分区要特别注意下`
```yaml
分区1:
    说明: grub启动分区
    容量: 1GB
    格式: fat32
    挂载点: 无
    Flags:
        - boot
        - legacy-boot
```
+ win7遇到的问题
  
    (1) `win7`仅支持`legacy`或`uefi+csm`的bios。如果uefi主板不支持csm，则uefi模式下安装完win7会导致第一次启动卡在启动界面，此时需要修改bios为legacy模式（或开启旧支持），然后启动win7安装完显卡驱动即可把主板改回uefi(或关闭旧支持)。
<br>
+ 启动项改为grub
    (1) grub要求bios为uefi模式。
  
    (2) 安装完win7后默认的启动项为`windows boot manager`，很多教程`错误`的推荐用`easyBCD`去增加grub启动项，实际上增加的启动项会出现在`win boot manager`的列表中，该选项实际上无法启动linux，`在win boot manager界面选择退出（esc按键退出）会回到grub`。虽然可以返回到grub，但很不友好，可以在bios里修改启动顺序把grub改为第一个，`注意，由于win7每次启动会修改win boot manager为第一启动项，所以要在bios里禁用win boot manager`。


#### 1.2.2 win10 + manjaro20

```yml
bios: uefi
manjaro安装: 完全按照独立安装的来
```
## 2. 系统定制

### 2.1 首先配置镜像

`/etc/pacman.d/mirrorlist`
```conf
## Country : China
Server = http://mirrors.aliyun.com/manjaro/stable/$repo/$arch
```

### 2.2 zsh

manjaro自带zsh和一些插件，但是没有安装oh-my-zsh，也没有配置p10k主题，所以安装下oh-my-zsh和p10k即可。

#### 2.2.1 安装oh-my-zsh

克隆github的oh-my-zsh到你的家目录,重命名为.oh-my-zsh，可以用gitee加速。
然后把 .oh-my-zsh/templates/zshrc.zsh-template 复制到家目录/.zshrc 即可

#### 2.2.2 安装p10k

克隆该仓库powerlevel10k，可以用gitee加速，到.oh-my-zsh/custom/themes/powerlevel10k。然后在.zshrc总修改主题。

```conf
ZSH_THEME="powerlevel10k/powerlevel10k"
```

p10k配置完之后，首次启动zsh，会引导p10k配置，如果未来想重新配置可用命令：`p10k configure`

#### 2.2.3 安装其他插件

+ git插件

    该插件可以用来提示git分支和分支状态

+ 自动提示插件

    该插件可以根据输入历史自动补齐命令

```conf
plugins=(git colored-man-pages zsh-autosuggestions)
```
其中git和man插件由oh-my-zsh自带，自动补齐插件需要自行下载到.oh-my-zsh/plugins/zsh-autosuggestions

#### 2.2.4 history时间戳
```conf
HIST_STAMPS="yyyy-mm-dd"
```
### 2.3 neovim

neovim是vim的一个分支，界面更友好，使用异步模块。使用spacevim可以一站式配置vim/neovim的插件和界面。

#### 2.3.1 安装neovim

可以使用命令行安装，但是可能安装完之后没有自动生成vim软连接，自行配置下。

#### 2.3.2 安装spacevim

+ 安装spacevim
这个插件通过一个shell脚本安装，该脚本主要是从github下载spacevim的插件和依赖，spacevim在国内有gitee的库，所以可以把脚本里的仓库地址修改为国内镜像，至于依赖可能没有国内仓库，自行clone。
<br>
+ 配置spacevim
  spacevim可以配置很多地方，但最常用的是主题，代码补齐，git插件，至于状态栏使用默认的即可。

  主题需要启用主题模块才能在options里修改，代码补齐需要补齐模块，自带的git插件ginna由于有bug所以用fugitive，demo如下
```conf
#=============================================================================
# dark_powered.toml --- dark powered configuration example for SpaceVim
# Copyright (c) 2016-2017 Wang Shidong & Contributors
# Author: Wang Shidong < wsdjeg at 163.com >
# URL: https://spacevim.org
# License: GPLv3
#=============================================================================

# All SpaceVim option below [option] section
[options]
    # set spacevim theme. by default colorscheme layer is not loaded,
    # if you want to use more colorscheme, please load the colorscheme
    # layer
    colorscheme = "gruvbox"
    colorscheme_bg = "dark"
    # Disable guicolors in basic mode, many terminal do not support 24bit
    # true colors
    enable_guicolors = true
    # Disable statusline separator, if you want to use other value, please
    # install nerd fonts
    statusline_separator = "arrow"
    statusline_inactive_separator = "arrow"
    buffer_index_type = 4
    enable_tabline_filetype_icon = true
    enable_statusline_mode = false

# Enable autocomplete layer
[[layers]]
name = 'autocomplete'
auto_completion_return_key_behavior = "complete"
auto_completion_tab_key_behavior = "smart"

[[layers]]
name = 'shell'
default_position = 'top'
default_height = 30

[[layers]]
name = 'VersionControl'

[[layers]]
name = 'git'
git-plugin = 'fugitive'
```

### 2.3 chrome浏览器

#### 2.3.1 安装chrome

```
~:sudo pacman -S google-chrome
```

#### 2.3.2 安装vim插件

vimium插件可以从商店获取，但国内无法访问商店，可以从源码编译安装，vimium源码是nodejs项目，所以可以在系统配置了node之后，再来做这一步。

vimium github地址，可以clone到gitee上加速
```
https://github.com/philc/vimium.git
```

进入该项目执行build
```
~:cd vimium
~:./make.js build
```
然后在chrome 插件界面打开开发模式，然后pack extension，选择vimium文件夹打包即可，会在vimium同级目录生成插件和签名文件，插件拖动到chrome里即会自动安装。

### 2.4 搜狗输入法

在manjaro20的仓库里已经没有了fcitx-sogoupinyin这个包，但是有同学打包了ubuntu-kylin里的企业版到github上项目名称为`fcitx-sogouimebs`，下载arch的包在本地用pacman安装即可。

github地址
```
https://github.com/laomocode/fcitx-sogouimebs.git
```
本地安装
```
~:sudo pacman -U fcitx-sogouimebs.pkg.tar.xz
```

## 3. JAVA环境配置

比较简单由于使用了openjdk14，所以顺便用openj9虚拟机替代hotspot

主要配置下java和maven的环境变量
```conf
JAVA_HOME=xxx
MAVEN_HOME=xxx
PATH=${PATH}:${JAVA_HOME}/bin:${MAVEN_HOME}/bin
export PATH
```

顺道配置下maven本地仓库

+ 在/home/username/.m2/ 下复制 maven_home/conf/settings.xml，指定仓库地址和镜像地址
```xml
...
<localRepository>/home/nomq/work/repo</localRepository>
...
<mirror>
    <id>aliyun</id>
    <mirrorOf>central</mirrorOf>
    <name>aliyun</name>
    <url>http://maven.aliyun.com/nexus/content/repositories/central/</url>
</mirror>
...
```

## 4. JS环境配置

### 4.1 nvm和node安装

使用nvm配置node12的环境，nvm可以方便的管理多版本的node，并且自由切换版本。

首先下载nvm安装脚本

然后安装node，配置npm国内镜像

### 4.2 此处简单介绍下hexo的配置

因为之前配置了hexo，next主题，但是没有做任何记录，本次因为配置hexo实际上是next主题的mathjax支持，所以记录下。

hexo自带的公式渲染工具 hexo-render-marked由于存在一些配置问题，要使用 hexo-render-kramed替换
```
~:npm un -S hexo-render-marked
~:npm i -S hexo-render-kramed
```
开启next对mathjax的支持，其中公式引擎默认是mathjax，可以用但是引用的js文件可以改为cloudflare，国内更快。
${project_root}/themes/next/_config.yml
```
math:
    enable: true
```

开启该支持后，文章的头部需要添加`mathjax: true`才会渲染，当然也可以修改next配置文件默认所有文章渲染。比如以下：
```yml
title: manjaro20环境配置
copyright: true
date: 2020-08-09 03:01:40
mathjax: true
categories:
    - manjaro
tags:
    - arch
    - linux
    - tensorflow
    - cuda
    - win7
```
接下来是一个行公式展示：
$$
\begin{aligned}
    \vec{A}\vec{v} = \lambda\vec{v}
\end{aligned}
$$

## 5. python环境配置

主要是开发工具和tensorflow以及cuda的配置

### 5.1 环境配置

环境配置主要是指pip，需要配置下pip的国内镜像，在/home/username/.pip/pip.conf
```conf
[global]
index-url=https://mirrors.aliyun.com/pypi/simple/
trusted-host=https://mirrors.aliyun.com/pypi/simple/
```

### 5.2 开发工具

如果有kite，可以使用vscode就行了，一般早上可能网速好能下载到kite。
没有kite就用pycharm。

### 5.2 tensorflow
```
~:pip install tensorflow
```
tensorflow-2.3.0 支持cuda10.1和cudnn7，在nvidia相关配置里会说明。

### 5.3 nvidia驱动和cuda

manjaro20的软件仓库已经把cuda更新到了10.2，cudnn-8，所以tensorflow无法使用GPU，目前仓库没有降级版本，只能从nvidia官网下载指定版本，速度还很快的。

cuda `https://developer.nvidia.com/cuda-downloads` 选择`Legacy Releases`会跳转到其他版本选择页，选择10.1最新的版本是update2，系统是Linux-Unbuntu-18.04-runfile(local)，这是个run文件，arch也可以使用的。
下载完成后，执行`sudo sh cuda_10.1.243_418.87.00_linux.run`安装，会跳出选择界面，注意cuda10.1需要nvidia驱动418，高于这个版本需要先降级。之后应该会安装成功，但是cuda相关的命令比如nvcc还不能用，按照安装完成的提示，把cuda的bin目录添加到path即可。至于library路径，已经自动添加到/etc/ld.so.conf，后边添加cudnn到cuda时，需要`sudo ldconfig`来更新下。
```
```
cudnn，链接地址 `https://developer.nvidia.com/cudnn`，需要登录之后才能选择下载，在下载页选择`Archived cuDNN Releases`才能展示出旧版本，然后选择for cuda10.1，之后直接选择`cuDNN Library for Linux`，这是个压缩包，需要手动解压和配置。

解压之后的目录名也叫cuda，把该目录下的头文件和so文件复制到cuda的安装目录即可
```
# cuda 安装目录 /usr/local/cuda-10.1/
# cudnn 解压目录 /home/username/cuda
~:sudo cp ~/cuda/include/cudnn.h /usr/local/cuda-10.1/include/
~:sudo cp ~/cuda/lib/libcudnn* /usr/local/cuda-10.1/lib/
```
由于 cudnn的lib目录有软链接，所以在cuda里也要重建下
```
lrwxrwxrwx 1 user user   13 10月 28  2019 libcudnn.so -> libcudnn.so.7
lrwxrwxrwx 1 user user   17 10月 28  2019 libcudnn.so.7 -> libcudnn.so.7.6.5
-rwxr-xr-x 1 user user 409M 10月 28  2019 libcudnn.so.7.6.5
-rw-r--r-- 1 user user 386M 10月 28  2019 libcudnn_static.a
```
按照这个关系重建即可，附加说明下在cudnn-8里，lib目录多出了两个其他的so文件，也是要重新配置软链接的。