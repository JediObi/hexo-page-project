---
title: 管理端框架-layui (1) - 弹窗返回数据到调用者窗口
copyright: true
date: 2019-07-31 10:57:51
categories:
    - java
tags:
    - java
    - java
    - jqgrid
---
layui和jqgrid的使用实践。

<!-- more -->

### (1) 调用者调用以下函数

+ js
    ```js
    function openView(title, width, height, url, winname, closeFunc) {
        // //判断id值是否存在
        // if (id == undefined || id == '') {
        //     layer.alert('id获取异常', {icon: 5, skin: 'layer-ext-moon'});
        //     return;
        // }

        //判断url中是否已经挂参
        if (url.indexOf("?") == -1) {
            url = url + "?winname=" + winname;
        } else {
            url = url + "&winname=" + winname;
        }

        var index = parent.layer.open({
            // skin: 'layui-layer-molv',
            type: 2, //iframe 层
            title: title,
            scrollbar: false,
            fix: false, //不固定
            maxmin: true,
            area: [width, height],
            btn: ['确定'],
            yes: function (index, layero) {
                var data = window.parent[layero.find('iframe')[0]['name']].validateForm();
                $("#phone").val(data["phone"]);
                $("#phoneLabel").html(data["phone"]);
                $("#userId").val(data["userId"]);
                $("#realName").val(data["realName"]);
                $("#realNameLabel").html(data["realName"]);
                parent.layer.close(index);
            },
            end: closeFunc,
            content: url
        });
    }

    ```

+ 代码解析
  
   1. ` var data = window.parent[layero.find('iframe')[0]['name']].validateForm();`
  jquery通过iframe层找到弹窗dom，调用弹窗dom的 validateForm() 函数，在该函数中返回数据。

    2.
    ```js
                $("#phone").val(data["phone"]);
                $("#phoneLabel").html(data["phone"]);
                $("#userId").val(data["userId"]);
                $("#realName").val(data["realName"]);
                $("#realNameLabel").html(data["realName"]);
    ```
    为调用者页面上的dom设置值。

### (2) 弹窗页面 validateForm() 函数

```js
function validateForm() {
        var id = jQuery(jqGridId).jqGrid('getGridParam', 'selrow');
        var data = jQuery(jqGridId).getRowData(id);
        return data;
}
```
以上是jqgrid的表格数据获取方式。