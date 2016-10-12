//
//  RootViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 11/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "RootViewController.h"
#import "RegisterViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"SwitchToRegister"]){
        if([segue.destinationViewController isKindOfClass:[RegisterViewController class]]){
            
        }
    }
}

@end
