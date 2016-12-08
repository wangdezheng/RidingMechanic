//
//  QueryFromCoreData.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 12/5/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QueryFromCoreData : NSObject

-(NSString *) queryWifiStatus;

-(Car *) changeWifiStatus;
@end
