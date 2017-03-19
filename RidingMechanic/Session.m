//
//  SessionController.m
//  IM
//
//  Created by Dezheng Wang on 01/25/17.
//  Copyright (c) 2017 Dezheng Wang. All rights reserved.
//

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

#import "Session.h"
#import "SendCommand.h"

#define MAX_MSG_CHUNK 1024

@interface Session () {
    int sktfd;
    //  NSTimer * recvTimer;
    char *recvBuf;
    int recvNext;
}

@property (assign,readwrite) BOOL connected;
@end

@implementation Session

static Session * sharedSession = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSession = [super allocWithZone:zone];
    });
    return sharedSession;
}

+ (instancetype)sharedSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSession = [[self alloc] init];
        
    });
    return sharedSession;
}

- (BOOL) connectToServer: (NSString *) ipAddr onPort: (int) port
{ int ret;
    struct sockaddr_in toaddr;
    struct timeval tv;
    self.connected = NO;
    
    sktfd = socket(AF_INET, SOCK_STREAM, 0);
    if(sktfd<0)
    {
        NSLog(@"ERROR opening socket");
        return false;
    }
    
    toaddr.sin_family = AF_INET;
    toaddr.sin_port = htons(port);
    
    inet_aton([ipAddr cStringUsingEncoding: NSASCIIStringEncoding],&(toaddr.sin_addr));
    ret = connect(sktfd, (struct sockaddr *) &(toaddr), sizeof(toaddr));//struct sockaddr_in
    
    if (ret == 0) {
        
        //    recvTimer = [NSTimer scheduledTimerWithTimeInterval: 0.1
        //                                                 target: self
        //                                               selector: @selector(recvMessage)
        //                                               userInfo: nil
        //                                                repeats: YES];
        tv.tv_sec = 0;
        tv.tv_usec = 100000;
        setsockopt(sktfd, SOL_SOCKET, SO_RCVTIMEO, (void *) &tv, sizeof(struct timeval));
        recvBuf = (char *) malloc(MAX_MSG_CHUNK);
        recvNext = 0;
        self.connected = YES;
        [NSThread detachNewThreadSelector: @selector(recvThread) toTarget: self withObject: nil];
    }
    
    return self.connected;
}

- (void) disconnect
{
    self.connected = NO;
    close(sktfd);
}

- (BOOL) isAddr: (NSString *) addrstr
{ int ret;
    struct sockaddr_in addr;
    
    ret = inet_aton([addrstr cStringUsingEncoding: NSASCIIStringEncoding],&addr.sin_addr);
    
    return (ret == 1);
}

- (void) recvThread
{ int ret;
    fd_set rset;
    struct timeval timeout;
    
    NSLog(@"recvThread starting");
    while (self.connected) {
        FD_ZERO(&rset);
        FD_SET(sktfd,&rset);
        timeout.tv_sec = 0.5;
        timeout.tv_usec = 0;
        ret = select(FD_SETSIZE, &rset, NULL, NULL, &timeout);
        if (FD_ISSET(sktfd,&rset)) {
            [self recvMessage];
        }
    }
    NSLog(@"recvThread exiting");
}

- (void) recvMessage
{ long ret;
    
    bzero(recvBuf, 256);
    ret = recv(sktfd, recvBuf, MAX_MSG_CHUNK, 0);
    
    //ret = read(sktfd, recvBuf, 255);
    if(ret<0) {
        NSLog(@"ERROR reading from socket");
        return;
    }
    SendCommand * sendCommand=[SendCommand sharedSendCommand];
    [sendCommand performSelectorOnMainThread: @selector(receiveMessage:) withObject: [NSString stringWithCString: recvBuf encoding: NSASCIIStringEncoding] waitUntilDone: NO];
    
}

- (void) sendMessage: (NSString *) msg
{ long ret;
    char *buf;
    
    buf = (char *) malloc([msg length]);
    sprintf(buf,"%s\n",[msg cStringUsingEncoding: NSASCIIStringEncoding]);
    
    buf[strlen(buf)-1]= 0x0d;
    buf[strlen(buf)]= 0x0a;
    buf[strlen(buf)+1]= 0x00;
    ret = send(sktfd,buf,strlen(buf),0);
    //ret = write(sktfd, buf, strlen(buf));
//    NSLog(@"Send Message: %s",buf);
//    NSLog(@"bytes: %lu",strlen(buf));
    free(buf);
}

@end
