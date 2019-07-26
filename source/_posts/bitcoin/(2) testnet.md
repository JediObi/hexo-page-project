---
title: (2) Testnet on Docker
date: 2019-07-24 22:02:07
copyright: true
categories:
    - bitcoin
tags:
    - bitcoin
    - 数字货币
    - Docker
---
使用 比特币 Docker 测试网络

<!-- more -->

## **Testnet on Docker**

### **(1) pull bitcoin testnet image**

```shell
~:docker pull freewil/bitcoin-testnet-box
```

### **(2) start a testnet container**

```shell
~:docker run -t -i -p 19001:19001 -p 19011:19011 freeewil/bitcoin-testnet-box
```

### **(3) start testnet**

```shell
~:make start
```

### **(4) getinfo**

```shell
~:make getinfo
```

### **(5) generate 1 block**

```shell
~:make generate
```

### **(6) generate n blocks**

```shell
~:make generate BLOCKS=200
~:make getinfo
```

### **(7) transfer some money**

generate a transaction.     
you need to generate blocks to make transactions effective. 

```shell
~:make sendfrom1 ADDRESS=xxxxxxxx AMOUNT =10
~:make generate BLOCKS=10
~:make getinfo
```