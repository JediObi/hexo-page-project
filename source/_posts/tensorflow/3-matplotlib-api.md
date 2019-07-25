---
title: (3) matplotlib api
copyright: true
date: 2019-07-25 18:01:42
categories:
    - tensorflow
tags:
    - python
    - tensorflow
    - matplotlib
---
matplotlib 常用api

<!-- more -->

### (1) 点图 plot()

```python
x = [1,2,3]
y = [1,2,3]
plt.plot(x,y)
plt.show()
```

### (2) 柱形图 bar()

```python
x = [1,2,3]
y = [1,2,3]
plt.bar(x,y)
plt.show()
```

### (3) 分区

```python
x = [1,2,3]
y = [1,2,3]
plt.subplot(4,4,1) 
plt.plot(x,y)

x2 = [1,2,3]
y2 = [1,2,3]
plt.subplot(4,4,2)
plt.bar(x2,y2)
plt.show()
```

### (4) 刻度

1. 刻度

    ```python
    x = np.linspace(-np.pi, np.pi, 256,endpoint=True)
    y = np.sin(x)

    plt.plot(x, y)
    plt.xticks([-np.pi, -np.pi/2, 0, np.pi/2, np.pi])
    plt.yticks([-1, 0, 1])
    plt.show()
    ```

2. 刻度替换

    此处替换为 LaTex
    ```python
    x = np.linspace(-np.pi, np.pi, 256,endpoint=True)
    y = np.sin(x)

    plt.plot(x, y)
    plt.xticks([-np.pi, -np.pi/2, 0, np.pi/2, np.pi],
            [r'$-\pi$', r'$-\pi/2$', r'$0$', r'$+\pi/2$', r'$+\pi$'])
    plt.yticks([-1, 0, 1],
            [r'$-1$', r'$0$', r'$+1$'])
    plt.show()
    ```

### (5) 坐标轴上下限

```python
plt.ylim(-1.0, 1.0)
```

### (6) 线条颜色, 粗细, 样式

```python
# 可以简写颜色和样式, 比如bo 表示蓝色blue和实心圆样式, 样式还有很多可以取查表
plot(x, y, color="blue", linewidth=2.5, linestyle="-")
```

### (7) 坐标轴 脊柱 spines

通过隐藏矩形边框的top和right,把left和bottom位移就可以构造出象限坐标轴, 脊柱
```python
...
ax = plt.gca()
ax.spines['right'].set_color('none')
ax.spines['top'].set_color('none')
ax.xaxis.set_ticks_position('bottom')
ax.spines['bottom'].set_position(('data',0))
ax.yaxis.set_ticks_position('left')
ax.spines['left'].set_position(('data',0))
...
```

### (8) 坐标轴 名称 和 图例

1. 坐标轴名称

    ```pyhton
    plt.xlabel("xaxis")
    plt.ylabel("yaxis")
    ```

2. 图例

    + 为所有plot/bar/scatter绘制到图例

        ```python
        # 把已有的作为对象
        plt.plot(x, y, label='sin')
        plt.plot(x, y2, label='cos')
        plt.legend(loc='upper left')
        ```

    + 为指定的对象绘制图例

        注意 对象命名后加上"`,`"
        ```python
        mysin, = plt.plot(x, y, label='sin')
        mycos, = plt.plot(x, y2, label='cos')
        plt.legend([mysin], ['mysin'], loc='upper left')
        ```

    + 为特殊点加注释

        ```python
        # 选取x轴一点 
        t = 2*np.pi/3
        # 画出该点垂直直线与sin曲线的交点
        plt.plot([t,t],[0,np.sin(t)],color='red',linewidth=2.5,linestyle='--')
        # 使用离散点api画出该点的sin函数坐标
        plt.scatter([t,],[np.sin(t),],50, color='red')
        # 注释, 第一个参数是注释内容, 第二个参数是坐标, arrowprops指定了箭头和弧度
        plt.annotate(r'$\sin(\frac{2\pi}{3})=\frac{\sqrt{3}}{2}$',
                    xy=(t, np.sin(t)), xycoords='data',
                    xytext=(+10, +30), textcoords='offset points', fontsize=16,
                    arrowprops=dict(arrowstyle="->", connectionstyle="arc3, rad=.2"))
        ```

    + 其他图像类型

        ```
        # 横向柱形图
        plt.barh()
        # 饼图
        plt.pie()
        # 等高图
        plt.contour()
        # 图片
        plt.imshow()
        # 颜色条
        plt.colorbar()
        # 3D等
        ```

    + 重要的api

    + figure()

        可以用于窗口属性设置
        ```python
        # num 图像数量
        # figsize 图片长宽
        # dpi 图片分辨率
        # 其他参数可以用到再查
        figure(num=None, figsize=None, dpi=None, facecolor=None, edgecolor=None, frameon=True, FigureClass=<class 'matplotlib.figure.Figure'>, clear=False, **kwargs)
        ```
