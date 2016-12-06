//
//  QueryFromCoreData.h
//  RidingMechanic
//
//  Created by 王德正  on 12/5/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Car+CoreDataClass.h"

@interface QueryFromCoreData : NSObject

-(NSString *) queryWifiStatus;

-(Car *) changeWifiStatus;
@end
