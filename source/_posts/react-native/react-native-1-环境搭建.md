---
title: react-native-1-环境搭建
copyright: true
mathjax: false
date: 2021-10-27 23:10:35
categories:
    - react-native
tags:
    - react-native
---
记录搭建react-native开发环境，并运行demo。

<!-- more -->

## 1. 环境搭建

jdk
nodejs
Android Studio
vscode(visual studio code)


### 1.1 jdk

版本

### 1.2 nodejs

nvm

npx

### 1.3 Android Studio

sdk-29
avd

## 2. 运行demo

初始化空项目
修改maven仓库
启动Metro编译服务
运行demo

### 2.1 初始化空项目

`npx react-native init AwesomeProject`
`react-native init AwesomeProject`


### 2.3 启动 Metro 编译服务

`npx react-native start` ， 不使用npx可能会导致错误出现

`react-native start`, 会报错，可能是因为项目是使用 npx 初始化的，缺少依赖。

这里之所以强调 单独启动 Metro 的步骤，是因为 `react-native run-android` 也会尝试启动 Metro 服务，但可能会失败。

### 2.4 运行demo

`npx react-native run-android`, 不使用npx可能会报错，这可能是由于项目使用了npx初始化
