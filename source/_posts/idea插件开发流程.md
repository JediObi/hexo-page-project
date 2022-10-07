---
title: idea插件开发流程
copyright: true
mathjax: false
date: 2022-09-30 22:19:59
categories:
tags:
---
文章简介

<!-- more -->

正文

右键测试分组 RunContextGroup, 只要有debug出现就会出现

获取方法/类/文件夹

首先获取当前editor

    `e.getData(LangDataKeys.EDITOR)`

然后获取当前editor打开的虚文件

```java
Document doc = editor.getDocument();
PsiFile psiFile = PsiDocumentManager.getInstance().getPsiFile(doc);
```
接着获取指针所在行相对偏移量
```
CaretModel caretModel = editor.getCaretModel()
int offset = caretModel.getOffset()
```
然后获取偏移处的PsiElement
```
PsiElement element = psiFile.findElementAt(offset)
```
偏移处可能是方法/类/文件夹或是类的代码块或方法里的代码。
如果不是方法/类/文件夹 那么就会获取父级element(代码的上级就是方法或类)
```java
if(!(element instanceof PsiMethod)&&!(element instanceof PsiClass)&&!(element instanceof PsiDirectory))
element = PsiTreeUtil.getParentOfType(element, PsiMethod.class);
// element = PsiTreeUtil.getParentOfType(element, PsiClass.class);
// element = PsiTreeUtil.getParentOfType(element, PsiDirectory.class);
```

之后就能获取方法或类的信息

添加依赖，需要先在

gralde -> intellij -> plugins 里添加

然后去 plugin.xml 里添加 depends

比如添加 intellij java先关

gradle 

```
...
intellj{
    ...
    plugins.set(listOf("com.intellij.java"))
}
```

plugins.xml
```xml
<depends>com.intellij.modules.java</depends>
```

找到文件之后，需要找到启动方式 -> 插件本身处于运行态

官方demo https://github.com/JetBrains/intellij-sdk-code-samples/tree/main/run_configuration

往run configuration中添加自定义运行配置

基本流程是扩展extensions.configurationType, 但是还缺少运行所需的基本配置

其中关键配置继承 RunConfigurationBase, 但是junit是继承封装之后 JavaTestConfigurationWithDiscoverySupport
    其中getState方法和getConfigurationEditor两个方法比较重要
    getConfigurationEditor 用于绘制run configuration里的ui
    getState用于java启动 这个state继承 JavaTestFrameworkRunnableState，它封装了很多java启动的逻辑，参考junit.TestObject