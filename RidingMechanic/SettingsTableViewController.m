//
//  SettingsTableViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 11/29/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "SettingsTableViewController.h"

@interface SettingsTableViewController ()

@end

@implementation SettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows=0;
    if(section==0){
        rows=2;
    }else if(section==1){
        rows=2;
    }else {
        rows=2;
    }
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    switch (indexPath.section)
    {
        case 0:
            if(indexPath.row==0){
                cell.textLabel.text =@"Account";
            }else{
                cell.textLabel.text =@"Alert";
            }
            break;
        case 1:
            if(indexPath.row==0){
                cell.textLabel.text =@"Vehicle";
            }else{
                cell.textLabel.text =@"Adapter";
            }
            break;
        case 2:
            if(indexPath.row==0){
                cell.textLabel.text =@"Unit";
            }else if(indexPath.row==1){
                cell.textLabel.text =@"About";
            }
            break;
        default:
            break;
    }
    return cell;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName=@"Settings";
            break;
        case 1:
            sectionName=@"Information";
            break;
        case 2:
            sectionName=@"Other";
        default:
            break;
    }
    return sectionName;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0&&indexPath.row==0){
        [self performSegueWithIdentifier:@"showAccount" sender:tableView];
    }else if(indexPath.section==0&&indexPath.row==1){
        [self performSegueWithIdentifier:@"showAlert" sender:tableView];
    }else if(indexPath.section==1&&indexPath.row==0){
        [self performSegueWithIdentifier:@"showVehicle" sender:tableView];
    }else if(indexPath.section==1&&indexPath.row==1){
        [self performSegueWithIdentifier:@"showAdapter" sender:tableView];
    }
}




@end
