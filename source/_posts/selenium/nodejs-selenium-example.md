---
title: nodejs-selenium example
copyright: true
date: 2019-07-31 11:58:13
categories:
    - selenium
tags:
    - selenium
    - nodejs
---
一个完整的使用firefox的selenium脚本。

<!-- more -->

```js
const webdriver = require('selenium-webdriver');
let By = webdriver.By;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('http://www.xxx.com');

// switch to frame
// driver.switchTo().frame("frame name or index"| WebElement);
// WebElement may not effectively switch to target frame
// driver.switchTo().frame(driver.findElement(By.id('frame_id')));
// frame name
driver.switchTo().frame('frame_name');

// input user name
driver.findElement(By.id('username')).click();
driver.findElement(By.id('username')).sendKeys('abc');

// input password
driver.findElement(By.id('password')).sendKeys('abc123');
driver.findElement(By.id('password')).click();

let countryCode;
for(let i=0;i<3;i++){
	driver.findElement(By.id('contrycode')).click();
nodejs-selenium example	driver.sleep(500);
	driver.findElement(By.xpath('//option[@value="86"]')).click();
	countryCode = driver.findElement(By.id("countryCode")).getText();
	if (countryCode) break;
}
if (!stationCode){
	driver.quit();
}

// login
driver.findElement(By.id('login')).then(element=>element.click());

// maybe login failure, password error. deal with the possible alert.
driver.switchTo().alert().then(element=>element.accept()).catch(e=>console.log("no alert\n"+e));

// login success
// wait for new page
driver.sleep(500);

//driver.quit();
```
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('http://www.xxx.com');

// switch to frame
// driver.switchTo().frame("frame name or index"| WebElement);
// WebElement may not effectively switch to target frame
// driver.switchTo().frame(driver.findElement(By.id('frame_id')));
// frame name
driver.switchTo().frame('frame_name');

// input user name
driver.findElement(By.id('username')).click();
driver.findElement(By.id('username')).sendKeys('abc');

// input password
driver.findElement(By.id('password')).sendKeys('abc123');
driver.findElement(By.id('password')).click();

let countryCode;
for(let i=0;i<3;i++){
	driver.findElement(By.id('contrycode')).click();
nodejs-selenium example	driver.sleep(500);
	driver.findElement(By.xpath('//option[@value="86"]')).click();
	countryCode = driver.findElement(By.id("countryCode")).getText();
	if (countryCode) break;
}
if (!stationCode){
	driver.quit();
}

// login
driver.findElement(By.id('login')).then(element=>element.click());

// maybe login failure, password error. deal with the possible alert.
driver.switchTo().alert().then(element=>element.accept()).catch(e=>console.log("no alert\n"+e));

// login success
// wait for new page
driver.sleep(500);

//driver.quit();
```
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('http://www.xxx.com');

// switch to frame
// driver.switchTo().frame("frame name or index"| WebElement);
// WebElement may not effectively switch to target frame
// driver.switchTo().frame(driver.findElement(By.id('frame_id')));
// frame name
driver.switchTo().frame('frame_name');

// input user name
driver.findElement(By.id('username')).click();
driver.findElement(By.id('username')).sendKeys('abc');

// input password
driver.findElement(By.id('password')).sendKeys('abc123');
driver.findElement(By.id('password')).click();

let countryCode;
for(let i=0;i<3;i++){
	driver.findElement(By.id('contrycode')).click();
nodejs-selenium example	driver.sleep(500);
	driver.findElement(By.xpath('//option[@value="86"]')).click();
	countryCode = driver.findElement(By.id("countryCode")).getText();
	if (countryCode) break;
}
if (!stationCode){
	driver.quit();
}

// login
driver.findElement(By.id('login')).then(element=>element.click());

// maybe login failure, password error. deal with the possible alert.
driver.switchTo().alert().then(element=>element.accept()).catch(e=>console.log("no alert\n"+e));

// login success
// wait for new page
driver.sleep(500);

//driver.quit();
```
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;

const driver = new webdriver.Builder()
	.forBrowser('firefox')
	.build();

driver.get('http://www.xxx.com');

// switch to frame
// driver.switchTo().frame("frame name or index"| WebElement);
// WebElement may not effectively switch to target frame
// driver.switchTo().frame(driver.findElement(By.id('frame_id')));
// frame name
driver.switchTo().frame('frame_name');

// input user name
driver.findElement(By.id('username')).click();
driver.findElement(By.id('username')).sendKeys('abc');

// input password
driver.findElement(By.id('password')).sendKeys('abc123');
driver.findElement(By.id('password')).click();

let countryCode;
for(let i=0;i<3;i++){
	driver.findElement(By.id('contrycode')).click();
nodejs-selenium example	driver.sleep(500);
	driver.findElement(By.xpath('//option[@value="86"]')).click();
	countryCode = driver.findElement(By.id("countryCode")).getText();
	if (countryCode) break;
}
if (!stationCode){
	driver.quit();
}

// login
driver.findElement(By.id('login')).then(element=>element.click());

// maybe login failure, password error. deal with the possible alert.
driver.switchTo().alert().then(element=>element.accept()).catch(e=>console.log("no alert\n"+e));

// login success
// wait for new page
driver.sleep(500);

//driver.quit();
```
// switch to frame
// driver.switchTo().frame("frame name or index"| WebElement);
// WebElement may not effectively switch to target frame
// driver.switchTo().frame(driver.findElement(By.id('frame_id')));
// frame name
driver.switchTo().frame('frame_name');

// input user name
driver.findElement(By.id('username')).click();
driver.findElement(By.id('username')).sendKeys('abc');

// input password
driver.findElement(By.id('password')).sendKeys('abc123');
driver.findElement(By.id('password')).click();

let countryCode;
for(let i=0;i<3;i++){
	driver.findElement(By.id('contrycode')).click();
nodejs-selenium example	driver.sleep(500);
	driver.findElement(By.xpath('//option[@value="86"]')).click();
	countryCode = driver.findElement(By.id("countryCode")).getText();
	if (countryCode) break;
}
if (!stationCode){
	driver.quit();
}

// login
driver.findElement(By.id('login')).then(element=>element.click());

// maybe login failure, password error. deal with the possible alert.
driver.switchTo().alert().then(element=>element.accept()).catch(e=>console.log("no alert\n"+e));

// login success
// wait for new page
driver.sleep(500);

//driver.quit();
```
