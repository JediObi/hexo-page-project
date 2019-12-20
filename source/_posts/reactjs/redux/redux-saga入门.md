---
title: redux-saga入门
copyright: true
date: 2019-12-20 11:19:56
categories:
    - reactjs
tags:
    - react
    - redux
    - redux-saga
---
使用了redux之后，数据的管理交给了redux，但是与服务端交互一般都是多流程的异步请求。
一个请求开始后，应当自动根据请求结果成功或失败渲染新的内容，在没使用redux之前，该过程在组件内部完成，因为state由组件自己管理。但是现在state由redux管理，所以该过程应该由redux控制。
redux-saga就是这样一个异步请求的redux插件。

<!-- more -->

(1) 安装redux-saga

`npm i redux-saga -S`

redux-saga 使用了generator。
函数基本上就是 带*号的函数，这种函数可以在函数内部任意地方执行返回，然后再从这个地方继续执行。
并且 提供了 async await这样的异步编程语法糖。不用再写promise的then链。

```js
    function* test(){
        yeild "value1";
        yeild "value2";
        return "value3";
    }
    let x = test();
    console.log(x.next()); // value1
    console.log(x.next()); // value2;
    console.log(x.next()); // value3
    console.log(x.next()); // undefined
```
该函数会返回一个iterator。这是es6提供的一种异步方案。

(2) 配置

然还需要一些额外的代码引入saga
1. 在 createStore处 或者是在 combinereducer的地方

```js
...
import {createStore, applyMiddleware} from "redux";
import createSagaMiddleware from "redux-saga";
import saga from "./saga";

...

const sagaMiddleware = createSagaMiddleware();
const store = createStore(
    reducer,
    applyMiddleware(sagaMiddleware)
);

sagaMiddleware.run(saga);
...

```

redux-saga分模块

最终可以使用 all 接口创建 rootSaga 对象

```js
import {all} from "redux-saga/effects";
import getTaskList from "./task";
import getDetail from "./detail";

export default all([
    getTaskList(),
    getDetail()
])

```


(3) 在redux中使用


+ saga.js

`put`相当于 redux的dispatch，所以参数也是action
根据结果不同执行不同的put
最后，要把函数注册到redux上

```js
import { call, put, takeEvery, taskLatest } from "redux-saga/effects";

function* getTaskList(action){
    try{
        const data = yield fetch("http://localhost:8080/task/list");
        yield put({type: "LOAD_SUCCESS", promise: data});
    }catch(e){
        yield put({type: "LOAD_FAIL", error: e.message});
    }
}

// takeEvery 并发执行，允许多个相同的action同时执行
// takeLatest 只允许最后一个action执行，前边的会被放弃
// 这两个接口构建在 take和fork之上
export default function* mySaga(){
    yield takeEvery("LOAD", getTaskList);
    // 其他的 异步接口，但是这样写不够优雅
    yield takeLast("detail_load", getDetail);
}

```


