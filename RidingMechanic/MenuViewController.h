//
//  MenuViewController.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 1/16/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *MenuTableView;

+ (instancetype)sharedMenuController;

@end
