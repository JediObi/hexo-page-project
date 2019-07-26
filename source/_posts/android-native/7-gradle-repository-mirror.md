---
title: 7 - gradle repository mirror
copyright: true
date: 2019-07-26 16:49:31
categories:
    - Android native
tags:
    - Android
    - gradle
---
gradle配置maven源。

<!-- more -->

### **1. 对于当前项目**

+ #### 1.1 build.gradle

    ```gradle
    buildscript {
        repositories {
            maven {
                url 'http://maven.aliyun.com/nexus/content/groups/public/'
            }
            maven {
                url 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
            }
        }
    }

    allprojects {
        repositories {
            maven {
                url 'http://maven.aliyun.com/nexus/content/groups/public/'
            }
            maven {
                url 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
            }
        }
    }
    ```

### **2. 全局gradle**

**~/.gradle/init.gradle**

    ```gradle
    allprojects{
        repositories {
            def REPOSITORY_URL = 'http://maven.aliyun.com/nexus/content/groups/public/'
            all { ArtifactRepository repo ->
                if(repo instanceof MavenArtifactRepository){
                    def url = repo.url.toString()
                    if (url.startsWith('https://repo1.maven.org/maven2') || url.startsWith('https://jcenter.bintray.com/')) {
                        project.logger.lifecycle "Repository ${repo.url} replaced by $REPOSITORY_URL."
                        remove repo
                    }
                }
            }
            maven {
                url REPOSITORY_URL
            }
        }
    }
    ```
