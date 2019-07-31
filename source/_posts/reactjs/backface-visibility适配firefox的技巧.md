---
title: backface-visibility适配firefox的技巧
copyright: true
date: 2019-07-31 18:53:57
categories:
    - reactjs
tags:
    - reactjs
    - backface-visibility
    - css3
---
css3 backface-visibility使用技巧

<!-- more -->

```
transform-style:preserve-3d;
transfrom:rotateY(180deg);
backface-visibility:hidden;
```
以上三个样式可以对进行3d旋转，并且隐藏组件的背面，因此当组件的背面朝向屏幕时组件会被隐藏。
但是chrome、firefox、ie对三者的解析是不一样的。
(1) chrome
-->继承transform
chrome默认所有后代组件都会继承父组件的transform特性，因此，后代组件在做旋转时，会在它外层组件旋转的基础上再做旋转。
(2) firefox
-->继承transform
firefox默认transform不继承，父组件必须显式使用preserve-3d时，子组件才会继承父组件的transform特性，并且孙子及之后的不会继承，如果有需要就必须逐层添加preserve-3d。
(3) ie
-->继承transform
ie全系列都不支持preserve-3d，因此它的组件不会继承父组件的transform。edge才开始支持preserve-3d。
(4) 使用preserve-3d带来的问题
该属性可能会使absolute position失效。在使用absolute时，组件默认会参照最靠近的一个absolute组件，这意味这如果组件的父组件是relative的，那么子组件就会越过父组件。但父组件使用了preserve-3d之后，子组件即使是absolute也会变成relative。
(5) 适配技巧
规划好组件的层级结构，避免在复杂的层级结构中出现联动的特效。像absolute和preserve-3d冲突的问题，可以把子组件提出变成兄弟，并在外层重新添加一层父组件。
(6) 关于ie的适配
不要适配它。
