---
title: elasticsearch-2-基本概念
copyright: true
mathjax: false
date: 2020-11-01 14:35:18
categories:
tags:
---
文章简介

<!-- more -->

## 1. 索引-index

类似于mysql的database的概念。es主要就是管理索引。

## 2. 类型-type

`注意：从es5.x开始，逐步剔除掉type的概念，所以建议一个index里只建一个type.`

type类似于java类或者msyql table的概念，但它只包含字段的组成，却不包括字段的类型定义，定义的工作交给mapping来做。

type是字段的虚拟映射，同一个index不同type里同名的字段，在lucene中使用同一个字段存储，这会引起查询上的混乱。并且一个index包含多个type时，这个index的数据分布比较稀疏，不利于es去压缩它。基于这两点，es会逐步剔除掉type的概念。在es5.x和6.x版本中，建议是一个index只包含一个type。而在7.x版本，可以直接略去type这层。

## 3. 映射-mapping

mapping用来定义type里字段的数据类型，是否单独存储，是否索引，索引使用的分词器等属性

## 4. 记录-document

类似于mysql里的行