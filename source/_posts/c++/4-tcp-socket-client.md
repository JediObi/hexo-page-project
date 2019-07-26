---
title: (4) tcp socket client
copyright: true
date: 2019-07-26 15:46:45
categories:
    - c++
tags:
    - c++
    - socket
---
c++ socket编程，客户端源码。

<!-- more -->

```cpp
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netinet/in.h>

#include <iostream>
#include <cerrno>
#include <cstring>
#include <cstdlib>


#define MAX_MSG_SIZE 256
#define SERVER_PORT  9987


int GetServerAddr(char * addrname){
    std::cout << "please input server addr:" << std::endl;
    std::cin >> addrname;
    return 1;
}


int main(){
    int cli_sockfd;
    int addrlen;
    char seraddr[14];
    struct sockaddr_in ser_addr, cli_addr;
    char msg[MAX_MSG_SIZE];/* 缓冲区*/

    GetServerAddr(seraddr);
   
    // (1)  create socket descriptor
    cli_sockfd=socket(AF_INET,SOCK_STREAM,0);

    if(cli_sockfd<0){
        std::cout << std::cerr << "socket Error:"<<strerror(errno)<<std::endl;
        exit(1);
    }

    // (2) init the client socket params
    addrlen=sizeof(struct sockaddr_in);
    bzero(&ser_addr,addrlen);
    cli_addr.sin_family=AF_INET;
    cli_addr.sin_addr.s_addr=htonl(INADDR_ANY);
    cli_addr.sin_port=0;

    // (3) bind
    if(bind(cli_sockfd,(struct sockaddr*)&cli_addr,addrlen)<0){
        std::cout << std::cerr << "Bind Error:"<< strerror(errno)<<std::endl;
        exit(1);
    }
    // (4) init the server connection params
    addrlen=sizeof(struct sockaddr_in);
    bzero(&ser_addr,addrlen);
    ser_addr.sin_family=AF_INET;
    ser_addr.sin_addr.s_addr=inet_addr(seraddr);
    ser_addr.sin_port=htons(SERVER_PORT);
    // (5) connect to the server
    if(connect(cli_sockfd,(struct sockaddr*)&ser_addr, addrlen)!=0)/*请求连接*/
    {
        std::cout << std::cerr << "Connect Error:" << strerror(errno)<<std::endl;
        close(cli_sockfd);
        exit(1);
    }
    // (6) receieve and send
    strcpy(msg,"hi,I am client!");
    send(cli_sockfd, msg, sizeof(msg),0);
    recv(cli_sockfd, msg, MAX_MSG_SIZE,0); 
    std::cout << msg <<std::endl;
    close(cli_sockfd);

    return 0;
}
```
(1) create socket descriptor
(2) init the socket params
(3) bind
(4) init the server connection params
(5) connect to server
(6) receieve and send
