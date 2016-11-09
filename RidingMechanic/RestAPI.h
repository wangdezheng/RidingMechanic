//
//  RequsetAPI.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/8/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestAPI;

@protocol RequestAPIDelegate
-(void) getReceivedData:(NSMutableData *)data sender:(RestAPI *) sender;

@end

@interface RestAPI : NSObject

-(void)httpRequest:(NSMutableURLRequest *) request;

@property (nonatomic, weak) id <RequestAPIDelegate> delegate;
@end

#define POST @"POST"
#define GET @"GET"
