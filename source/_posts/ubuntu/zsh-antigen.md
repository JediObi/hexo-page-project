---
title: zsh-antigen
copyright: true
date: 2019-07-29 11:35:06
categories:
    - ubuntu
tags:
    - ubuntu
    - zsh
    - antigen
---
antigen是zsh的一个插件，可以方便的管理zsh的各种插件，比如oh-my-zsh和一些主题，比如pwerlevel9k。
插件只需要提供git仓库名即可。

<!-- more -->

**env: zsh installed**

### **1. 下载 antigen.zsh**

```shell
~:pwd
/home/user1
~:curl -L git.io/antigen > antigen.zsh
```

### **2. 新建.zshrc**

```shell
POWERLEVEL9K_INSTALLATION_PATH=$ANTIGEN_BUNDLES/bhilburn/powerlevel9k
HIST_STAMPS="yyyy-mm-dd"

source /home/nomq/antigen.zsh

# 加载oh-my-zsh库
antigen use oh-my-zsh

# 加载原版oh-my-zsh中的功能(robbyrussell's oh-my-zsh).
antigen bundle git
antigen bundle heroku
antigen bundle pip
antigen bundle lein
antigen bundle command-not-found

# 语法高亮功能
antigen bundle zsh-users/zsh-syntax-highlighting

# 代码提示功能
antigen bundle zsh-users/zsh-autosuggestions

# 自动补全功能
antigen bundle zsh-users/zsh-completions

# 加载主题
antigen theme robbyrussell

antigen theme bhilburn/powerlevel9k powerlevel9k
# 保存更改
antigen apply
```

### **3. 使用antigen下载并应用以上插件和主题**

```
~:zsh
```

### **4. 生成**

