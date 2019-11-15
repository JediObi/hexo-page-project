---
title: (1) quick start (1) init project
date: 2019-07-23 22:01:07
copyright: true
categories:
    - node
    - react
tags:
    - node
    - react
    - webpack
---
react 快速开始    
初始化项目
webpack4

<!-- more -->

the following steps will lead you create a new node project.
the final tree

```
.
└── package.json

```

### **1. init a project**
```
~:mkdir lesson1
~:cd lesson1
~:npm init
```
`npm init` will generate `package.json` in lesson1/. 

+ #### 1.1 package.json

  ```json
  {
    "name": "lesson1",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1"
    },
    "author": "",
    "license": "ISC"
  }
  ```
  `package.json` file manages the javascript packages or modules like maven pom.xml. Now add `webpack` to our project , `name` and `version` specification of it like the followting code:

+ #### 1.2 command
  
  ```
  ~:npm install --save-dev webpack
  ~:npm install --save-dev webpack-cli
  ```

+ #### 1.3 package.json
  
  ```json
  {
    "name": "lesson1",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
      "test": "echo \"Error: no test specified\" && exit 1"
    },
    "author": "",
    "license": "ISC",
    "devDependencies": {
      "webpack": "^4.41.2",
      "webpack-cli": "^3.3.10"
    }
  }
  ```

+ #### 1.4 this is the develop dependencies
    
  ```json
  "devDependencies": {
      "webpack": "^4.41.2",
      "webpack-cli": "^3.3.10"
  }
  ```
  `--save or -S`: if we don't use this command, we have to add the dependencies manually. This command will add packages to `dependencies`.
  `--save-dev or -D`: it's similar to `--save`, but it will add packages to `devDependencies`.
  dev means we just use these packages in development, and in our final product, some of the packages we don't need such like webpack, and some will be compiled into a more advanced file such like jQuery. 
