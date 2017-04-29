//
//  UnitTableViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 4/28/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "UnitTableViewController.h"

@interface UnitTableViewController ()

@end

@implementation UnitTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *unitLabel = (UILabel *)[cell viewWithTag:2];
    UILabel *selectLabel = (UILabel *)[cell viewWithTag:3];
    
    if(indexPath.row==0){
        unitLabel.text=@"Imperial(UK)";
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Unit" ] isEqualToString:@"1"]){
            [selectLabel setHidden:NO];
        }else{
            [selectLabel setHidden:YES];
        }
        
    }else{
        unitLabel.text=@"Metric(Europe)";
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Unit" ] isEqualToString:@"0"]){
            [selectLabel setHidden:NO];
        }else{
            [selectLabel setHidden:YES];
        }
    }
    
    return cell;
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0&&indexPath.row==0){
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"Unit"];
    }else if(indexPath.section==0&&indexPath.row==1){
        [[NSUserDefaults standardUserDefaults] setValue:@"0" forKey:@"Unit"];
    }
    [self.tableView reloadData];
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
