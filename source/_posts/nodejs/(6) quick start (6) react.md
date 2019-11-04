---
title: (6) quick start (6) react
date: 2019-07-23 22:06:07
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
webpack引入css插件处理css文件，webpack要处理的所有文件都是资源文件包括css，webpack要引入相应的插件才能正确处理不同类型的资源文件。

<!-- more -->

### **1. install modules**

+ #### 1.1 react
    
    `~:npm install --save-dev react`
    React core.

+ #### 1.2 react-dom
    
    `~:npm install --save-dev react-dom`
    ReactDOM for root render.

+ #### 1.3 babel-loader
  
    `~:npm install --save-dev babel-loader`
    Use jsx language in js or jsx. Must config in `webpack.config.js`.

+ #### 1.4 babel-core
  
    `~:npm install --save-dev babel-core`
    babel core

+ #### 1.5 babel-preset-react

    `~:npm install --save-dev babel-preset-react`
    babel for react. Must config in `webpack.config.js`.

### **2. webpack config**

+ #### 2.1 webpack.config.dev.js
  
    ```js
    const path = require('path');
    const HtmlWebpackPlugin = require('html-webpack-plugin');


    module.exports = {
        entry:  path.resolve(__dirname,'src/index.js'),
        output: {
            path: path.resolve(__dirname, 'build/static/js'),
            filename: 'bundle.js'
        },
        module: {
            loaders: [
                // css loader
                { test: /\.css$/, loader: "style-loader!css-loader" },
                // babel loader
                { 
                    test: /\.(js|jsx)$/, 
                    loader: "babel-loader",
                    // babel preset react
                    query:
                    {
                        presets:['react']
                    },
                },
            ]
        },
        plugins:[
            new HtmlWebpackPlugin({
                inject: true, //inject all js at the bottom of the body
                template: path.resolve(__dirname, 'public/index.html'), //source file
            }),
        ],
        devServer: {
            contentBase: path.resolve(__dirname, 'public'),
            historyApiFallback: false,
            inline:true,
            port:3000,
        },
    }
    ```

### **3. code js**

+ #### 3.1 index.js

    ```js
    import React, { Component } from 'react';
    import ReactDOM from 'react-dom';
    import './index.css'

    // require('./index.css')
    // document.write("hello, this is a test!");
    //console.log('Hello, this is a test!');
    class App extends Component{
        render(){
            return (
                <div>
                    First React DOM!
                </div>
            );
        }
    }

    ReactDOM.render(
        <App/>,
        document.getElementById('root')
    );
    ```
    `import React from 'react';` every component needs to import react core module `React`.
    `import ReactDOM from 'react-dom';` if you want to render a component in your html page you have to import ReactDOM and use it.

### **4 run**

+ #### 4.1 command

    `~:npm start`

