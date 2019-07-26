---
title: nvm
copyright: true
date: 2019-07-26 17:10:13
categories:
    - node
tags:
    - node
    - nvm
---
使用nvm管理node环境

<!-- more -->

### **1. install**

```
~:wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.0/install.sh | bash
```

### **2. install node**

```
~:nvm install 10
```

### **3. list**

```
~:nvm list
```

### **4. change version**

```
~:nvm use 6
```

### **5. set default version**

```
~:nvm alias default 10
```

### **6. change mirror**

```
~:npm config set registry http://registry.npm.taobao.org
```

### **7. nvm for zsh**

**.zshrc**
```shell
export NVM_DIR="/home/user/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```