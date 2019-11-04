---
title: (12) open browser after webpack compile
date: 2019-07-23 22:12:07
copyright: true
categories:
    - node
    - react
tags:
    - node
    - react
    - webpack
---
调试服务器启动后自动打开浏览器展示首页。        
npm start调用的是webpack的插件，为webpack安装相关插件，可以在服务启动后自动打开指定浏览器访问指定的页面。
webpack4

<!-- more -->

## **(12) open browser after webpack compile**


+ webpack.config.dev.js

    ```js
    const path = require('path');
    const HtmlWebpackPlugin = require('html-webpack-plugin');

    const host_port = 3000;

    module.exports = {
        entry:  path.resolve(__dirname,'src/index.js'),
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
                            loader: 'babel-loader',
                            query:
                            {
                                presets:['react']
                            },
                        },
                        { 
                            test: /\.css$/, 
                            loader: "style-loader!css-loader"
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
            port:host_port,
        },
    }
    ```

+ package.json scripts

    ```json
    "scripts": {
        "start": "webpack-dev-server --config webpack.config.dev.js --open"
    },
    ```

+ run 

    `~:npm start`