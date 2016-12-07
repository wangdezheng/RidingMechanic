//
//  AccountTableViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 12/6/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "AccountTableViewController.h"

@interface AccountTableViewController ()

@end

@implementation AccountTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        cell.textLabel.text=userInfoArray[0];
    }else{
        cell.textLabel.text=@"Reset Password";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


@end
