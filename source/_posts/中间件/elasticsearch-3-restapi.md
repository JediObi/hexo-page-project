---
title: elasticsearch-3-restapi
copyright: true
mathjax: false
date: 2020-11-01 14:25:14
categories:
tags:
---
文章简介

<!-- more -->

## 1. index管理

### 1.1 创建索引

```
curl -XPUT http://localhost:9200/index_user -d '{
    "mappings":{
        "user":{
            "properties":{
                "id":{
                    "type": "long",
                    "index": "not_analyzed"
                },
                "name": {
                    "type": "text",
                    "index": "analyzed",
                    "analyzer": "standard"
                }
            }
        }
    }
}'
```
创建一个名为 index_user 的索引。该索引包含一个名为user的type，该type包含两个字段，id为long类型不做索引，name为text类型做索引使用默认分词器。

以上过程还可以分为两步，首先建立一个空的索引，然后使用_mapping api为索引定义type

+ 创建空的index 
```
curl -XPUT http://localhost:9200/index_user
```

+ 为指定的index定义type
```
curl -XPUT http://localhost:9200/index_user/user/_mapping -d '{
    "user"{
        "properties":{
            "id": {
                "type": "long",
                "index": "not_analyzed"
            },
            "name": {
                "type": "long",
                "index": "analyzed",
                "analyzer": "standard"
            }
        }
    }
}'
```

### 1.2 查询索引

```
curl http://localhost:9200/_cat/indices?v
```

### 1.3 删除索引

```
curl -XDELETE http://localhost:9200/index_user
```

## 2. document管理

### 2.1 创建 

```
curl -XPUT http://localhost:9200/index_user/user/1 -d '{
    "name": "jack jones"
}'
```
以上是通过rest api的put接口创建记录，注意请求路径中指定了id=1。

还可以通过post接口，不需要指定id，系统会自动生成id

### 2.2 查询

#### 2.2.1 通过id查询

```
curl http://localhost:9200/index_user/user/1?pretty=true
```
prettye这个参数主要是格式化json数据，方便curl输出

#### 2.2.2 通过关键词查询

```
curl -XPOST http://localhost:9200/index_user/user -d '{
    "query":{
        "term":{
            "name": "jack"
        }
    }
}'
```

#### 2.2.3 文本分词搜索

把输入的内容分词后，搜索后按匹配度排序

```
curl -XPOST http://localhost:9200/index_user/user -d '{
    "query":{
        "query_string":{
            "default_field": "name",
            "query": "rose is my friend, jack is also my friend"
        }
    }
}'
```

### 2.3 修改

```
curl -XPOST http://localhost:9200/index_user/user/1 -d '{
    "name": "jack wood"
}'
```

### 2.4 删除

```
curl -XDELETE http://localhost:9200/index_user/user/1
```
