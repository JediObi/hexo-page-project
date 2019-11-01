---
title: sed的复杂用法
copyright: true
date: 2019-07-31 14:02:39
categories:
    - shell
tags:
    - shell
    - sed
---
sed 的脚本部分支持嵌套，本文会补充一些基本用法，和嵌套写法。

<!-- more -->

### **1. sed 的命令格式**

`sed [options] <script> filepath`

以上就是最基础的格式，比如常用的打印第三行的文本内容 `sed -n "3p" test.txt`

options 常用

n: quiet模式，只保留匹配的行，否则也会保留原始内容。	

-i: 脚本的输出结果替换到文本中。			

-e: 支持多脚本 也就是命令里会有多个 `<script>`， 这样会降低嵌套脚本复杂度

### **2. script 组成**

script 由 {} 大括号包围， 
非嵌套写法: `{[start_line, limit,end_line] option}`

嵌套写法: `{[start_line, limit,end_line] [<script>]}`

参数部分:

	start_line: 开始行，可以是数字，也可以是正则（未验证多行匹配将使用第一行）
	end_line: 结束行，可以是数字，也可以是正则（未验证多行匹配取第一行）
	limit: 必须是数字，如果不存在 end_line，就表示 start_line，以及它之后的行数。如果存在 end_line就表示跳跃行数。
	option: 操作，多个操作需要使用 分号;分隔。
	<script> 嵌套脚本

option除了一般的命令操作，也包含一个类似于vim替换的 正则替换操作

	一般操作包括 = 打印行号, p 打印文本
	正则替换操作 [line_number]s/pattern/conten/[g] 支持正则的分组捕获。

### **3. 一些例子**

+ #### 注释某个匹配的行

	`sed "{s/^(Server)(.*)/# \1\2}/ p"`