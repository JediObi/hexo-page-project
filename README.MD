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
