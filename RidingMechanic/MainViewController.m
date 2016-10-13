//
//  MainViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 13/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(void) viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton=YES;
}

- (void)viewDidLoad {
   
    self.navigationController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UITextField *text = [[UITextField alloc]initWithFrame:CGRectMake(self.view.center.x,self.view.center.y, 100, 100)];
//    text.text = @"123";
//    text.borderStyle = UITextBorderStyleLine;
//    [self.view addSubview:text];
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0,1, self.view.frame.size.width, 100)];
//    label.layer.borderWidth = 1.0;
//    [self.view addSubview:label];
}

- (void)test {
    
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
