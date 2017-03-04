//
//  RecvMessageAnalysis.h
//  IM
//
//  Created by Dezheng Wang  on 2/6/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecvMessageAnalysis : NSObject
-(void)updateSupportedPIDs: (NSString * )pid recvCode: (NSString *) code;
-(NSString *)analysizeRcvcode:(NSString *)code baseOnPID:(NSString * )pid;
@end
