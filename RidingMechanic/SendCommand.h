//
//  InitSupportedCommand.h
//  RidingMechanic
//
//  Created by 王德正  on 2/21/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Session.h"


@interface SendCommand : NSObject <SessionReceiverProtocol>

+ (instancetype)allocWithZone:(struct _NSZone *)zone;
+ (instancetype)sharedSendCommand;

-(void) sendInitialCommand;

-(void) updateDataInTable;
-(void) resumeTimerForUpdate;
@end
