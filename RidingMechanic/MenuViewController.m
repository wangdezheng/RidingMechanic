//
//  MenuViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 1/16/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "MenuViewController.h"
#import "SendCommand.h"

@interface MenuViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UIAlertController * alertController;
@end

@implementation MenuViewController
static dispatch_source_t timerForMain;
static MenuViewController * menuController = nil;

+ (instancetype)sharedMenuController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        menuController = [[self alloc] init];
        
    });
    return menuController;
}

-(void)viewWillAppear:(BOOL)animated
{
    SendCommand * sendCommand=[SendCommand sharedSendCommand];
    [sendCommand updateDataInTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MenuTableView.delegate = self;
    self.MenuTableView.dataSource=self;
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();  // main thread
    
    // create timer
    timerForMain = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
    
    //set timer property
    // GCD 1s=10^9 ns
    // start time and time interval
    dispatch_source_set_timer(timerForMain, DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timerForMain, ^{
        [self.MenuTableView reloadData];
    });
    
    // start timer
    dispatch_resume(timerForMain);
    
    
    
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
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
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
            dataLabel.text=[dictionary valueForKey:@"RPM"];
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
