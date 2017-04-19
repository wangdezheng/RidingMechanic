//
//  MenuViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 1/16/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "MenuViewController.h"
#import "SendCommand.h"

@interface MenuViewController ()
@property (weak,nonatomic) NSDictionary * dictionary;
@property (strong,nonatomic) UIAlertController * alertController;
@property (assign,nonatomic) NSInteger drivingTime;
@property (assign,nonatomic) NSInteger interval;
@property (assign,nonatomic) CGFloat totalDistance;
@property (assign,nonatomic) NSInteger averageSpeed;
@property (assign,nonatomic) CGFloat MPG;
@property (assign,nonatomic) CGFloat totalOilConsumption;
@property (assign,nonatomic) CGFloat fuelCost;
@property (assign,nonatomic) CGFloat averageMPG;
@property (assign,nonatomic) NSInteger sharpAccelerationTimes;
@property (assign,nonatomic) NSInteger sharpBrakingTimes;

@end

@implementation MenuViewController

static dispatch_source_t timerForMain;

-(void)initialize
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    [dictionary setValue:@"0" forKey:@"Speed"];
    [dictionary setValue:@"0" forKey:@"RPM"];
    [dictionary setValue:@"0" forKey:@"EngineCoolantTemperature"];
    [dictionary setValue:@"0" forKey:@"ControlModuleVoltage"];
    
    self.drivingTime=0;
    self.interval=1;
    self.totalDistance=0.0;
    self.averageSpeed=0;
    self.MPG=0.0;
    self.totalOilConsumption=0.0;
    self.fuelCost=0.0;
    self.averageMPG=0.0;
    self.sharpAccelerationTimes=0;
    self.sharpBrakingTimes=0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.hidesBackButton=YES;
    SendCommand * sendCommand=[SendCommand sharedSendCommand];
    if(sendCommand.timerForUpdate){
        [sendCommand resumeTimerForUpdate];
    }else{
        sendCommand.pid=@"010D";
        [sendCommand updateDataInTable];
    }
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationItem.hidesBackButton=NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initialize];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    [dictionary setValue:DateTime forKey:@"StartDateTime"];// store start date time
    
    
    self.alertController = [UIAlertController alertControllerWithTitle: @"Do you want to store trip information?" message: @"" preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"YES" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){

        [self writeDataToPlist];//stop recording and store trip information into plist
    
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"NO" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self.navigationController popViewControllerAnimated:YES];
    }]];

    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    dispatch_queue_t mainQueue = dispatch_get_main_queue();  // main thread
    // create timer
    timerForMain = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
    
    //set timer property
    // GCD 1s=10^9 ns
    // start time and time interval
    dispatch_source_set_timer(timerForMain, DISPATCH_TIME_NOW, self.interval * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timerForMain, ^{
        [self.tableView reloadData];
        
        self.drivingTime++;

        NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
        [dictionary setValue:[NSNumber numberWithInteger:self.drivingTime] forKey:@"DrivingTime"];
    });
    
    // start timer
    dispatch_resume(timerForMain);
}

-(void) stopTimerForMain{
    // pause TimerForMain
    if(timerForMain){
        dispatch_source_cancel(timerForMain);
    }
}

-(void) writeDataToPlist{ // store information into temporary database
    //use plist（automatically create one）
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if(sandBoxDataDic==nil){ //temporary database is empty
        sandBoxDataDic = [NSMutableDictionary new];
        NSMutableArray * startDateTimeArray=[[NSMutableArray alloc] init];//store start date and time
        [startDateTimeArray addObject:[dictionary valueForKey:@"StartDateTime"]];
        sandBoxDataDic[@"StartDateTime"]=startDateTimeArray;
        
        NSDate *date = [NSDate date];//store end date and time
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
        NSString *DateTime = [formatter stringFromDate:date];
        NSMutableArray * endDateTimeArray=[[NSMutableArray alloc] init];
        [endDateTimeArray addObject:DateTime];
        sandBoxDataDic[@"EndDateTime"] = endDateTimeArray;
        
        NSMutableArray * drivingDistanceArray=[[NSMutableArray alloc] init];//store driving distance
        [drivingDistanceArray addObject:[dictionary valueForKey:@"DrivingDistance"]];
        sandBoxDataDic[@"DrivingDistance"]=drivingDistanceArray;
        
        NSMutableArray * MPGArray=[[NSMutableArray alloc] init];//store average MPG
        [MPGArray addObject:[dictionary valueForKey:@"AverageMPG"]];
        sandBoxDataDic[@"AverageMPG"]=MPGArray;
        
        NSMutableArray * speedArray=[[NSMutableArray alloc] init];//store average speed
        [speedArray addObject:[dictionary valueForKey:@"AverageSpeed"]];
        sandBoxDataDic[@"AverageSpeed"]=speedArray;
        
        NSMutableArray * fuelCostArray=[[NSMutableArray alloc] init];//store fuel cost
        [fuelCostArray addObject:[dictionary valueForKey:@"FuelCost"]];
        sandBoxDataDic[@"FuelCost"]=fuelCostArray;
        
        NSMutableArray * accelerationArray=[[NSMutableArray alloc] init];//store Sharp Acceleration Times
        [accelerationArray addObject:[dictionary valueForKey:@"SharpAccelerationTimes"]];
        sandBoxDataDic[@"SharpAccelerationTimes"]=accelerationArray;
        
        NSMutableArray * brakingArray=[[NSMutableArray alloc] init];//store store Sharp braking Times
        [brakingArray addObject:[dictionary valueForKey:@"SharpBrakingTimes"]];
        sandBoxDataDic[@"SharpBrakingTimes"]=brakingArray;
        
    }else{//temporary database is not empty
        NSMutableArray * startDateTimeArray=[[NSMutableArray alloc] init];//store start date and time
        startDateTimeArray=sandBoxDataDic[@"StartDateTime"];
        [startDateTimeArray addObject:[dictionary valueForKey:@"StartDateTime"]];
        sandBoxDataDic[@"StartDateTime"]=startDateTimeArray;
        
        NSDate *date = [NSDate date];//store end date and time
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
        NSString *DateTime = [formatter stringFromDate:date];
        NSMutableArray * endDateTimeArray=[[NSMutableArray alloc] init];
        endDateTimeArray=sandBoxDataDic[@"EndDateTime"];
        [endDateTimeArray addObject:DateTime];
        sandBoxDataDic[@"EndDateTime"] = endDateTimeArray;
        
        NSMutableArray * drivingDistanceArray=[[NSMutableArray alloc] init];//store driving distance
        drivingDistanceArray=sandBoxDataDic[@"DrivingDistance"];
        [drivingDistanceArray addObject:[dictionary valueForKey:@"DrivingDistance"]];
        sandBoxDataDic[@"DrivingDistance"]=drivingDistanceArray;
        
        NSMutableArray * MPGArray=[[NSMutableArray alloc] init];//store average MPG
        MPGArray=sandBoxDataDic[@"AverageMPG"];
        [MPGArray addObject:[dictionary valueForKey:@"AverageMPG"]];
        sandBoxDataDic[@"AverageMPG"]=MPGArray;
        
        NSMutableArray * speedArray=[[NSMutableArray alloc] init];//store average speed
        speedArray=sandBoxDataDic[@"AverageSpeed"];
        [speedArray addObject:[dictionary valueForKey:@"AverageSpeed"]];
        sandBoxDataDic[@"AverageSpeed"]=speedArray;
        
        NSMutableArray * fuelCostArray=[[NSMutableArray alloc] init];//store fuel cost
        fuelCostArray=sandBoxDataDic[@"FuelCost"];
        [fuelCostArray addObject:[dictionary valueForKey:@"FuelCost"]];
        sandBoxDataDic[@"FuelCost"]=fuelCostArray;
        
        NSMutableArray * accelerationArray=[[NSMutableArray alloc] init];//store Sharp Acceleration Times
        accelerationArray=sandBoxDataDic[@"SharpAccelerationTimes"];
        [accelerationArray addObject:[dictionary valueForKey:@"SharpAccelerationTimes"]];
        sandBoxDataDic[@"SharpAccelerationTimes"]=accelerationArray;
        
        NSMutableArray * brakingArray=[[NSMutableArray alloc] init];//store store Sharp braking Times
        brakingArray=sandBoxDataDic[@"SharpBrakingTimes"];
        [brakingArray addObject:[dictionary valueForKey:@"SharpBrakingTimes"]];
        sandBoxDataDic[@"SharpBrakingTimes"]=brakingArray;
    }
    

    
    [sandBoxDataDic writeToFile:filePatch atomically:YES];
    sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    NSLog(@"New: %@",sandBoxDataDic);
}

- (IBAction)goBackCarModelView:(id)sender {
    SendCommand * sendCommand=[SendCommand sharedSendCommand]; //stop sending command
    [sendCommand pauseTimerForUpdate];
    
    [self stopTimerForMain];
    
    [self presentViewController:self.alertController animated:YES completion:Nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 13;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
        UILabel *detailLabel = (UILabel *)[cell viewWithTag:2];
        UILabel *dataLabel = (UILabel *)[cell viewWithTag:3];

        if(indexPath.row==0){
            detailLabel.text =@"Driving Time";
            dataLabel.text=[[NSNumber numberWithInteger:self.drivingTime] stringValue];
        }else if(indexPath.row==1){
            [self getDrivingDistance]; //get driving distance
            detailLabel.text =@"Driving Distance";
            dataLabel.text=[NSString stringWithFormat:@"%.2f",self.totalDistance];
        }else if(indexPath.row==2){
            detailLabel.text =@"Speed";
            dataLabel.text=[NSString stringWithFormat:@"%ld",[[dictionary valueForKey:@"Speed"] integerValue]];
        }else if(indexPath.row==3){
            [self getAverageSpeed]; //get average speed
            detailLabel.text =@"Average Speed";
            dataLabel.text=[NSString stringWithFormat:@"%ld",self.averageSpeed];
        }else if(indexPath.row==4){
            detailLabel.text =@"RPM";
            dataLabel.text=[dictionary valueForKey:@"RPM"];
        }else if(indexPath.row==5){
            [self getRealtimeMPG]; //get realtime MPG
            detailLabel.text =@"Realtime MPG";
            dataLabel.text=[NSString stringWithFormat:@"%.2f",self.MPG];
        }else if(indexPath.row==6){
            [self getTotalOilConsumption]; //get total oil consumption
            detailLabel.text =@"Total Oil Consumption";
            dataLabel.text=[NSString stringWithFormat:@"%.2f",self.totalOilConsumption];
        }else if(indexPath.row==7){
            [self getAverageMPG]; //get average MPG
            detailLabel.text =@"AverageMPG";
            dataLabel.text=[NSString stringWithFormat:@"%.2f",self.averageMPG];
        }else if(indexPath.row==8){
            [self getFuelCost];//get fuel cost
            detailLabel.text =@"Fuel Cost";
            dataLabel.text=[NSString stringWithFormat:@"%.2f",self.fuelCost];
        }else if(indexPath.row==9){
            detailLabel.text =@"Engine Coolant Temperature";
            dataLabel.text=[dictionary valueForKey:@"EngineCoolantTemperature"];
        }else if(indexPath.row==10){
            detailLabel.text =@"Control Module Voltage";
            dataLabel.text=[dictionary valueForKey:@"ControlModuleVoltage"];
        }else if(indexPath.row==11){
            [self getSharpAccelerationTimes]; //get sharp acceleration times
            detailLabel.text =@"Sharp Acceleration Times";
            dataLabel.text=[[NSNumber numberWithInteger:self.sharpAccelerationTimes] stringValue];
        }else if(indexPath.row==12){
            [self getSharpBrakingTimes]; //get sharp braking times
            detailLabel.text =@"Sharp Braking Times";
            dataLabel.text=[[NSNumber numberWithInteger:self.sharpBrakingTimes] stringValue];
        }

    return cell;
}

-(void)getDrivingDistance //get driving distance
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];

    CGFloat drivingDistanceEachSecond=([[dictionary valueForKey:@"Speed"] floatValue]+[[dictionary valueForKey:@"PreviousSpeed"] doubleValue])*self.interval/2/3600; // calculate distance using Calculus
    [dictionary setValue:@(drivingDistanceEachSecond) forKey:@"DrivingDistanceForEachSecond"];
    
    self.totalDistance+=drivingDistanceEachSecond;
     [dictionary setValue:@(self.totalDistance) forKey:@"DrivingDistance"];
}

-(void)getAverageSpeed //get average speed
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if(self.drivingTime!=0){
       self.averageSpeed=3600*self.totalDistance/self.drivingTime;
    }
    [dictionary setValue:@(self.averageSpeed) forKey:@"AverageSpeed"];
}

-(void)getRealtimeMPG //get realtime MPG
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    if([[dictionary valueForKey:@"MAF"] doubleValue]!=0){
        self.MPG=7.718*1.6*[[dictionary valueForKey:@"Speed"] doubleValue]/[[dictionary valueForKey:@"MAF"] doubleValue]; //MPG = (14.7 * 6.17 * 454 * VSS) / (3600 * MAF)= 7.718 * VSS(km/h) / MAF(g/h)
    }

    
    [dictionary setValue:@(self.MPG) forKey:@"RealtimeMPG"];
}

-(void)getTotalOilConsumption //get total oil consumption
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    if(self.MPG!=0.0){
        self.totalOilConsumption+=([[dictionary valueForKey:@"DrivingDistanceForEachSecond"] doubleValue])/self.MPG; //totalOilConsumption+=DrivingDistanceForEachSecond/Realtime MPG
    }
    [dictionary setValue:@(self.totalOilConsumption) forKey:@"TotalOilConsumption"];
    
}

-(void)getFuelCost //get fuel cost
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    self.fuelCost=self.totalOilConsumption*[[dictionary valueForKey:@"OilPrice"] doubleValue]; // fuel cost=Total oil Consumption(g) * oil price
    [dictionary setValue:@(self.fuelCost) forKey:@"FuelCost"];
}

-(void)getAverageMPG //get average MPG
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    if(self.totalOilConsumption!=0.0){
        self.averageMPG=self.totalDistance/self.totalOilConsumption;
    }
    
    [dictionary setValue:@(self.averageMPG)forKey:@"AverageMPG"];
}

-(void)getSharpAccelerationTimes //get sharp acceleration times
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([[dictionary valueForKey:@"Speed"] floatValue]-[[dictionary valueForKey:@"PreviousSpeed"] floatValue]>10){
        self.sharpAccelerationTimes++;
    }
    NSLog(@"%lu",self.sharpAccelerationTimes);
    [dictionary setValue:@(self.sharpAccelerationTimes)forKey:@"SharpAccelerationTimes"];
}

-(void)getSharpBrakingTimes //get sharp braking times
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([[dictionary valueForKey:@"Speed"] floatValue]-[[dictionary valueForKey:@"PreviousSpeed"] floatValue]<-10){
        self.sharpBrakingTimes++;
    }
    
    [dictionary setValue:@(self.sharpBrakingTimes) forKey:@"SharpBrakingTimes"];
}


@end
