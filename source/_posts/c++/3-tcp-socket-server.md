---
title: (3) tcp socket server
copyright: true
date: 2019-07-26 15:45:15
categories:
    - c++
tags:
    - c++
    - socket
---
c++ socket编程 服务端源码

<!-- more -->

```cpp
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <unistd.h>
#include <netinet/in.h>
#include <iostream>
#include <cerrno>
#include <cstdlib>
#include <cstring>


#define MAX_MSG_SIZE 256
#define SERVER_PORT  9987


#define BACKLOG 2


int GetServerAddr(char * addrname){
    std::cout << "please input server addr:" << std::endl;
    std::cin >> addrname;
    return 1;
(3) tcp socket server
}


int main(){
    std::cout<<"starting"<<std::endl;
    int sock_fd,client_fd; 
    struct sockaddr_in server_addr;
    struct sockaddr_in client_addr; 
    char msg[MAX_MSG_SIZE];

    // (1) create socket descriptor
    int server_sockfd=socket(AF_INET,SOCK_STREAM,0);
    // if failed to create socket descriptor
    if(server_sockfd<0)
    {
        std::cout << std::cerr << "socket Error:"<<strerror(errno)<<std::endl;
        exit(1);
    }

    // (2) init socket params
    socklen_t  addrlen=sizeof(struct sockaddr_in);
    bzero(&server_addr,addrlen);
    server_addr.sin_family=AF_INET;
    server_addr.sin_addr.s_addr=htonl(INADDR_ANY);
    server_addr.sin_port=htons(SERVER_PORT);

    // (3) bind
    if(bind(server_sockfd,(struct sockaddr*)&server_addr,sizeof(struct sockaddr_in))<0){ 
        std::cout << std::cerr << "Bind Error:"<< strerror(errno)<<std::endl;
        exit(1);
    }
    // (4) listen
    if(listen(server_sockfd,BACKLOG)<0){
        std::cout << std::cerr << "Listen Error:" << strerror(errno)<<std::endl;
        close(ser_sockfd);
        exit(1);
    }
    // wait for connection 
    while(1){
        // (5) accept
        int client_sockfd=accept(server_sockfd,(struct sockaddr*) &client_addr, &addrlen);
        if(client_sockfd<=0){
            std::cout << std::cerr << "Accept Error:" << strerror(errno)<<std::endl;
        }else{
            // (6) receieve and send
            recv(client_sockfd, msg, (size_t)MAX_MSG_SIZE, 0); 
            std::cout << "received a connection from:" << inet_ntoa(cli_addr.sin_addr)<<std::endl;
            std::cout << msg <<std::endl;
            strcpy(msg,"hi,I am server!");
            send(client_sockfd, msg, sizeof(msg),0); 
            close(client_sockfd);
        }
    }
    close(server_sockfd);
    return 0;
}
```
(1)  create socket descriptor
(2) init the socket params
(3) bind
(4) listen
(5) accept
(6) receieve and send
