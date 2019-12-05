---
title: tensorflow-1 衣物分类
copyright: true
date: 2019-08-02 10:57:57
categories:
  - reactjs
tags:
  - reactjs
  - typescript
---
用面向对象的思想来看 子组件 props 回调函数

<!-- more -->

react 也提供了像java那样的抽象编程能力。
但是由于react的特点是，数据流像自上而下，数据回传依赖于回调。子组件提供抽象方法，父组件实现并作为回调传给子组件。由于层级太多，就会产生回调链，会导致组件高度耦合，复用度降低。当然可以用redux来解决这个问题，把数据的修改放在一个统一的域里管理，会把组件的耦合度降低很多。

这里主要介绍下，子组件是如何传参给父组件的。

子组件提供一个抽象方法，子组件会在各处调用如何传参都由子组件控制，但此时子组件相当于一个抽象类。

父组件实现这个抽象方法，只可以在方法体里决定具体做什么。运行时，子组件调用该方法，传参，父组件实现。基本和java抽象类很像。

- 父组件

```js
constructor(props){
    super(props);
    this.state = {
        idList: [1,2,3]
    }
}

changeId(id:number, sub_element_data:string){
    console.log("changeId, id=%s,data=%s", id, sub_element_data);
    ...
}

render(){
    const subElementList = this.state.idList.map((ele:number,index:number,arr:number[])=>{
        return (
            <SubElement key={"sub-"+index} onChange={(sub_element_data:string)=>this.changeId(ele,sub_element_data)}></SubElement>
        )
    });
    return (
        <div>
            {subElementList}
        </div>
    );
}
```

- 子组件

```js
interface Props{
    onChange: (sub_element_data):string=>void;
}

render(){
    return(
        <Input onChange={(event)=>thi传递给 子组件一个 函数定义
```js
{(sub_element_data:string)=>this.changeId(ele,sub_element_data)}
```
入参和函数体，函数体里调用了父组件自己的一个函数。入参由调用方提供，子组件会通过props回调，所以调用方就是子组件。

子组件为 Input的onChange创建了一个函数定义 
```js
{(event)=>this.props.onChange(event.target.value)}
```
入参和函数体，调用方是Input，input默认传参是一个event类型。函数体则是子组件的props回调。

因此 子组件的 Props 接口里限定的回调原型，父组件实现了这个函数，而子组件则是调用。