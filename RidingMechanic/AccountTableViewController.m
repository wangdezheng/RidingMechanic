//
//  AccountTableViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 12/6/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "AccountTableViewController.h"

@interface AccountTableViewController ()
@property (strong,nonatomic) UIAlertController * alertController;
@end

@implementation AccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.alertController = [UIAlertController alertControllerWithTitle: @"Log Out Succeed!" message: @"" preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
         [self performSegueWithIdentifier:@"logOut" sender:nil];
    }]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)logOut:(id)sender {
       [self presentViewController:self.alertController animated:YES completion:nil];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"account" forIndexPath:indexPath];
    
    if(indexPath.section==0){
        NSMutableArray *userInfoArray=[[NSMutableArray alloc] initWithCapacity:2];
        userInfoArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
        cell.textLabel.text=userInfoArray[0];//get username
    }else{
        cell.textLabel.text=@"Reset Password";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==1&&indexPath.row==0){
        [self performSegueWithIdentifier:@"showResetPassword" sender:tableView];
    }
}

@end
