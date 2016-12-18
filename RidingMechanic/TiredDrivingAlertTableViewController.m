//
//  TiredDrivingAlertTableViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 12/14/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "TiredDrivingAlertTableViewController.h"
#import "AlertTableViewCell.h"

@interface TiredDrivingAlertTableViewController ()
@property (strong,nonatomic) AlertTableViewCell *alertCell;
@end

@implementation TiredDrivingAlertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:self.alertCell.tiredDrivingTextField.text forKey:@"TiredDrivingHour"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==0 &&indexPath.row==0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.textLabel.text=@"Tired Driving Alert";
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView=switchView;
        [switchView setOn:YES animated:NO];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }else{
        self.alertCell= (AlertTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TiredDriving" forIndexPath:indexPath];
        self.alertCell.tiredDrivingTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"TiredDrivingHour"];
        return self.alertCell;
    }
}


- (void)switchChanged:(id)sender {
    if([sender isOn]){
        [[NSUserDefaults standardUserDefaults] setObject:@"On" forKey:@"TiredDrivingSwitch"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"Off" forKey:@"TiredDrivingSwitch"];
    }
    
}

@end
