---
title: shell expect scp file
copyright: true
date: 2019-07-31 14:10:04
categories:
    - shell
tags:
    - shell
    - ssh
    - scp
---
scp下载远端指定文件

<!-- more -->

use shell and expect to scp a file to a remote server

```shell
#!/bin/bash

#upload file or folder to server
#source scp_profile.sh

FILE_NAME=""
SERVER_HOST="123.123.123.123"
SERVER_PORT=123
LOGIN_USER="username"
PASSWORD="password"
UPLOAD_ROOT_FOLDER="/upload_path"

while getopts "f:" OPTS; do
        case $OPTS in
                f)
                        FILE_NAME=$OPTARG
                        ;;
                ?)
                        echo "Error"
                        exit 1
                        ;;
        esac
done

if [ ! -n "$FILE_NAME" ]; then
        echo "Error!"
        echo "File name must be figured out!"   
        exit 1
fi

if [ ! -f "${FILE_NAME}" ]; then
        echo "Error!"
        echo "${FILE_NAME} doesn't exist in current folder!"
        echo 1
fi

/usr/bin/expect <<-EOF
set timeout 30
spawn scp -P${SERVER_PORT} -r ${FILE_NAME} ${LOGIN_USER}@${SERVER_HOST}:${UPLOAD_ROOT_FOLDER}/
expect "password:"
send "${PASSWORD}\r"
expect eof
EOF
```
