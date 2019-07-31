---
title: material-ui theme和3阶色
copyright: true
date: 2019-07-31 19:02:31
categories:
    - reactjs
tags:
    - reactjs
    - material-ui
---
reactjs 组件库 material-ui theme设置。

<!-- more -->

自定义theme就能改变button的3阶渐变色。
以下是官方提供的lightBaseTheme.js
一个主题就那么几个颜色，自己改个颜色就能看出效果，很方便定制。
根据官方demo还能实现更复杂的定制。
MyThemeLight.js
```js
import {
  cyan500, cyan700,
  pinkA200,
  grey100, grey300, grey400, grey500,
  white, darkBlack, fullBlack,
  } from 'material-ui/styles/colors';
  import {fade} from 'material-ui/utils/colorManipulator';
  import spacing from 'material-ui/styles/spacing';
  
  export default {
    spacing: spacing,
    fontFamily: 'Roboto, sans-serif',
    palette: {
      primary1Color: cyan500,
      primary2Color: cyan700,
      primary3Color: grey400,
      accent1Color: pinkA200,
      accent2Color: grey100,
      accent3Color: grey500,
      textColor: darkBlack,
      alternateTextColor: white,
      canvasColor: white,
      borderColor: grey300,
      disabledColor: fade(darkBlack, 0.3),
      pickerHeaderColor: cyan500,
      clockCircleColor: fade(darkBlack, 0.07),
      shadowColor: fullBlack,
    },
  };
```
```
import React, { Component } from 'react';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import getMuiTheme from 'material-ui/styles/getMuiTheme';
import RaisedButton from 'material-ui/RaisedButton';
import myThemeLight from './MyThemeLight';

class App extends Component {
  render() {
    return (
      <MuiThemeProvider muiTheme={getMuiTheme(myThemeLight)}>
      <RaisedButton label="Primary" primary={true}/>
      </MuiThemeProvider>
    );
  }
}

export default App;
```