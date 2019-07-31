---
title: redux入门
copyright: true
date: 2019-07-31 18:57:16
categories:
    - reactjs
tags:
    - reactjs
    - redux
---
redux可以理解为数据源，用来解决组件通信问题。在原始的react项目中，组件通讯使用树结构，这导致状态变化数据的传递非常复杂。

<!-- more -->

```js
function inc(){
      return { type : 'INCREMENT'};
}
function dec(){
      return { type : 'DECREMENT'};
}

function reducer(state, action){
      state = state || { counter : 0};
      switch (action.type){
            case 'INCREMENT' :
                      return { counter : state.counter + 1};
            case 'DECREMENT' :
                      return { counter : state.counter - 1};
            default :
                      return state;
      }
} 
const store = createStore(reducer);
consloe.log(store.getState());

store.dispatch(inc());
consloe.log(store.getState());
store.dispatch(dec());
consloe.log(store.getState());
```