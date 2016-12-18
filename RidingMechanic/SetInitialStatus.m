//
//  SetInitialStatus.m
//  RidingMechanic
//
//  Created by 王德正  on 12/17/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "SetInitialStatus.h"

@implementation SetInitialStatus

-(void)setInitial
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    [dictionary setObject:@"unconnected" forKey:@"wifiStatus"];
    
    if(![dictionary objectForKey:@"AlertSwitch"]){
        [dictionary setObject:@"On" forKey:@"AlertSwitch"];
    }
    
    if(![dictionary objectForKey:@"SpeedAlertSwitch"]){
        [dictionary setObject:@"On" forKey:@"SpeedAlertSwitch"];
    }
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"SpeedLimit"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"90" forKey:@"SpeedLimit"];
    }
    
    if(![dictionary objectForKey:@"TiredDrivingSwitch"]){
        [dictionary setObject:@"On" forKey:@"TiredDrivingSwitch"];
    }
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"TiredDrivingHour"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"3" forKey:@"TiredDrivingHour"];
    }
    
    if(![dictionary objectForKey:@"WaterTemperatureSwitch"]){
        [dictionary setObject:@"On" forKey:@"WaterTemperatureSwitch"];
    }
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"WaterTemperature"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"350" forKey:@"WaterTemperature"];
    }
    

}
@end
