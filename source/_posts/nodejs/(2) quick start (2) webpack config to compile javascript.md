---
title: (2) quick start (2) webpack config to compile javascript
date: 2019-07-23 22:02:07
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
使用webpack编译和打包项目
webpack4

<!-- more -->


The following steps will show you how to use webpack.
We will configure `webpack.config.js` and compile source files to build the project. 

The final tree
```
.
├── package.json
├── package-lock.json
├── src
│   └── index.js
└── webpack.config.js
```

### **1. webpck compile**

#### **1.1. code js**

+ ##### 1.1.1 index.js
  
  ```js
  console.log('Hello, this is a test!');
  ```

#### **1.2. compile js**

We did [init project](p/b5df2e74aa20) and installed `webpack`.
`npm install` just install a package in current project directory.
`webpack` can be used as a command if it was installed in global.

+ ##### 1.2.1 install global
  
  `~:npm install -g webpack`
  `~:npm install -g webpack-cli`

+ ##### 1.2.2 use webpack to compile
  
  ```
  ~:webpack abc.js bundle.js
  ```
  It will compile abc.js and create bundle.js. We use bundle.js in index.html.

### **2. webpack.config.js**

We have too many compiling ruls with different source files and options.
So we have to simplify the webpack command rule.

And then we can just use `~:webpack` to instead of `~:webpack src/abc.js -o build/static/bundle.js`.

Put all webpack compiling rule in config file:

+ #### 2.1 create `webpack.config.js`
  
  ```js
  const path = require('path');

  module.exports = {
      entry: [
          './src/index.js'
      ],
      output: {
          path: path.resolve(__dirname, 'build/static/js'),
          filename: 'bundle.js'
      }
  }
  ```
  `__dirname`: is a environment variable of node, value is the project folder path.
  `entry`: webpack will analyze your entry file for dependencies to other files. These files (called modules) are included in your bundle.js too. webpack will give each module a unique id and save all modules accessible by id in the bundle.js file. Only the entry module is executed on startup. A small runtime provides the require function and executes the dependencies when required.
  `output`: webpack will create lesson1/build/bundle.js. All modules will be included in this file.

### **3. node script**

+ #### 3.1 package.json
    
  ```json
  {
    "name": "lesson1",
    "version": "1.0.0",
    "description": "",
    "main": "index.js",
    "scripts": {
      "test": "echo \"Error: no test specified\" &amp;&amp; exit 1",
      "build": "webpack"
    },
    "author": "",
    "license": "ISC",
    "devDependencies": {
      "html-webpack-plugin": "^3.2.0",
      "webpack": "^4.41.2",
      "webpack-cli": "^3.3.10"
    }
  }
  ```
  `~:npm run build`

+ #### 3.2 run bundle.js
    
  ```
  ~:cd build/static/js
  ~:node bundle.js
  Hello, this is a test!
  ```