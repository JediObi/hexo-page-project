---
title: junit-自定义starter
copyright: true
mathjax: false
date: 2022-09-17 23:12:00
categories:
    - junit
tags:
    - junit
    - junit5
    - java
    - idea
---
汇总junit知识点

<!-- more -->

Idea自带的junit Starter main函数最后`System.exit(0)`, 默认会结束所有线程。

可以在子线程start()之后，调用join()方法，让主线程等待子线程结束。

但是console的初始节点创建逻辑需要看下插件是怎么弄的

```xml
<!-- defaultExtensionNs: namespace, 子节点扩展该namespace下的extension point, 比如此处namespace=com.intellij, 那么子节点 configurationType 就表示 com.intellij.configurationType 这个extension point -->
<extensions defaultExtensionNs="com.intellij">
    <!-- LangExtensionPoints.xml -->
    <runConfigurationProducer implementation="com.intellij.execution.junit.AbstractAllInDirectoryConfigurationProducer"/>
    <runConfigurationProducer implementation="com.intellij.execution.junit.AllInPackageConfigurationProducer"/>
    <runConfigurationProducer implementation="com.intellij.execution.junit.PatternConfigurationProducer"/>
    <runConfigurationProducer implementation="com.intellij.execution.junit.TestInClassConfigurationProducer"/>
    <runConfigurationProducer implementation="com.intellij.execution.junit.UniqueIdConfigurationProducer"/>
    <!-- JavaAnalysisPlugin.xml 测试相关 deadCode 未使用到的代码 -->
    <deadCode implementation="com.intellij.execution.junit2.inspection.JUnitEntryPoint"/>
    <!-- LangExtensionPoints.xml -->
    <cantBeStatic implementation="com.intellij.execution.junit2.inspection.JUnitCantBeStaticExtension" />
    <!-- JavaPsiPlugin.xml -->
    <testFramework implementation="com.intellij.execution.junit.JUnit3Framework"/>
    <testFramework implementation="com.intellij.execution.junit.JUnit5Framework" id="junit5" order="before junit4"/>
    <testFramework implementation="com.intellij.execution.junit.JUnit4Framework" id="junit4"/>
    <!-- LangExtensionPoints.xml -->
    <configurationType implementation="com.intellij.execution.junit.JUnitConfigurationType"/>
    <!-- JavaPlugin.xml -->
    <library.dependencyScopeSuggester implementation="com.intellij.execution.junit.JUnitDependencyScopeSuggester"/>
    <!-- ExternalSystemExtensionPoints.xml -->
    <externalSystem.runConfigurationImporter implementation="com.intellij.execution.junit.JUnitRunConfigurationImporter"/>
    <!-- LangExtensionPoints.xml beanClass类型的扩展 用于注入属性 -->
    <stacktrace.fold substring="at org.junit.internal.runners."/>
    <stacktrace.fold substring="at org.junit.runners."/>
    <stacktrace.fold substring="at org.junit.runner.JUnitCore."/>
    <stacktrace.fold substring="at org.junit.rules."/>
    <stacktrace.fold substring="at org.junit.Assert.fail("/>
    <stacktrace.fold substring="at org.junit.Assert.failNotSame("/>
    <stacktrace.fold substring="at org.junit.Assert.failSame("/>
    <stacktrace.fold substring="at junit.framework.Assert.assert"/>
    <stacktrace.fold substring="at junit.framework.Assert.fail"/>
    <stacktrace.fold substring="at junit.framework.TestCase.assert"/>
    <stacktrace.fold substring="at org.junit.Assert.internalArrayEquals("/>
    <stacktrace.fold substring="at org.junit.internal.ComparisonCriteria.arrayEquals("/>
    <stacktrace.fold substring="at org.junit.Assert.assert"/>
    <stacktrace.fold substring="at com.intellij.junit3."/>
    <stacktrace.fold substring="at com.intellij.junit4."/>
    <stacktrace.fold substring="at com.intellij.junit5."/>
    <stacktrace.fold substring="at com.intellij.rt.junit."/>
    <stacktrace.fold substring="at junit.framework.TestSuite.run"/>
    <stacktrace.fold substring="at junit.framework.TestCase.run"/>
    <stacktrace.fold substring="at junit.framework.TestResult"/>
    <stacktrace.fold substring="at org.junit.platform."/>
    <stacktrace.fold substring="at org.junit.jupiter."/>
    <stacktrace.fold substring="at org.junit.vintage."/>
    <!-- LangExtensionPoints.xml 重要 -->
    <programRunner implementation="com.intellij.execution.junit.JUnitDebuggerRunner"/>
    <!-- JavaPlugin.xml -->
    <codeInsight.externalLibraryResolver implementation="com.intellij.execution.junit.codeInsight.JUnitExternalLibraryResolver"/>
    <codeInsight.externalLibraryResolver implementation="com.intellij.execution.junit.codeInsight.JUnit5ExternalLibraryResolver"/>
    <!-- 当前插件定义的扩展 -->
    <junitListener implementation="com.intellij.junit4.JUnitTestDiscoveryListener"/>
    <!-- LangExtensionPoints.xml -->
    <runConfigurationProducer implementation="com.intellij.execution.junit.testDiscovery.JUnitTestDiscoveryConfigurationProducer"/>
    <!-- 当前插件定义的扩展 -->
    <testDiscoveryProducer implementation="com.intellij.execution.testDiscovery.LocalTestDiscoveryProducer"/>
    <testDiscoveryProducer implementation="com.intellij.execution.testDiscovery.IntellijTestDiscoveryProducer"/>
    <!-- LangExtensionPoints.xml -->
    <implicitUsageProvider implementation="com.intellij.execution.junit2.inspection.JUnitImplicitUsageProvider"/>
    <!-- JavaPlugin.xml -->
    <predefinedMigrationMapProvider implementation="com.intellij.execution.junit2.refactoring.JUnit5Migration"/>
    <!-- CoreImpl.xml -->
    <psi.referenceContributor implementation="com.intellij.execution.junit.codeInsight.references.JUnitReferenceContributor"/>

    <!-- 自定义java代码校验，可以对目标代码打红波浪线提示错误 -->
    <localInspection groupPath="Java" language="JAVA" shortName="JUnit5MalformedParameterized" bundle="messages.JUnitBundle"
                     key="junit5.valid.parameterized.configuration.display.name"
                     groupBundle="messages.InspectionsBundle" groupKey="group.names.junit.issues" enabledByDefault="true" level="WARNING"
                     implementationClass="com.intellij.execution.junit.codeInsight.JUnit5MalformedParameterizedInspection"/>
    <localInspection groupPath="Java" language="JAVA" shortName="JUnit5MalformedRepeated" bundle="messages.JUnitBundle"
                     key="junit5.malformed.repeated.test.display.name"
                     groupBundle="messages.InspectionsBundle" groupKey="group.names.junit.issues" enabledByDefault="true" level="WARNING"
                     implementationClass="com.intellij.execution.junit.codeInsight.JUnit5MalformedRepeatedTestInspection"/>

    <localInspection groupPath="Java" language="JVM" shortName="JUnit5MalformedNestedClass" bundle="messages.JUnitBundle"
                     key="junit5.nested.test.display.name"
                     groupBundle="messages.InspectionsBundle" groupKey="group.names.junit.issues" enabledByDefault="true" level="WARNING"
                     implementationClass="com.intellij.execution.junit.codeInsight.JUnit5MalformedNestedClassInspection"/>

    <!-- LangExtensionPoints.xml -->
    <runDashboardCustomizer implementation="com.intellij.execution.junit.JUnitRunDashboardCustomizer"
                            order="before commonJavaCustomizer"/>
  </extensions>
  ```
