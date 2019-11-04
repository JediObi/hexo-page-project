---
title: (3) quick start (3) html pages with javascript
date: 2019-07-23 22:03:07
copyright: true
categories:
    - node
    - react
tags:
    - node
    - react
---
react 快速开始    
对于webpack来说，html也是资源文件的一种，需要为webpack引入相关插件，webpack才会识别html，并且可以在编译时注入相关的js
webpack4

<!-- more -->

The following steps will show you how to use webpack to compile html pages.
We have built `bundle.js` in [quick start (2) webpack config](/p/71e4b19c1264), now we use it in html pages.

The final tree without node_modules:

```
.
├── package.json
├── package-lock.json
├── public
│   └── index.html
├── src
│   └── index.js
└── webpack.config.js
```

### **1. install html-webpack-plugin**

This plugin will use your html pages source files as templates to create pages in buiding step.
`~:npm install --save-dev html-webpack-plugin`

### **2. code sources**

**2.1 make direcotry for public items**

    ```
    ~:cd lesson1
    ~:mkdir public
    ```

**2.2. code html**

+ ##### 2.2.1 index.html
    ```html
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Document</title>
    </head>
    <body>
        <div id="root"></div>
    </body>
    </html>
    ```
**2.3 code javascript**
```js
// console.log('Hello, this is a test!');
document.write("hello, this is a test!");
```

### **3. html config in webpack.config.js**

This config will use public/index.html as a template to create build/index.html and inject `bundle.js` into build/index.html.

```js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry:  path.resolve(__dirname,'src/index.js'),
    output: {
        path: path.resolve(__dirname, 'build/static/js'),
        filename: 'bundle.js'
    },
    plugins:[
        new HtmlWebpackPlugin({
            inject: true, 
            template: path.resolve(__dirname, 'public/index.html'),
            filename: path.resolve(__dirname,'build/index.html'),
            minify:{
                removeAttributeQuotes: true,
                collapseWhitespace: true,
                removeRedundantAttributes: true,
                useShortDoctype: true,
                removeEmptyAttributes: true,
                removeStyleLinkTypeAttributes: true,
                keepClosingSlash: true,
                minifyJS: true,
                minifyCSS: true,
                minifyURLs: true,
            }
        }),
    ],
}
```
inject:`true` means inject all js at the bottom of the <body>

### **4. build project**

+ #### 4.1 command
  
    `~:npm run build`

+ #### 4.2 open build/index.html in browser