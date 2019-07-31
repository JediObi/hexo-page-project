---
title: nodejs-selenium catch alert exception
copyright: true
date: 2019-07-31 11:50:12
categories:
    - selenium
tags:
    - selenium
    - nodejs
---
有些页面可能会有alert，但不一定会真的弹出。
直接使用前文介绍的api可能会产生没有alert的异常，导致脚本终止。
本文介绍使用promise和then捕获alert并catch异常，以防止异常终止。

<!-- more -->

```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('https://www.xxx.com');

driver.switchTo().alert().then(promise=>promise.accept()).catch(e=>console.log("no alert\n"+e));
```
