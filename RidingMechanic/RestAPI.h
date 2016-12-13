//
//  RequsetAPI.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/8/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RestAPI;

@protocol RestAPIDelegate
-(void) getReceivedData:(NSMutableData *)data sender:(RestAPI *) sender;

@end

@interface RestAPI : NSObject

-(void)httpRequest:(NSMutableURLRequest *) request;

@property (nonatomic, weak) id <RestAPIDelegate> delegate;
@end

#define POST @"POST"
#define GET @"GET"
#define PUT @"PUT"
