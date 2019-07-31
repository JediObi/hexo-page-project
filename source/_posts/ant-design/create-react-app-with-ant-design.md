---
title: create-react-app with ant design
copyright: true
date: 2019-07-31 12:00:57
categories:
    - ant design
tags:
    - ant design
    - nodejs
    - react
---
为react项目引入ant design。
ant design是一个组件库，提供了很多统一风格的组件。

<!-- more -->

(1) init project

create-react-app mydemo
npm install antd --save-dev

(2) install `react-app-rewired`

`create-react-app` has many configs preset, like webpack.config.js. 
`react-app-rewired` lead you to customize these configs.
change scripts in `package.json`firstly.

```
"scripts": {
-   "start": "react-scripts start",
+   "start": "react-app-rewired start",
-   "build": "react-scripts build",
+   "build": "react-app-rewired build",
-   "test": "react-scripts test --env=jsdom",
+   "test": "react-app-rewired test --env=jsdom",
+   "eject": "react-app-rewired eject"
}
```

then make new file named  `config-overrides.js` at the root of the project.
```
module.exports = function override(config, env) {
  return config;
};
```

(3)  install `babel-plugin-import`

A babel plugin for lazy loading components and styles.
`import {Button} from 'antd';` this import will load all modules in antd.

```
import Button from 'antd/lib/button';
import 'antd/lib/button/style'; // or antd/lib/button/style/css
```

Above is a lazy loading.
You have to make some configs in `config-overrides.js` then `import {Button} from 'antd';` becomes lazy loading.
code in `config-overrides.js`
```
+ const { injectBabelPlugin } = require('react-app-rewired');

  module.exports = function override(config, env) {
+   config = injectBabelPlugin(['import', { libraryName: 'antd', style: 'css' }], config);
    return config;
  };
```
Properties  `libraryName` and `style` lead it to load the corresponding css when loding a component.
Property `style` will import some global styles, if you don't need that, remove `style`. Then `import 'antd/dist/antd.css';` to override the global.

(4) customize themes

Antd used less for theme files, so a less loader is in need.
Here we install a less plugin for `react-app-rewired ` instead of webpack.
`npm install react-app-rewire-less --save-dev`
Then modify `config-overrides.js`.

```
  const { injectBabelPlugin } = require('react-app-rewired');
+ const rewireLess = require('react-app-rewire-less');

  module.exports = function override(config, env) {
-   config = injectBabelPlugin(['import', { libraryName: 'antd', style: 'css' }], config);
+   config = injectBabelPlugin(['import', { libraryName: 'antd', style: true }], config);
+   config = rewireLess.withLoaderOptions({
+         modifyVars: { "@primary-color": "#1DA57A" },
+     })(config, env);
    return config;
  };
```
Configs abobe make  code like "import "./style.less"" effective in js files. Value of propery `style` changed to `true`，this setting tell the loader to load less. And here use the api `modifyVars` of less to override the `primary-color` of ant design.
