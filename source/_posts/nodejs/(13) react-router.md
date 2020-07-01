---
title: (13) react-router
date: 2019-07-23 22:13:07
copyright: true
categories:
  - node
  - react
tags:
  - node
  - react
  - rector-router
---

单页面应用使用不同的组件替代了传统的多页面，url 跳转页面也就变成了 url 跳转组件，react-router 就是提供 url 跳转组件的能力。

<!-- more -->

## **(13) react-router**

### **(1) 为什么使用router**

传统多页面应用，使用url定位资源位置，但是多页面应用实际只有一个url，不同的页面使用了不同的组件实现，那么想要跳转这些组件就可以用router。

### **(2) 安装依赖**

```
~:npm i react-router react-router-dom
```
仅使用`react-router`就能实现路由能力，但是路由的配置会很麻烦， `react-router-dom`提供了一些react组件，这些组件封装好了路由逻辑，使路由更简单，还提供了一些比如switch组件只渲染匹配的组件提高性能。

### **(3) 完整的demo**

```js
<Router>
    <Route path="/" component={App}>
        <Route path="component1" component={Component1} />
        <Route path="component2" component={Component2}>
            <Route path="messages/:id" component={Message} />
        </Route>
    </Route>
</Router>

<App>
<Link to="/component1">
</App>
```

### **(4) 组件介绍**

`Router` 最外层根组件，它依赖于浏览器的history做路由，router管理整个应用的路由，它会拦截url并渲染
`Route` url和组件映射，当url匹配时组件就会被渲染
`Link` 类似于a标签，做url跳转

`react-router-dom` 前边介绍的Router其实只是一层抽象，react-router-dom提供了若干实现，最常用的BrowserRouter和HashRouter，其中BrowserRouter依赖于H5的history API来解析url，特点是会产生真实请求，由于url实际对应的只是个组件所以会报错，需要服务端渲染。HashRouter则通过hashhistory在url中增加#隔离，实现纯前端路由，url不会做实际请求。

### **(5) 进阶**

在引入了redux之后，使用异步组件redux-saga，redux-saga并不支持router能力，`connected-react-router` 类似于react-router-dom 提供了redux-saga支持的router能力，它把url跳转封装为reducer dispatch，并且用法与react-router相同。

