---
title: (7) quick start (7) images and url loader
date: 2019-07-23 22:07:07
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
webpack引入url插件处理图片资源文件。        
图片url可能需要特殊处理，本地调试和生产打包用到的服务器路径都不相同，用url插件可以根据环境替换图片资源url域名。

<!-- more -->

### **1. directory tree**

```
.
├── package.json
├── package-lock.json
├── public
│   └── index.html
├── README.md
├── src
│   ├── App.css
│   ├── App.js
│   ├── img
│   │   └── test.jpg
│   └── index.js
├── webpack.config.dev.js
└── webpack.config.js
```

### **2. url loader**

+ #### 2.1 url-loader

  1) help webpack process images during building.
  2) change image url in js and css to build path.
    ```html
    <img src='./images/test.png'/> -> <img src='./static/media/test.png'/>
    ```

+ #### 2.2 install

    ```
    ~:npm install --save-dev url-loader file-loader
    ```
    url-loader depends on file-loader.

+ #### 2.3 webpack config

    webpack.config.js
    ```js
    ...
    module: {
            loaders: [
                { test: /\.css$/, loader: "style-loader!css-loader" },
                { 
                    test: /\.(js|jsx)$/, 
                    loader: "babel-loader",
                    query:
                    {
                        presets:['react']
                    },
                },
                {
                    test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
                    //loader: require.resolve('url-loader'),
                    loader: 'url-loader',
                    options: {
                    limit: 10000,
                    name: 'static/media/[name].[ext]',
                    },
                },
            ]
        },
    ...
    ```
    `limit: 10000`, images less than 10000 bytes will return a data URI instead of a path.

### **3. images**

+ #### 3.1 App.js

    import xxx from './xxx/xxx.ext';
    ```js
    import React, { Component } from 'react';
    import './App.css'
    import test_jpg from './img/test.jpg';

    class App extends Component{

        render(){
            return (
                <div>
                <img src={test_jpg} alt='back'/>
                </div>
            );
        }
    }

    export default App;
    ```

+ #### 3.2 in css

    ```css
    body{
        /* background-image: url(./img/test.jpg); */
    }
    ```

### **4. build project**

+ #### 4.1 build

    `~:npm run build`

+ #### 4.2 debug

    `~:npm start`