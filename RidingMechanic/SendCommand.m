//
//  InitSupportedCommand.m
//  RidingMechanic
//
//  Created by 王德正  on 2/21/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "SendCommand.h"
#import "RecvMessageAnalysis.h"
#import "Session.h"

@interface SendCommand()

@property (strong,nonatomic) NSString* recvcode;

@end
@implementation SendCommand

dispatch_source_t timer;
dispatch_source_t timerForUpdate;

static  SendCommand* sharedSendCommand = nil;

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSendCommand = [super allocWithZone:zone];
    });
    return sharedSendCommand;
}

+ (instancetype)sharedSendCommand
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSendCommand = [[self alloc] init];
        
    });
    return sharedSendCommand;
}

-(void)sendInitialCommand
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    // create timer
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //set timer property
    // GCD 1s=10^9 ns
    // start time and time interval
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timer, ^{
        
        Session * session=[Session sharedSession];
        NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
        if([[dictionary valueForKey:@"0120"] isEqualToString:@"1"]){
            if([[dictionary valueForKey:@"0140"] isEqualToString:@"1"]){
                if([[dictionary valueForKey:@"0142"] isEqualToString:@"1"]){
                    [self stopTimer];
                    NSLog(@"Stop!!");
                }else{
                    self.pid=@"0140";
                    [session sendMessage:@"0140"];
                }
            }else{
                self.pid=@"0120";
                [session sendMessage:@"0120"];
            }
        }else{
            self.pid=@"0100";
            [session sendMessage:@"0100"];
        }
        
    });
    
    // start timer
    dispatch_resume(timer);
}

-(void) stopTimer{
    // stop
    if(timer){
        dispatch_source_cancel(timer);
        timer = nil;
    }
}

-(void) updateDataInTable
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    // create timer
    timerForUpdate = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    //set timer property
    // GCD 1s=10^9 ns
    // start time and time interval
    dispatch_source_set_timer(timerForUpdate, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timerForUpdate, ^{
        
        Session * session=[Session sharedSession];
        [session sendMessage:self.pid];
        [self pauseTimerForUpdate];
    });
    
    // start timer
    dispatch_resume(timerForUpdate);
}

-(void) pauseTimerForUpdate{
    // stop timerForUpdate
    if(timerForUpdate){
        dispatch_suspend(timerForUpdate);
    }
}

-(void) resumeTimerForUpdate{
    // resume timerForUpdate
    if(timerForUpdate){
        dispatch_resume(timerForUpdate);
    }
}


- (void) receiveMessage: (NSString *) message {
    //    NSLog(@"New Text:%@ %lu",message,message.length);
    self.recvcode=nil;
    if(self.pid==nil){
        return;
    }
    
    NSError *error = nil;
    if(message.length>5){                       //message is not echo
        NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s" options:NSRegularExpressionCaseInsensitive error:&error];//remove space, tab
        message=[regex stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, message.length) withTemplate:@""];
        NSRegularExpression *REGEX = [NSRegularExpression regularExpressionWithPattern:@">+" options:NSRegularExpressionCaseInsensitive error:&error];//remove >
        message=[REGEX stringByReplacingMatchesInString:message options:0 range:NSMakeRange(0, message.length) withTemplate:@""];
        
        if([message containsString:self.pid]){        //message contains sending message
            self.recvcode=[message substringFromIndex:8];
        }else{                                        //message doesn't contains sending message
            self.recvcode=[message substringFromIndex:4];
        }
        NSLog(@"Pid:%@",self.pid);
        NSLog(@"Recvcode:%@,%lu",self.recvcode,self.recvcode.length);
        RecvMessageAnalysis *recvMsgAnalysis=[[RecvMessageAnalysis alloc] init];
        if([self.pid isEqualToString:@"0100"]||[self.pid isEqualToString:@"0120"]||[self.pid isEqualToString:@"0140"]||[self.pid isEqualToString:@"0160"]){
            [recvMsgAnalysis updateSupportedPIDs:self.pid recvCode:self.recvcode];//update supported pid
        }else{
            NSString *returnValue=[recvMsgAnalysis analysizeRcvcode:self.recvcode baseOnPID:self.pid];
            NSLog(@"Return Value:%@",returnValue);
        }
    }
    
}
@end
