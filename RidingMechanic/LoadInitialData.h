//
//  LoadInitialData.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 24/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CarModel+CoreDataProperties.h"
#import "AppDelegate.h"

@interface LoadInitialData : NSObject
@property (strong,nonatomic) AppDelegate *myDelegate;

- (void)loadInitialData;
@end
