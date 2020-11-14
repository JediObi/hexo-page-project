---
title: vscode-reactjs
copyright: true
mathjax: false
date: 2020-11-14 11:12:01
categories:
    - react
tags:
    - react
    - vscode
---

vscode 开发 react 项目时的常用配置

<!-- more -->

## 1. 使用 react 处理 js 文件并配置默认格式化处理器

preferences settings > user settings

```json
    "files.associations": {
        "*.js": "javascriptreact"
    },
    "[javascriptreact]": {
        "editor.defaultFormatter": "esbenp.prettier-vscode"
    }
```
