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

int drivingTime=0;
int interval=1;         //reload data interval
float totalDistance=0;
float averageSpeed=0;
float MPG=0;
float totalOilConsumption=0;
float averageOilConsumption=0;
int sharpAccelerationTimes=0;

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
    sendCommand.pid=@"010C";
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
    dispatch_source_set_timer(timerForMain, DISPATCH_TIME_NOW, interval * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timerForMain, ^{
        [self.MenuTableView reloadData];
        drivingTime++;
        
        NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
        [dictionary setValue:[NSString stringWithFormat:@"%d",drivingTime] forKey:@"DrivingTime"];
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
            detailLabel.text =@"Driving Time";
            dataLabel.text=[dictionary valueForKey:@"DrivingTime"];            
        }else if(indexPath.row==1){
            [self getDrivingDistance]; //get driving distance
            detailLabel.text =@"Driving Distance";
            dataLabel.text=[dictionary valueForKey:@"DrivingDistance"];
        }else if(indexPath.row==2){
            detailLabel.text =@"Speed";
            dataLabel.text=[dictionary valueForKey:@"Speed"];
        }else if(indexPath.row==3){
            [self getAverageSpeed]; //get average speed
            detailLabel.text =@"Average Speed";
            dataLabel.text=[dictionary valueForKey:@"AverageSpeed"];
        }else if(indexPath.row==4){
            detailLabel.text =@"RPM";
            dataLabel.text=[dictionary valueForKey:@"RPM"];
        }else if(indexPath.row==5){
            [self getRealtimeMPG]; //get realtime MPG
            detailLabel.text =@"Realtime MPG";
            dataLabel.text=[dictionary valueForKey:@"RealtimeMPG"];
        }else if(indexPath.row==6){
            [self getTotalOilConsumption]; //get total oil consumption
            detailLabel.text =@"Total Oil Consumption";
            dataLabel.text=[dictionary valueForKey:@"TotalOilConsumption"];
        }else if(indexPath.row==7){
            [self getAverageOilConsumption]; //get average oil consimption
            detailLabel.text =@"Average Oil Consumption";
            dataLabel.text=[dictionary valueForKey:@"AverageOilConsumption"];
        }else if(indexPath.row==8){
            detailLabel.text =@"Fuel Cost";
        }else if(indexPath.row==9){
            detailLabel.text =@"Engine Coolant Temperature";
            dataLabel.text=[dictionary valueForKey:@"EngineCoolantTemperature"];
        }else if(indexPath.row==10){
            detailLabel.text =@"Control Module Voltage";
            dataLabel.text=[dictionary valueForKey:@"ControlModuleVoltage"];
        }else if(indexPath.row==11){
            [self getSharpAccelerationTimes]; //get sharp acceleration times
            detailLabel.text =@"Sharp Acceleration Times";
            dataLabel.text=[dictionary valueForKey:@"SharpAccelerationTimes"];
        }

    return cell;
}

-(void)getDrivingDistance //get driving distance
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];

    totalDistance+=([[dictionary valueForKey:@"Speed"] floatValue]+[[dictionary valueForKey:@"PreviousSpeed"] floatValue])*interval/2/3600;// calculate distance using Calculus
     [dictionary setValue:[NSString stringWithFormat:@"%.2f", totalDistance] forKey:@"DrivingDistance"];
    
//    NSLog(@"Speed:%@, Previous Speed:%@",[dictionary valueForKey:@"Speed"],[dictionary valueForKey:@"PreviousSpeed"]);
    

    
}

-(void)getAverageSpeed //get average speed
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    averageSpeed=3600*totalDistance/drivingTime;
    [dictionary setValue:[NSString stringWithFormat:@"%.1f", averageSpeed] forKey:@"AverageSpeed"];
}

-(void)getRealtimeMPG //get realtime MPG
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    MPG=710.7*[[dictionary valueForKey:@"Speed"] floatValue]/[[dictionary valueForKey:@"MAF"] floatValue]; //MPG = (14.7 * 6.17 * 4.54 * VSS * 0.621371) / (3600 * MAF / 100)= 710.7 * VSS / MAF
    
    [dictionary setValue:[NSString stringWithFormat:@"%.2f", MPG] forKey:@"RealtimeMPG"];
}

-(void)getTotalOilConsumption //get total oil consumption
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    totalOilConsumption=[[dictionary valueForKey:@"DrivingDistance"] floatValue]/[[dictionary valueForKey:@"RealtimeMPG"] floatValue]; //totalOilConsumption=DrivingDistance/Realtime MPG
    [dictionary setValue:[NSString stringWithFormat:@"%.2f", totalOilConsumption] forKey:@"TotalOilConsumption"];
    
}

-(void)getAverageOilConsumption //get average oil consimption
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    averageOilConsumption=3600*totalOilConsumption/drivingTime;
    [dictionary setValue:[NSString stringWithFormat:@"%.2f", averageSpeed] forKey:@"AverageOilConsumption"];
}

-(void)getSharpAccelerationTimes //get sharp acceleration times
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([[dictionary valueForKey:@"Speed"] floatValue]-[[dictionary valueForKey:@"PreviousSpeed"] floatValue]>10){
        sharpAccelerationTimes++;
        [dictionary setValue:[NSString stringWithFormat:@"%d",sharpAccelerationTimes] forKey:@"SharpAccelerationTimes"];
    }
}


@end
