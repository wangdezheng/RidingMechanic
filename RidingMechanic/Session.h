//
//  SessionController.h
//  IM
//
//  Created by Dezheng Wang on 01/25/17.
//  Copyright (c) 2017 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SessionReceiverProtocol <NSObject>

- (void) receiveMessage: (NSString *) message;

@end

@interface Session : NSObject

@property (nonatomic, readonly) BOOL connected;

+ (instancetype)allocWithZone:(struct _NSZone *)zone;
+ (instancetype)sharedSession;

- (BOOL) connectToServer: (NSString *) ipAddr onPort: (int) port;
- (void) disconnect;

- (void) sendMessage: (NSString *) msg;
- (void) recvMessage;

@end
