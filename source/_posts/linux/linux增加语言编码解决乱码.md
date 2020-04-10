---
title: linux增加语言编码解决乱码
copyright: true
date: 2020-04-11 07:02:05
categories:
    - linux
tags:
    - linux
    - ubuntu
    - manjaro
    - locale
    - local-gen
---
某些语言文字乱码，需要手动添加该语言的编码。比如中文缺少 zh_CN.UTF-8，导致乱码。

<!-- more -->

### (1) 查看系统当前使用的语言和编码

```
~:locale -a
```

### (2) 生成指定语言的某种编码及原理

```
~:locale-gen zh_CN.UTF-8
```
locale-gen 根据参数值搜索 /etc/locale.gen 里的配置，如果locale.gen里没有配置则不会生成。

locale.gen 里的配置如下
```
locale  charset
```
locale 就是支持的语言，所有支持的语言都在 /usr/share/i18n/locales 里配置，在locale.gen可以为语言增加后缀比如 .UTF-8， 需要 sed 来分割后缀。

charset 是支持的编码，所有支持的编码都在 /usr/share/i18n/charmaps 里配置，都是.gz文件，所以需要 gzip 支持。

locale-gen最后生成的语言和编码会覆盖 `locale -a`里展示的所有的内容。
