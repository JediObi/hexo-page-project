---
title: '@Responsebody utf8 Chinese gibberish'
copyright: true
date: 2019-07-31 14:37:45
categories:
    - spring
tags:
    - spring
    - 中文乱码
---
controller返回中文乱码的处理。

<!-- more -->

Chinese gibberish-->controller return a String "中文" to html, but html shows "??".

create a class like

```
package com.fc.test.utils;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.config.BeanPostProcessor;
import org.springframework.http.MediaType;
import org.springframework.http.converter.StringHttpMessageConverter;

import java.nio.charset.Charset;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by 
 */
public class UTF8StringBeanPostProcessor implements BeanPostProcessor {
    @Override
    public Object postProcessBeforeInitialization(Object o, String s) throws BeansException {
        if (o instanceof StringHttpMessageConverter){
            MediaType mediaType = new MediaType("text", "plain", Charset.forName("UTF-8"));
            List<MediaType> types = new ArrayList<MediaType>();
            types.add(mediaType);
            ((StringHttpMessageConverter) o).setSupportedMediaTypes(types);
        }
        return o;
    }

    @Override
    public Object postProcessAfterInitialization(Object o, String s) throws BeansException {
        return o;
    }
}

```
and add it a bean in spring-mvc.xml

```
<bean class="com.fc.test.utils.UTF8StringBeanPostProcessor"/>
```
