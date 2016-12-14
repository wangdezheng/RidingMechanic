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
        [switchView setOn:YES animated:NO];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
