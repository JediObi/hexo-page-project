---
title: react-helmet customize html head
copyright: true
date: 2019-07-31 19:05:13
categories:
    - reactjs
tags:
    - reactjs
---
单页面应用，html的header是固定的，使用react-helmet可以在不同的页面渲染不同的header。

<!-- more -->

### (1) react-helmet

+ #### why use it

    This module let you customize html page head title.

+ #### install

    `~:npm install react-helmet --save-dev`

+ #### how to use

    ```js
    import {Helmet} from 'react-helmet';
    ...
    render(){
            return (
                <div>
                <Helmet>
                    <title>My title</title>
                </Helmet>
                <RaisedButton label="Primary" backgroundColor="#00BCD4" primary={false}/>
                <RaisedButton label="Primary" primary={true} onClick={()=>this.handleClick()}/>
                </div>
            );
    }
    ```
    The code above will convert the `<title>` in html page. `<Helmet>` will be rendered from top to bottom. The last `<Helmet>` rendered will show on browser's tab.

### (2) example

+ #### create-react-app
    
    create project

+ #### insall react-helmet

    install module.
+ #### common head title component

    html-head.js
    ```js
    import React, {Component} from 'react';
    import {Helmet} from 'react-helmet';

    class _Header extends Component {
        render() {
            return (
                <div>
                    <Helmet>
                        <meta charSet="utf-8"/>
                        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
                        <meta name="theme-color" content="#000000"/>
                    </Helmet>
                </div>
            );
        }
    }

    export default _Header;
    ```

+ #### a component with it's own head title

    App.js
    ```js
    import React, {Component} from 'react';
    import {Helmet} from 'react-helmet';

    class App extends Component {
        render() {
            return (
                <div>
                    <Helmet>
                        <title>stage title</title>
                    </Helmet>
                    <p>test stage</p>
                </div>
            );
        }
    }

    export default App;
    ```

+ #### entry

    ```js
    import React from 'react';
    import ReactDOM from 'react-dom';
    import './index.css';
    import App from './App';
    import registerServiceWorker from './registerServiceWorker';
    import _Header from './html-head';

    ReactDOM.render(
        (
            <div>
                <_Header/>
                <App/>
            </div>
        ), 
        document.getElementById('root'));
    registerServiceWorker();
    ```