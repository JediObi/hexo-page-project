---
title: (3) Json RPC
date: 2019-07-24 22:03:07
copyright: true
categories:
    - bitcoin
tags:
    - bitcoin
    - 数字货币
    - RPC
---
使用 JSON RPC 调用比特币区块链开放接口

<!-- more -->

## **Json RPC**



If a server runs with json-rpc. 
Anyone may send request to this server in json format.  
```json
{
    "jsonrpc" : 2.0,
    "method" : "sayHello", 
    "params" : ["Hello JSON-RPC"], 
    "id" : 1
}
```
Just like an url `http://localhost:8080/test_project/rpc` with body`{"method":"sayHello","params":[],"id":1234}`.   
A json-rpc calling is just like a traditional http request.     
Because we use json or key-value format to transform our message in http server.
