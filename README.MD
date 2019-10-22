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

文章模板说明
```
---
title: 文章标题
date: 2019-07-24 16:34:53
copyright: ture
categories:
    -
tags:
    -mysql
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
