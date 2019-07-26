---
title: MySQL recursion select
copyright: true
date: 2019-07-26 17:29:53
categories:
    - mysql
tags:
    - mysql
    - query/select
    - recursion query
    - 递归查询
---
一个mysql自下向上的递归查询sql。
实践经验告诉我，这样的sql不用也罢。
如果要避免这样的用法，首先要设计好表结构，其次可以把部分递归逻辑转换到代码里。如果有性能方面的考量可以考虑函数或存储过程，或优化好表结构。

<!-- more -->

递归查询的需求： 用户邀请层级关系，在该关系上存在（一/二/三）三级代理商。如下。用户表和代理商表没有代理关系的字段，也就是用户表里没有所属代理商字段。代理商也没有代理商代理的用户列表。在用户表建立代理商字段，或者建立代理商代理用户关系表，变动时，更改数据太多。
```
用户A邀请了用户B，用户B邀请了用户C，用户C邀请了用户D，A->B->C->D。
而A是三级代理商，则根据D的上级邀请关系，查询出D的三级代理商。
需要查出C->查出B->查出A。

相应的，代理商要查询出自己代理了哪些用户，A->B->C->D，这样的顺序查询。
```
+ 一个优化

```
建立用户的邀请层级关系表，比如 A a， B a.b， C a.b.c，D a.b.c.d。
查询时就会方便很多。
```


在查询中使用变量和子查询可以形成递归。
查询结果里的子查询因为变量修改重新发起查询。
一个自下向上的递归
```sql
select id cid,(select @var:= parent_id from table1 where id=cid) pid 
from 
table1, (select @var := 10) init_id
where 
table1.id = @var
and table1.parent_i <> 0;
```
以上例子将查询id=10的所有祖先节点.