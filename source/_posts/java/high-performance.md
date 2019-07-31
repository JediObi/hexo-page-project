---
title: high performance
copyright: true
date: 2019-07-31 10:52:32
categories:
    - java
tags:
    - java
    - nio
---
java的nio，异步和非阻塞。

<!-- more -->

同步异步，关注的是通信机制。
比如程序A调用程序B，或者方法A调用方法B，
二者的通信机制，是由A去主动询问B执行完成（同步），还是B主动通知A执行完成（异步）。

同步是最基本的实现。
而异步则可以通过编程模型或者多线程实现。



阻塞非阻塞，关注的是程序或者线程的状态。
A调用B，A在B执行过程中的状态，A什么都不干等待B的结果（阻塞），A调用之后不等待B的结果继续执行A自己的任务（非阻塞）。

对于线程来说，阻塞意味着失去CPU使用权，浪费了计算资源，而且线程本身也是昂贵的计算资源，所以阻塞是影响性能的关键。

使用异步可以实现非阻塞。

以I/O为例，程序调用OS做I/O操作


(1)多线程实现的异步非阻塞
首先一个连接一个线程是无可后非的。

但是当阻塞I/O出现时严重影响体验和性能。

1，阻塞操作转移到别的线程，带来良好体验。

对于java web俩说，每个连接一个线程，因此不可能让连接线程阻塞，
阻塞操作转移之后，还有一个好处，连接线程因为不会阻塞，所以执行完之后就会释放，资源能够及时使用

2，I/O操作绕过CPU，充分利用资源，

java nio
使用额外轮询线程，将阻塞转移到其他线程，带来良好体验，
但是否绕过cpu不得而知
多个连接线程 ，一个轮询线程，连接线程中的I/O注册到轮询线程并交付OS，
由轮询线程轮询I/O状态

java nio2
使用异步，
由OS通知I/O完成，带来良好体验，同时使用DMA，
充分利用资源。
多个连接线程，连接线程中的I/O使用OS和DMA，
不会造成阻塞，由OS通知链接线程


JAVA High Performance-01: Blocking and Asynchronous

Synchronous and Asynchronous, 
they focus on the communication mechanism. Funcion A call function B, 
A doing nothing but polling B for result,that is Synchronous mechanism. 
If A doesn't polling B, B will notify A with the result, 
it is the Asynchronous mechanism.

Blocking and Non-Blocking, 
they focus on the working state. Function A call function B, 
A doing nothing but waiting for the result from B, that is Blocking. 
If A doesn't waiting for B, that is Non-Blocking.


(1)In java web, 
every connection would have a thread.If a connection thread is blocked, 
UE will be very bad. So blocking block must be moved out of connection thread. 
But when will the block finish? Conneciton thread must polling the wroking thread. 
Polling is also a blocking block. 
(2)It means we must have other threads to do blocking work. 
Threads and CPUs are expensive computing resources in a system, a thread must work on cpu, 
if it was blocked,it will be suspended and other program can't use this thread before released. 
In JAVA nio, it uses a Selector thread do polling for every connection thread.It create good UE.

(3)But working thread still hold threads, but the max count of threads is a system is the bottleneck. 
I/O should get round the CPU. In JAVA nio2, it uses DMA to do I/O, and the OS will notify connection thread.
