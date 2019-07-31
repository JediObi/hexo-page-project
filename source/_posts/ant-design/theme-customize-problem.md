---
title: theme customize problem
copyright: true
date: 2019-07-31 12:03:27
categories:
    - ant design
tags:
    - ant design
    - nodejs
    - react
---
ant design官方教程里换主题的代码api过时，需要使用新的api。

<!-- more -->

One API in `react-app-rewire-less` has been changed in the last version.
It now becomes to `withLoaderOptions(Object): function(config,env)`.
`config-overrides.js`
```
 const { injectBabelPlugin } = require('react-app-rewired');
 const rewireLess = require('react-app-rewire-less');

  module.exports = function override(config, env) {
     config = injectBabelPlugin(['import', { libraryName: 'antd', style: 'css' }], config);
     config = injectBabelPlugin(['import', { libraryName: 'antd', style: true }], config);
     config = rewireLess.withLoaderOptions({
           modifyVars: { "@primary-color": "#1DA57A" },
       })(config, env);
    return config;
  };
```
the old API is 
```
config = rewireLess(config, env, { 
       modifyVars: { '@primary-color': '#1DA57A', },
      });
```
