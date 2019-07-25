---
title: (19) ECDH
date: 2019-07-24 22:19:07
copyright: true
categories:
    - bitcoin
tags:
    - bitcoin
    - 数字货币
    - ECDH
    - ECC
    - 椭圆曲线
    - 算法
    - 加密
    - 非对称加密
---
比特币加密算法，ECDH算法，使用ECC产生公钥，使用DH算法交换私钥

<!-- more -->

### **ECDH**



DH信息交换的思想，双方产生密钥对的算法从模运算变成椭圆曲线 

+ 生成密钥对
```
在椭圆曲线E上选取G，G的阶n
用户A，选择私钥 a<n，公钥 A = a*G
用户B，选择私钥 b<n，公钥 B = b*G
```

+ 生成对称秘钥
```
用户A
Q = a * B
用户B
Q' = b * A
证明:
Q = a * B = a * ( b * G) = b * (a * G) = b * A = Q' 
```

