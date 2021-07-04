---
title: react-demo
copyright: true
mathjax: false
date: 2021-05-09 20:31:38
categories:
  - react
tags:
  - react
  - node
  - saga
  - redux
  - router
---

本文从零开始创建一个包含路由，redux, 异步的 react demo。

<!-- more -->

## 1. 概述

本文从零开始搭建一个 js 版本的 react-demo

==> 首先是最基础的 webpack+react+router

==> 然后引入 redux

==> 接着引入异步框架 saga

## 2. 基础搭建

webpack+react+router

#### 2.2.3 工程结构

```
.
├── config
│   ├── build.js
│   ├── paths.js
│   ├── webpack.config.common.js
│   ├── webpack.config.dev.js
│   └── webpack.config.prod.js
├── package.json
├── package-lock.json
├── public
│   ├── images
│   │   ├── password.png
│   │   └── user.png
│   └── index.html
├── README.MD
├── src
│   ├── App.css
│   ├── App.js
│   ├── components
│   │   ├── login
│   │   │   ├── Login.css
│   │   │   └── Login.js
│   │   └── verify
│   │       ├── Verify.css
│   │       └── Verify.js
│   ├── index.js
│   └── utils
│       └── api.js
└── webpack.config.js
```

注意的点

## 3. 引入 redux

## 4. 引入异步框架-saga
