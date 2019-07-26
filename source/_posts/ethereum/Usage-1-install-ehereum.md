---
title: Usage (1) - install ehereum
copyright: true
date: 2019-07-25 18:09:10
categories:
    - ethereum
tags:
    - ethereum
    - 以太坊
---
安装以太坊，源码编译安装

<!-- more -->

### **1. install go client - geth**

```
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo add-apt-repository -y ppa:ethereum/ethereum-dev
sudo apt-get update
sudo apt-get install ethereum
sudo apt-get install solc
```

### **2. start with testnet**

Use rinkeby testnet.        
About 7.6G until 2018-05-25.
```
~:geth --rinkeby
```

### **3. how to use rinkeby and test develop on it.**
