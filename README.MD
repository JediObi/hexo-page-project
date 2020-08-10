jediobi的github博客源码
使用nodejs的hexo框架搭建，新建文章和发布都在这个项目里做。
github的博客地址 https://jediobi.github.io

使用 ```Hexo``` 管理文章

(1) node环境

安装 node


全局安装 hexo-cli
```
~:npm install -g hexo-cli
```


(2) 克隆本工程

```
~:git clone https://github.com/JediObi/jediobi.github.io.git
```

(3) 新建文章

```
~:cd <project_home>
~:hexo new "article_name"
```
以上命令会在 ```source/_posts``` 目录下产生一个 ```article_name.md``` 文件

为了方便管理，文章应该被放到特定分类文件夹中，并且，应该为文章分类（categories），并打标签。

新建分类文件夹时，应该使用在 source/_posts 目录下新建

文章模板说明
```
---
title: 文章标题
date: 2019-07-24 16:34:53
copyright: ture
categories:
    -
tags:
    - mysql
---
摘要

<!--more-->

正文
```

(4) 编辑文章
test

(5) 发布文章

```
~:cd <project_home>
~:hexo g
~:hexo d
```

(6) 本地调试

```
~:hexo server
```

(7) 常见错误

hexo g 生成报错
```
Error: connect ECONNRESET
```
可能是hexo-server模块缺失，需要手动安装该模块
```
~:npm i hexo-server --save
```

## 8. next主题安装与更新

在每次重新clone或者pull之后（我每次都是clone之后删除next的.git），以下配置需要查看是否符合要求。

### 8.1 菜单栏配置

#### 8.1.1 菜单栏位置调整

位置的设定依靠主题的设定
```yml
# Schemes
#scheme: Mus
#scheme: Mist
#scheme: Pisces
scheme: Gemini
```
`Muse` 菜单栏位于每个页面的顶端
`Gemini` 菜单栏位于左侧

#### 8.1.2 菜单栏内容修改

themes/next/_config.yml
```yml
menu:  
    home: / || fa fa-home  
    #about: /about/ || fa fa-user  
    tags: /tags/ || fa fa-tags  
    categories: /categories/ || fa fa-th  
    archives: /archives/ || fa fa-archive  
    #schedule: /schedule/ || fa fa-calendar  
    #sitemap: /sitemap.xml || fa fa-sitemap  
    #commonweal: /404/ || fa fa-heartbeat
```

#### 8.1.3 允许搜索

themes/next/_config.yml
```yml
local_search:    
enable: true
```

#### 8.1.4 菜单栏装饰

+ github链接
  
themes/next/_config.yml
```yml
social:  
    GitHub: https://github.com/JediObi || fab fa-github
```

+ 头像  

themes/next/_config.yml
```yml
avatar:  
    # Replace the default image and set the url here.  
    url: /images/koala_avatar.png  
    # If true, the avatar will be dispalyed in circle.  
    rounded: false  
    # If true, the avatar will be rotated with the cursor.  
    rotated: false
```

### 8.2 去掉标题自动编号

通常我们自己会创建编号，自动编号会导致重复。
themes/next/_config.yml
```yml
toc:  
    enable: true  
    # Automatically add list number to toc.  
    number: false  
    # If true, all words will placed on next lines if header width longer then sidebar width.  
    wrap: false  
    # If true, all level of TOC in a post will be displayed, rather than the activated part of it.  
    expand_all: false  
    # Maximum heading depth of generated toc.  
    max_depth: 6
```
number这项禁用

### 8.3 底部配置

修改icon颜色，并且去掉powerd by

themes/next/_config.yml
```yml
footer:  
    # Specify the date when the site was setup. If not defined, current year will be used.  
    #since: 2015  
    # Icon between year and copyright info.  
    icon:
        # Icon name in Font Awesome. See: https://fontawesome.com/icons    
        name: fa fa-user    
        # If you want to animate the icon, set it to true.    
        animated: false    
        # Change the color of icon, using Hex Code.    
        color: "#808080"  
    # If not defined, `author` from Hexo `_config.yml` will be used.  
    copyright:  
    # Powered by Hexo & NexT  
    powered: false
```

### 8.3 数学公式mathjax
themes/next/_config.yml
```yml
math:    
    mathjax:        
        enable: true
```

### 8.4 语言

如果你之前没有为hexo指定语言，切换next可能会导致乱码，修改项目目录的 _config.yml
```yml
language: en
```

### 8.5 禁用版本校验
校验会在hexo generate触发，如果校验异常比如网络被防火墙阻挡，会导致generate命令失败

themes/next/_config.yml
```yml
reminder: false
```

