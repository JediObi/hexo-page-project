---
title: sed locate some lines
copyright: true
date: 2019-07-31 14:22:51
categories:
    - shell
tags:
    - shell
    - sed
---
sed命令定位匹配的行。

<!-- more -->

a.txt
```
this is abc
this is test
this is abc
this is test
```

(1) print by sed

```
~:sed -n 'p' a.txt
```

`-n` just use the line which has been operated
`p` print operation

(2) print one line

```
~:sed -n '2p' a.txt
```
print the 2th line

(3) print 1~3 line

```
~:sed -n '1,3p' a.txt
```

(4) locate by regex

1) print all "this is abc"

    ```
    ~:sed -n '/this is abc/ p' a.txt
    ```

2) replace all "this is abc" to "that is abc"

    ```
    ~:sed -i 's/this is abc/that is abc/' a.txt
    ```