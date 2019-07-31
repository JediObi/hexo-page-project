---
title: shell of sed to get log
copyright: true
date: 2019-07-31 14:02:39
categories:
    - shell
tags:
    - shell
    - sed
---
使用sed截取指定时间段内的日志。

<!-- more -->

tomcat log like 
```
2017-10-17 12:00:00 ...
2017-10-17 12:00:01 ...
2017-10-17 12:00:02 ...
2017-10-17 12:00:03 ...
```
+ command
+ 
`sed -n '[start_line_number[,end_line_number]] operation_command' file_name [>>stdout]`

+ line_number
+ 
`regex` like /^abc/
`number` 1~n
`$` ths last line

+ operation_command
+ 
`p` print out the content of the lines
`=` print the line number of the lines

#### (1) print  content

sed -n '/^12:00:00/ p' log.out
```
2017-10-17 12:00:00 ...
```

### (2) print line numbers

+ all numbers
  
    sed -n '/^12:00:00/, /^12:00:02/ =' log.out
    ```
    2
    3
    4
    ```

+ first line

    sed -n '/^12:00:00/, /^12:00:02/ =' log.out | sed -n '1p'

+ last line

    sed -n '/^12:00:00/, /^12:00:02/ =' log.out | sed -n '$p'

###(3) example 

+ get 12:00:00 to 12:00:02

    sed -n '/^12:00:00/, /^12:00:02/ p' log.out >> test.txt

(4) may be no line matched. use a shell

```shell
#!/bin/bash

LOG_FILE_PATH="/home/admin/app/apache-tomcat-8.0.36/logs/catalina.out"
#LOG_FILE_PATH="a"
HOST_IP=102
ORIGIN_START_LINE_TIME=""
ORIGIN_END_LINE_TIME=""
START_LINE=""
END_LINE=""
# get line time regex
while getopts "s:e" OPTS; do
	case $OPTS in
        	s)
			ORIGIN_START_LINE_TIME=$OPTARG
			;;
               	e)
			ORIGIN_END_LINE_TIME=$OPTARG
			;;
		?)
			echo "Error!"
			exit 1
			;;
	esac
done
START_LINE_TIME=$ORIGIN_START_LINE_TIME
END_LINE_TIME=$ORIGIN_END_LINE_TIME
####### test 1 begin #########
#echo "s is ${START_LINE_TIME}, e is ${END_LINE_TIME}"
#exit 1
####### test 1 end  #########

# start line must be figured out
if [ ! -n "$START_LINE_TIME" ]; then
	echo "Error!"
	echo "START_LINE_TIME must be figured out!"
	exit 1
fi

# use sed to find line number
# try to find start time. note double quotation in sed
START_LINE=`sed -n "/^.*${START_LINE_TIME}/ =" ${LOG_FILE_PATH} | sed -n '$p'`
# findStartLine start_line start_line_time
TIME_COUNTER=0
function findStartLine(){
	if (($START_LINE==-1)) && (($TIME_COUNTER < 3));then
		local LINE_TIME=$START_LINE_TIME
		# 12:30:00-->12:3
		LINE_TIME=${LINE_TIME:0:15}
		# find the last line number
		START_LINE=`sed -n "/^.*${LINE_TIME}/ =" ${LOG_FILE_PATH} | sed -n '$p'`
		if [ ! -n "$START_LINE" ];then
			START_LINE=-1
		fi
		# -10 minutes
		START_LINE_TIME=`date -d "$START_LINE_TIME 10 minute ago" +"%Y-%m-%d %H:%M:%S"`
		((TIME_COUNTER=$TIME_COUNTER+1))
		# check result
		findStartLine
	fi
}
# note that double quotation, because theres a space in "2017-10-17 12:00:00"
if [ ! -n "$START_LINE" ];then
	START_LINE=-1
fi
findStartLine
if (($START_LINE==-1));then
	START_TIME=`date -d "$ORIGIN_START_LINE_TIME 20 minute ago" +"%Y-%m-%d %H:%M"`
	echo "Error! No lines matched the START time at ${ORIGIN_START_LINE_TIME} (from ${START_TIME:0:15}0:00:000)."
	exit 1
fi
echo "start line is $START_LINE"

TIME_COUNTER=0
function findEndLine(){
	if (($END_LINE==-1)) && (($TIME_COUNTER < 3));then
		local LINE_TIME=$END_LINE_TIME
		# 12:30:00-->12:3
		LINE_TIME=${LINE_TIME:0:15}
                # find the last line number
		END_LINE=`sed -n "/^.*${LINE_TIME}/ =" ${LOG_FILE_PATH} | sed -n '$p'`
		if [ ! -n "$END_LINE" ];then
			END_LINE=-1
		fi
		# +10 minutes
		END_LINE_TIME=`date -d "$END_LINE_TIME 10 minute" +"%Y-%m-%d %H:%M:%S"`
		((TIME_COUNTER=$TIME_COUNTER+1))
		# check result
		findEndLine
	fi
}

if [ -n "$END_LINE_TIME" ]; then
	END_LINE=`sed -n "/^.*${END_LINE_TIME}/ =" ${LOG_FILE_PATH} | sed -n '$p'`
	if [ ! -n "$END_LINE" ];then
		END_LINE=-1
	fi
	findEndLine
else
	END_LINE=`wc -l ${LOG_FILE_PATH}`
fi

if (($END_LINE==-1)); then
	END_TIME=`date -d "$ORIGIN_END_LINE_TIME 20 minute" +"%Y-%m-%d %H:%M"`
	echo "Error! No lines matched with the END time at $ORIGIN_END_LINE_TIME (to ${END_TIME:0:15}9:59:999)."
	exit 1
fi
echo "end line is $END_LINE"

if (("$START_LINE">="$END_LINE"));then
	echo "no line matched"
	exit 1
fi

# generate file name
FILE_NAME_NUMBER=01
FILE_NAME="log_"`date +"%m%d"`"_${HOST_IP}"
function generateFileName(){
	if [ -f "${FILE_NAME}_${FILE_NAME_NUMBER}" ];then
		((FILE_NAME_NUMBER=${FILE_NAME_NUMBER}+1))
		FILE_NAME_NUMBER=`printf "%02d" ${FILE_NAME_NUMBER}`
		generateFileName
	fi
}
generateFileName
sed -n "${START_LINE},${END_LINE} p" ${LOG_FILE_PATH} >> ${FILE_NAME}_${FILE_NAME_NUMBER}
echo "All in ${FILE_NAME}_${FILE_NAME_NUMBER}"
```
