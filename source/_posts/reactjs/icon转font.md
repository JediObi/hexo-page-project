---
title: icon转font
copyright: true
date: 2019-07-31 18:48:25
categories:
    - reactjs
tags:
    - reactjs
    - svg
---
css中引用svg字体。

<!-- more -->

从阿里矢量图标库可以获取四种通用字体，这里以unicode引用为例。
在svg中可以看到font的unicode码，不过这是一个十进制码，像这样“&#xxx;”，xxx是十进制。
在css中使用font-family指定字体后，在content里需要用十六进制的unicode，像这样“\uyyy”。\u是unicode格式声明就像上文“&#xxx;”中的“&#;”，yyy是上文“&#xxx;”中xxx的十六进制。