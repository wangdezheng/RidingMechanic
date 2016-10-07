//
//  MainViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 07/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "MainViewController.h"
#import "RegisterViewController.h"

@interface MainViewController ()
@property (strong,nonatomic) UITextField * userNameFled;
@property (strong,nonatomic) UITextField * passwordField;
@end

@implementation MainViewController

- (IBAction) showRegisterScreen: (UIButton *) sender {
    RegisterViewController *regCtlr=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
    [self presentViewController:regCtlr animated:YES completion:nil];
}

@end
