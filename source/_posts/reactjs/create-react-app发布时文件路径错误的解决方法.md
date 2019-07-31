---
title: create-react-app发布时文件路径错误的解决方法
copyright: true
date: 2019-07-31 18:53:21
categories:
    - reactjs
tags:
    - reactjs
---

在工程的依赖文件package.json的根节点里添加一个元素如下

```

"homepage":"./",

```

在打包时自动为页面文件添加工程根目录。
