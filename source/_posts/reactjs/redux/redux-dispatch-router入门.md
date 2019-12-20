---
title: redux dispatch router入门
copyright: true
date: 2019-12-20 11:20:36
categories:
    - reactjs
tags:
    - react
    - redux
    - saga
    - router
---
在引入了saga之后，系统可以处理异步流程，但是仅仅在同一个页面渲染数据是不够的。
有时候还需要根据结果自动跳转到不同的route，此处引入 `connected-react-router` 组件，使dispatch包括saga的put，支持route跳转。

<!-- more -->

(1) 安装 connected-react-router

`npm i connected-react-router -S`

(2) 配置

+ reducer 改造

```js
import { combineReducers } from "redux";
import { connectRouter } from "connected-react-router";
const reducers = (history: any) =>
  combineReducers({
    router: connectRouter(history),
    // ... 其他reducer
  });

export default reducers;
```
+ store改造

```js
import { createStore as _createStore, applyMiddleware, compose } from "redux";
import createSagaMiddleware from "redux-saga";
import reducers from "./modules/reducer";
import rootSaga from "./rootSaga";
import { createBrowserHistory } from "history";
import { routerMiddleware } from "connected-react-router";

const sagaMiddleware = createSagaMiddleware();
export const history = createBrowserHistory();

export default function createStore() {
  const store = _createStore(
    reducers(history),
    compose(
      applyMiddleware(
        routerMiddleware(history),
        sagaMiddleware
      )
    )
  );
  sagaMiddleware.run(rootSaga);
  return store;
}
```

+ 根组件改造
```js
import React from "react";
import { BrowserRouter as Router, Link } from "react-router-dom";
import "./App.less";
import { Layout, Menu, Icon } from "antd";
import getRoutes from "./routes";
import { ConnectedRouter } from "connected-react-router";
import {history} from "./redux/create";

const { Header, Content, Footer, Sider } = Layout;

const routes = getRoutes();

const App: React.FC = () => {
  return (
    <ConnectedRouter history={history}>
      ...
    </ConnectedRouter>
  );
};

export default App;
```

(3) 使用

+ 在 saga中使用

```js
import { push } from "connected-react-router";
import { put, call, takeLatest } from "redux-saga/effects";

function* saveTask(action: TaskCreateAction) {
  try {
    const data = yield call(
      fetchApi,
      "saveTask",
      JSON.stringify(action.taskDetail)
    );
    // todo 此处可以直接push数据
    console.log("saga save task success,", data.task);
    yield put({ type: createActionType.SAVE_SUCCESS, taskDetail: data });
    let path = { pathname: "/saved_detail/", state: data };
    yield put(push(path));
  } catch (e) {
    yield put({ type: createActionType.SAVE_FAIL, error: e.message });
  }
}

...

export default function* taskSaga() {
  yield takeLatest(createActionType.SAVE, saveTask);
  ...
}
```

注意: 此处 push 是带参数的形式，注意route写法

```js
<Route path="/saved_detail" component={TaskDetail}></Route>
```
获取数据
```js
this.props.location.state
```