//
//  InitSupportedCommand.m
//  RidingMechanic
//
//  Created by 王德正  on 2/21/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "InitSupportedCommand.h"
#import "RecvMessageAnalysis.h"
#import "Session.h"

static Boolean ret;

@interface InitSupportedCommand()

@property (strong,nonatomic) InitSupportedCommand * initSupportedCommand;
@property (strong,nonatomic)  Session * session;
@property (strong,nonatomic) NSString*pid;
@property (strong,nonatomic) NSString*recvcode;

@end
@implementation InitSupportedCommand



+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
        ret=YES;
        
    });
    return _instance;
}

-(BOOL) startConnectingToServer{
    if(!ret){
        ret =[self.session connectToServer:@"192.168.0.10" onPort:35000];
    }
    return ret;
}

- (void) receiveMessage: (NSString *) message {
    NSLog(@"New Text:%@ %lu",message,message.length);
//    NSError *error = nil;
//    if(message.length>5){                       //message is not echo
//        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s" options:NSRegularExpressionCaseInsensitive error:&error];//remove space, tab
//        message=[regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, message.length) withTemplate:@""];
//        NSRegularExpression *REGEX = [NSRegularExpression regularExpressionWithPattern:@">+" options:NSRegularExpressionCaseInsensitive error:&error];//remove >
//        message=[REGEX stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, message.length) withTemplate:@""];
//        
//        if([message containsString:self.pid]){        //message contains sending message
//            self.recvcode=[message substringFromIndex:8];
//        }else{                                        //message doesn't contains sending message
//            self.recvcode=[message substringFromIndex:4];
//        }
//        NSLog(@"Pid:%@",self.pid);
//        NSLog(@"Recvcode:%@,%lu",self.recvcode,self.recvcode.length);
//        RecvMessageAnalysis *recvMsgAnalysis=[[RecvMessageAnalysis alloc] init];
//        if([self.pid isEqualToString:@"0100"]||[self.pid isEqualToString:@"0120"]||[self.pid isEqualToString:@"0140"]||[self.pid isEqualToString:@"0160"]){
//            [recvMsgAnalysis updateSupportedPIDs:self.pid recvCode:self.recvcode];//update supported pid
//        }else{
//            NSString *returnValue=[recvMsgAnalysis analysizeRcvcode:self.recvcode baseOnPID:self.pid];
//            NSLog(@"Return Value:%@",returnValue);
//        }
//    }

}
@end
