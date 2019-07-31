---
title: shell of recursion function
copyright: true
date: 2019-07-31 12:36:37
categories:
    - shell
tags:
    - shell
    - function
---
shell支持函数和递归

<!-- more -->

```
#!/bin/bash

testFunc(){
        if (("$1"<3));then
              local testa=$(($1+1))
              testFunc $testa
              return $?
        fi
        return $1
}

testFunc 1
echo "$?"
```
```
     testFunc 1    ==>  1<3 true
                        testa=1+1=2
                        testFunc  2   ==>  2<3 true
                                           testa=2+1=3
                                           testFunc 3     ==> 3<3 false
     echo "$?(=3)" <==  return $?(=3) <==  return $?(=3)  <== return $1(=3)
```
