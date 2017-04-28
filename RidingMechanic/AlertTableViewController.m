//
//  AlertTableViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 12/13/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "AlertTableViewController.h"

@interface AlertTableViewController ()

@end

@implementation AlertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if(indexPath.row==0){
        cell.textLabel.text=@"Alert";
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView=switchView;
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"AlertSwitch"] isEqualToString:@"On"]){
            [switchView setOn:YES];
        }else{
             [switchView setOn:NO];
        }
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
    }else if(indexPath.row==1){
        cell.textLabel.text=@"Speed Alert";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.row==2){
        cell.textLabel.text=@"Tired Driving Alert";
         cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.textLabel.text=@"Water Temperature Alert";
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

- (void)switchChanged:(id)sender {
    if([sender isOn]){
        [[NSUserDefaults standardUserDefaults] setObject:@"On" forKey:@"AlertSwitch"];
    }else{
         [[NSUserDefaults standardUserDefaults] setObject:@"Off" forKey:@"AlertSwitch"];
    }

}


- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row==1){
        [self performSegueWithIdentifier:@"showSpeedAlert" sender:tableView];
    }else if(indexPath.row==2){
        [self performSegueWithIdentifier:@"showTiredDrivingAlert" sender:tableView];
    }else if(indexPath.row==3){
         [self performSegueWithIdentifier:@"showWaterTemperatureAlert" sender:tableView];
    }
}



@end
