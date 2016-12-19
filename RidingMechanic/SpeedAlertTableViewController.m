//
//  SpeedAlertTableViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 12/13/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "SpeedAlertTableViewController.h"
#import "AlertTableViewCell.h"

@interface SpeedAlertTableViewController ()
@property (strong,nonatomic) AlertTableViewCell *alertCell;
@end

@implementation SpeedAlertTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults] setObject:self.alertCell.speedTextField.text forKey:@"SpeedLimit"];
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
        cell.textLabel.text=@"Speed Alert";
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView=switchView;
        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"AlertSwitch" ] isEqualToString:@"On"]){
            if([[[NSUserDefaults standardUserDefaults] objectForKey:@"SpeedAlertSwitch" ] isEqualToString:@"On"]){
                [switchView setOn:YES];
            }else{
                [switchView setOn:NO];
            }
        }else{
            [switchView setOn:NO];
        }
        
        
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        return cell;
    }else{
        self.alertCell= (AlertTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"SpeedLimit" forIndexPath:indexPath];
        self.alertCell.speedTextField.text=[[NSUserDefaults standardUserDefaults] objectForKey:@"SpeedLimit"];
        self.alertCell.speedLabel.text=@"mph";
        return self.alertCell;
    }
}


- (void)switchChanged:(id)sender {
    if([sender isOn]){
        [[NSUserDefaults standardUserDefaults] setObject:@"On" forKey:@"SpeedAlertSwitch"];
    }else{
        [[NSUserDefaults standardUserDefaults] setObject:@"Off" forKey:@"SpeedAlertSwitch"];
    }
    
}



@end
