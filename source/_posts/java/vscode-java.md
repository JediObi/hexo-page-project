---
title: vscode-java
copyright: true
mathjax: false
date: 2021-04-27 22:46:13
categories:
    - java
tags:
    - java
    - vscode
    - ide
---
本文介绍vscode开发java的常用配置

<!-- more -->

### 1. 插件配置要求

language-server 要求 jdk11+, 而项目运行一般是 jdk8
所以要单独为 language-server 配置高版本 jdk, 在 user-settings 中增加如下配置

```json
"java.configuration.runtimes": [
  {
    "name": "JavaSE-1.8",
    "path": "jdk路径",
    "default": true
  },
  {
    "name": "JavaSE-11",
    "path": "jdk路径"
  }
]
```

### 2. vim插件共享系统剪贴板

vim 剪贴板是独立的，如果需要同步系统剪贴板，需要做如下配置

```json
"vim.useSystemClipboard": true
```

### 3. git commit 搜索

在 git 面板，点击更多，有搜索相关的功能

### 4. junit/testng/main 方法运行

redhat-ls 服务会在第一次打开java文件时启动，启动完成后就会在可运行的代码上方加载run/debug按钮

### 5. 创建 java 类

创建文件以 `.java` 后缀结束，就会按照文件名创建公共的 java 类代码

### 6. 断点

普通断点 在行号前左键点击即可

### 7. import 优化

删除多余的引入 快捷键 Organize Import -> Shift+Alt+O

### 8. 代码提示

Trigger Suggest 快捷键可能与系统冲突，一般可以修改成 alt+/

### 9. 格式化代码

java 代码默认没有配置格式化 formatter

```json
"[java]": {
"editor.defaultFormatter": "redhat.java"
}
```

### 10. 代码模板

生成指定格式的注释

设置 - user snippets, 会让你选择文件类型，然后设置模板

```json
"name":{
  "prefix": "afh",
  "body": [
    "test"
  ]
}
```

name 就是模板名称，prefix 是触发内容, body 是文本内容支持 $0,$1...用来定义指针位置,$0 是最后一个指针，还支持一些预置变量。
比较简单，就不说了。

### 11. 文件头

java 的文件头主要是两处，权限声明， 类型说明。而 redhat.ls 插件提供了该功能，在 user-settings 里配置即可。
java.templates.fileHeader 就是权限声明，位于文本开始处。
java.templates.typeComment 是类型说明，位于 class 上方

```json
{
  "java.templates.fileHeader": [
    "/**",
    "* Alipay.com Inc.",
    "* Copyright (c) 2004-${year} All Rights Reserved.",
    "*/\n"
  ],
  "java.templates.typeComment": [
    "/**",
    "* @author ${user}",
    "* @version $Id: ${file_name}, v 0.1 ${year}年${month}月${day}日 ${hour}:${minute} ${user} Exp $",
    "*/"
  ]
}
```

### 12. 代码生成

redhat.ls带有代码生成功能，不过比较麻烦，我们直接看 Java code generators, 它带有 generator gui 工具，可以在快捷键里设置一般快捷键是 alt+insert

+ source action 入口
右键或者命令栏(ctrl+p+>, 或者ctrl+shift+p) -> source action
`注意：目前自带的注释还不能修改`

getter/setter

constructor

override

seriliaztion

### 13. serialVersionUID

目前还没有插件提供这个功能，所以只能借助 quick fix, 不过 quick fix 也不稳定，所以要自定义代码片段来做，或者自定义插件来做。

### 14. json 格式化

Pretty Json 和 Prettier 都不能格式化，只能用 vscode 自带 vscode.json-language-features

```json
"[json]": {
    "editor.defaultFormatter": "vscode.json-language-features"
  },
```

### 15. git插件

git history 编辑器中右键可以查看文件的history

gitlens git栏会有更多细分的子栏目，代码里也会显示当前行最后的修改记录
