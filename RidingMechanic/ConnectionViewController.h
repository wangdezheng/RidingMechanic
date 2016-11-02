//
//  ConnectionViewController.h
//  RidingMechanic
//
//  Created by 王德正  on 27/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Reachability;
@interface ConnectionViewController : UIViewController

@property Reachability* internetReachable;

-(void) checkNetworkStatus:(NSNotification *)notice;

@end
