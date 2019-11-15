---
title: (8) quick start (8) loaders and hash
date: 2019-07-23 22:08:07
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
webpack默认只能处理js文件，其他如css/图片/文件等资源文件，webpack需要引入相关插件才能处理。     
由于浏览器缓存存在，所以为打包后的文件名加入hash，以确保浏览器加载最新的资源文件。

<!-- more -->

### **1. loaders**
previously on:
webpack can't process file if it is not a javascript file. So we must install different loaders for different types.

#### **1.1 loaders list**

```js
babel-loader // for es6 and jsx language
css-loader style-loder // for css
url-loader // for images
file-loader // for other files, and url-loader depends on it.
```

#### **1.2. webpack.config.js**

+ ##### 1.2.1 original loaders in webpack.config.js

    ```js
    ...
    module.exports = {
        entry:  ...,
        output: {...},
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
        plugins:[...],
    }
    ```
    we have to add a file-loader to process other files.
    ```js
    { 
        exclude: [/\.js$/,/\.html$/,/\.json$/],
        loader: 'file-loader',
        options: {
            name: 'static/media/[name].[ext]',
        },
    },
    ```
    But this loader may process images which will cause a confict to url-loader.
+ ##### 1.2.2 new config
    ```js
    ...
    module.exports = {
        entry:  ...,
        output: {...},
        module: {
            rules:[
                {
                    oneOf:[
                        { 
                            test: /\.(js|jsx)$/, 
                            loader: 'babel-loader',
                            query:
                            {
                                presets:['react']
                            },
                        },
                        { 
                            test: /\.css$/, 
                            loader: "style-loader!css-loader" },
                        
                        {
                            test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
                            //loader: require.resolve('url-loader'),
                            loader: 'url-loader',
                            options: {
                            limit: 10000,
                            name: 'static/media/[name].[ext]',
                            },
                        },
                        {
                            exclude: [/\.js$/,/\.html$/,/\.json$/],
                            //loader: require.resolve('url-loader'),
                            loader: 'file-loader',
                            options: {
                            name: 'static/media/[name].[ext]',
                            },
                        },
                    ],
                },
            ],
        },
        plugins:[...],
    }
    ```
    "oneOf" will traverse all following loaders until one will match the requirements. When no loader matches it will fall back to the "file" loader at the end of the loader list.

### **2. hash**

#### **2.1 why use hash**
Add hash code into file name. 
If a file content is changed, the next time to build it will change hash code in its name.  Browser's visit site will change which will cause a new request for this file. A long cache kept in browser if the hash code dosen't change.

#### **2.2. how to use hash**

+ ##### 2.2.1 production config

    ```js
    ...
    module.exports = {
        entry:  ...,
        output: {
            path: path.resolve(__dirname, 'build/'),
            filename: 'static/js/[name].[chunkhash:8].js'
        },
        module: {
            rules:[
                {
                    oneOf:[
                        { 
                            test: /\.(js|jsx)$/, 
                            ...
                        },
                        { 
                            test: /\.css$/, 
                            ...
                        },                    
                        {
                            test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
                            //loader: require.resolve('url-loader'),
                            loader: 'url-loader',
                            options: {
                            limit: 10000,
                            name: 'static/media/[name].[hash:8].[ext]',
                            },
                        },
                        {
                            exclude: [/\.js$/,/\.html$/,/\.json$/],
                            //loader: require.resolve('url-loader'),
                            loader: 'file-loader',
                            options: {
                            name: 'static/media/[name].[hash:8].[ext]',
                            },
                        },
                    ],
                },
            ],
        },
        plugins:[...],
    }
    ```

+ ##### 2.2.2 development config

    ```js
    ...
    module.exports = {
        entry:  ...,
        output: {
            path: path.resolve(__dirname, 'build/'),
            filename: 'static/js/bundle.js'
        },
        module: {
            rules:[
                {
                    oneOf:[
                        { 
                            test: /\.(js|jsx)$/, 
                            ...
                        },
                        { 
                            test: /\.css$/, 
                            ...
                        },                    
                        {
                            test: [/\.bmp$/, /\.gif$/, /\.jpe?g$/, /\.png$/],
                            //loader: require.resolve('url-loader'),
                            loader: 'url-loader',
                            options: {
                            limit: 10000,
                            name: 'static/media/[name].[hash:8].[ext]',
                            },
                        },
                        {
                            exclude: [/\.js$/,/\.html$/,/\.json$/],
                            //loader: require.resolve('url-loader'),
                            loader: 'file-loader',
                            options: {
                            name: 'static/media/[name].[hash:8].[ext]',
                            },
                        },

                    ],
                },
            ],
        },
        plugins:[...],
        devServer: {...},
    }
    ```
    css file need a plugin to add hash.

+ ##### 2.2.3 hash for css file

    install
    ```
    ~:npm install --save-dev extract-text-webpack-plugin
    ```
    webpack.config.js
    ```js
    ...
    const ExtractTextPlugin = require('extract-text-webpack-plugin');
    ...
    plugins:[
        ...
            new ExtractTextPlugin({
                filename: 'static/css/[name].[contenthash:8].css',
            }),
        ],
    ...
    ```