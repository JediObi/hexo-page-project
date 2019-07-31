---
title: nodejs-selenium switch to frame and alert
copyright: true
date: 2019-07-31 11:48:31
categories:
    - selenium
tags:
    - selenium
    - nodejs
---
像一些复杂页面可能会有iframe，使窗口分成很多window，这回使直接组件定位失效。
需要切换window，然后才能定位到正确的组件。
本文介绍如何切换iframe。和如何自动关掉alert窗口。

<!-- more -->

You don't need to care frameset.
```
const webdriver = require('selenium-webdriver');
let By = webdriver.By;
...
//switch to frame
//driver.switchTo().frame("frame name or index"| WebElement);
driver.switchTo().frame(driver.findElement(By.id("frame_id"));
// then you can control the elements in this frame

// switch to alert
driver.swtichTo().alert().accept();
```
