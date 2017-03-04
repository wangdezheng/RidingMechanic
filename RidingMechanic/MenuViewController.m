//
//  MenuViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 1/16/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *MenuTableView;
@property (strong,nonatomic) UIAlertController * alertController;
@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MenuTableView.delegate = self;
    self.MenuTableView.dataSource=self;
    
    self.alertController = [UIAlertController alertControllerWithTitle: @"Stop Recording?" message: @"" preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"YES" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self performSegueWithIdentifier:@"goBackCarModelView" sender:nil];
    }]];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"NO" style: UIAlertActionStyleDefault handler:nil]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)goBackCarModelView:(id)sender {
    [self presentViewController:self.alertController animated:YES completion:Nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];

        UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
        UILabel *dataLabel = (UILabel *)[cell viewWithTag:3];
        if(indexPath.row==0){
            detailLabel.text =@"Drive Time";
            dataLabel.text=@"111";
        }else if(indexPath.row==1){
            detailLabel.text =@"Driving Distance";
        }else if(indexPath.row==2){
            detailLabel.text =@"Speed";
        }else if(indexPath.row==3){
            detailLabel.text =@"Average Speed";
        }else if(indexPath.row==4){
            detailLabel.text =@"RPM";
        }else if(indexPath.row==5){
            detailLabel.text =@"Total Oil Consumption";
        }else if(indexPath.row==6){
            detailLabel.text =@"Average Oil Consumption";
        }else if(indexPath.row==7){
            detailLabel.text =@"Fuel Cost";
        }else if(indexPath.row==8){
            detailLabel.text =@"Engine Coolant Temperature";
        }else if(indexPath.row==9){
            detailLabel.text =@"Idle Time";
        }else if(indexPath.row==10){
            detailLabel.text =@"Sharp Acceleration Times";
        }

    return cell;
}





@end
