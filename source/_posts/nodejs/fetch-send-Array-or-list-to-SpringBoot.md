---
title: fetch send Array or list to SpringBoot
copyright: true
date: 2019-07-26 17:20:07
categories:
    - node
tags:
    - fetch
    - node
    - spring
    - post
---
fetch给spring boot controller发送 array 或 list 参数。

<!-- more -->

### **1. js请求源码**

```js
fetch(url + "/testJob", {
    method: "post",
    body: "ids="+new Array(1,2),
    // or body: "ids="+[1,2],
    headers: {
        'Accept': 'application/json',
      // specify x-www-form-urlencoded
        'Content-Type': 'application/x-www-form-urlencoded',
    },
}).then(res => {
    return res.json();
}).then(body => {
    console.log(body);
})
```

### **2. java源码**

**@RequestParam("ids")**
```java
@PostMapping("/testJob")
public void testJob(@RequestParam("ids") List<Integer> ids){
 
}
```