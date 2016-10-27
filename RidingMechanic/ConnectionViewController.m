//
//  ConnectionViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 27/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "ConnectionViewController.h"

@interface ConnectionViewController ()
@property (strong, nonatomic) IBOutlet UILabel *openWIfiLabel;

@property (strong, nonatomic) IBOutlet UIButton *imagePortButton;
@property (strong, nonatomic) IBOutlet UILabel *plguInLabel;
@property (strong, nonatomic) IBOutlet UILabel *connectToDeviceLabel;


@end

@implementation ConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openWIfiLabel.layer.borderWidth=0.5;
    self.connectToDeviceLabel.layer.borderWidth=0.5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
