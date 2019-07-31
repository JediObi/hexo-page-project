---
title: nodejs selenium firefox
copyright: true
date: 2019-07-31 11:52:46
categories:
    - selenium
tags:
    - selenium
    - nodejs
---
selenium提供了一些ide插件用于录制selenium脚本。
本文介绍了firfox插件的使用，但注意版本。
在写文章时，该插件只支持 54.0.1版本。
通常不使用这类插件。而是页面右键直接获取xpath。

<!-- more -->

firefox 54.0.1 win64

(1) firefox 54.0.1

If you want to use Selenium IDE on firefox at the meantime.
Selenium IDE will NOT work on Firefox version 55 onwards.

(2) firefox driver

[firefox driver download](https://github.com/mozilla/geckodriver/releases/)
add it to system environmental variables
Path==>;D:\drivers\;

(3) node

npm install selenium-webdriver

(4) example without frame

test.js
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;
let until = webdriver.until;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();
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

(5) run the driver to open the standalone server proxy

cd D:\drivers
geckodriver.exe

(6) run the js

node test.js

(7) example with frame => switch to a target frame

API: driver.switchTo().frame(WebElement)
test.jhexos
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;
let until = webdriver.until;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('https://www.xxxx.com');
//driver.sleep(3*1000);

//switchto target frame
driver.switchTo().frame(driver.findElement(By.id('frame_id')));

driver.findElement(By.id('xx')).sendKeys('webdriver');
driver.findElement(By.id('yy')).click();
//driver.wait(until.titleIs('webdriver_百度搜索'),1000);
//driver.quit();
```
