---
title: high perform
copyright: true
date: 2019-07-31 10:56:33
categories:
    - java
tags:
    - java
---
java单机高性能和数据安全实践。

<!-- more -->

(1) redis lock to prevent duplicated submit

(2) db optimistic lock

version = version +1 where version=#oldVersion#
this will toss the io-load to db system.

(3) spring transaction

+ tansactin propagation
+ 
use `required` and `requires_new`; Default is `required`.
For batch missions, rollback the whole transaction is too wasted. Spit a batch mission transaction into different new transactions is much better. Each new sub transaction will rollback itself by throw exception if an exception happened. And the parent transaction could use `try...catch` to skip an exceptional sub transaction.

(4) threads

You can use thread without any safty problem by using (1) (2) (3).