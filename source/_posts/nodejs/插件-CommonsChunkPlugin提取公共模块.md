---
title: 插件--CommonsChunkPlugin提取公共模块
copyright: true
date: 2019-07-31 12:19:42
categories:
    - node
    - webpack
tags:
    - node
    - webpack
---
webpack插件。

<!-- more -->

webpack的一个插件，需要在配置文件的plugin节点配置
作用：
(1)提取各个js里共同的require对象，优化加载速度
(2)某个entry不生成js，但需要打包进最终的js
