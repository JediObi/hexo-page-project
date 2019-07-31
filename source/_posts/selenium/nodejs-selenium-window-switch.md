---
title: nodejs-selenium window switch
copyright: true
date: 2019-07-31 11:42:11
categories:
    - selenium
tags:
    - selenium
    - nodejs
---
selenium脚本打开页面需要时间。可能导致无法定位到正确的页面，脚本执行失败。
本文介绍了，如果获取页面句柄，从而使浏览器驱动获取到正确的页面。

<!-- more -->

use firefox!

The program has to wait for a few seconds during the loading time of a new page because elements haven't been loading completely and `findElement()` can't find them.
Using `driver.sleep(n*1000)`  to ensure that the browser has enough time to open a new tab or load an url successfully.

```js
const webdriver = require('selenium-webdriver');
let By = webdriver.By;


const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('https://www.baidu.com');

driver.findElement(By.xpath("//input[@id='kw']")).sendKeys('webdriver');
driver.findElement(By.xpath("//input[@id='su']")).click();

// here 2 seconds is enough
driver.sleep(2*1000);

let handle1 = driver.getWindowHandle();
driver.findElement(By.xpath("//div[@id='1']/*/a")).click();

// here 3s is enough
driver.sleep(3*1000);

driver.getAllWindowHandles().then(handles=>{
	console.log(handles);
})
driver.switchTo().window(handle1);
```

