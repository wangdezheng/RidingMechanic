//
//  InitSupportedCommand.h
//  RidingMechanic
//
//  Created by 王德正  on 2/21/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"

static id _instance;

@interface InitSupportedCommand : NSObject <SessionReceiverProtocol>

+ (instancetype)allocWithZone:(struct _NSZone *)zone;
+ (instancetype)sharedSession;

-(BOOL) startConnectingToServer;
@end
