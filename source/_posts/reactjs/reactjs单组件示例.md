---
title: reactjs单组件示例
copyright: true
date: 2019-07-31 19:01:39
categories:
    - reactjs
tags:
    - reactjs
---
reactjs 组件demo

<!-- more -->

```js
import React, { Component } from 'react';

class MyComponent extends Component {
    constructor(){
        super();
        this.state={
            testValue:0,
        };
    }
    handleClick(){
        const tempState=this.state;
        if (tempState.testValue>0){
            tempState.testValue=0;
        }else{
            tempState.testValue=1;
        }
        this.setState(tempState);
    }
    render(){
        return(
            <div>
            <p>{this.state.testValue}</p>
            <button onClick={()=>this.handleClick()}>
                hello
            </button>
            </div>
        );
    }
}

export default MyComponent;
```