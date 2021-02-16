---
title: linux录音说明
copyright: true
mathjax: false
date: 2021-02-16 21:41:04
categories:
    - 录音
tags:
    - linux
    - arecord
    - sox
    - pulseaudio
---
通过 arecord, sox, pulseaudio来实现麦克风录音和系统内录音(声卡输出录音)

<!-- more -->

## 1. 麦克风录音

一般发行版都带有 arecord， 连上麦克风即可，一般会用到8bit(非立体音)或16bit(立体音)

### 1.1 8bit

```
~:arecord ./demo.wav
```
录音到 demo.wav， 使用ctrl+c 可以结束录制

### 1.2 播放
```
~:aplay demo.wav
```
提供一个简单的命令行播放界面

### 1.3 16bit

```
~:arecord -f cd demo.wav
```

## 2. sox

一般 sox 主要用于系统内录音和音频合成。
sox可能需要单独安装

### 2.1 系统内录音
系统内录音需要 pulseaudio 支持，需要安装。

首先要找到系统内声音的输出声卡，需要 pulseaudio 工具集的 pacmd 命令

```
~:pacmd list
```
声卡的输出信息一般包含特征 `name:.*.monitor`， 然后我们取出其中的字段即可
```
~:pacmd list | grep -e 'name:.*.monitor' | sed -e 's/\s*name: <//' | sed -e 's/>//'
```

找到声卡后，这里距离alsa_output.pci-0000_00_1f.3.analog-stereo.monitor，使用parec回放声卡，使用管道定向到sox，并使用后台进程
```
~:parec -d alsa_output.pci-0000_00_1f.3.analog-stereo.monitor|sox -t raw -r 44100 -e signed-integer -L -b 16 -c 2 - demo6.wav &
```

### 2.2 音频合成

由于使用了 kdenlive，所以这里只列出最简单的合成命令

sox -m *1.wav *2.wav *3.wav：音频文件合并成一个音频文件，文件长度和较长的音频一样
