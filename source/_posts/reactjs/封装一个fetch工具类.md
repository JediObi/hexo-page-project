---
title: 封装一个fetch工具类
copyright: true
date: 2019-07-31 19:03:54
categories:
    - reactjs
tags:
    - reactjs
    - fetch
---

```js
class FetchUtil{
    get(param){
        alert(1);
        fetch(param.url).then((response)=>{
            return response.json();
        }).then(jsonData=>{console.log(jsonData);}).catch(()=>{console.log('出错');});
    }
}

export default FetchUtil;
```