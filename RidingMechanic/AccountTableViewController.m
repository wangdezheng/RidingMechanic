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
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    [dictionary setValue:nil forKey:@"username"];
    [dictionary setValue:nil forKey:@"password"];
    [dictionary setValue:nil forKey:@"userID"];
    
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
        cell.textLabel.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"username"];//get username
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
