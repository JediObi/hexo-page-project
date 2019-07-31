---
title: quick start (1)
copyright: true
date: 2019-07-31 11:39:41
categories:
    - selenium
tags:
    - selenium
    - nodejs
---
selenium是一个网页自动测试工具。可以用nodejs,java和python编写测试脚本。
本系列使用nodejs编写脚本。
本文介绍安装过程，并附带一个简单的测试脚本。

<!-- more -->

(0) start an node project

(1) install selenium

```
~:npm install --save-dev selenium-webdriver
```

(2) download drivers for current version of browser

chrome
firefox: https://github.com/mozilla/geckodriver/releases

(3) config environment for browser drivers

sudo vim /etc/profile
```
drivers_home=/home/username/drivers
PATH=$PATH:$drivers_home/
export PATH
```
source /etc/profile

(4) test.js

```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;
let until = webdriver.until;

const driver = new webdriver.Builder()
    .withCapabilities(webdriver.Capabilities.chrome())
    .build();

//const driver = new webdriver.Builder()
//    .forBrowser('firefox')
//    .build();

/*
// use standalone proxy
// chrome
const driver = new webdriver.Builder()
    .usingServer('http://localhost:9515')
    .withCapabilities(webdriver.Capabilities.chrome())
    .build();
//firefox
const driver = new webdriver.Builder()
    .usingServer('http://localhost:4444/wd/hub')
    .forBrowser('firefox')
    .build();
const driver = new webdriver.Builder()
    .usingServer('http://localhost:4444/wd/hub')
    .withCapabilities({  
    browserName: 'firefox'   
    })
    .build();
*/

driver.get('https://www.baidu.com');
//driver.sleep(3*1000);
driver.findElement(By.id('kw')).sendKeys('webdriver');
driver.findElement(By.id('su')).click();
//driver.wait(until.titleIs('webdriver_百度搜索'),1000);
//driver.quit();
```
node test.js
