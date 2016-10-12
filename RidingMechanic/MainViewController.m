//
//  MainViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 12/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIButton *imageButton;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_imageButton setBackgroundImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
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
