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
float fuelCost=0;
float averageMPG=0;
int sharpAccelerationTimes=0;
int sharpBrakingTimes=0;

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
    sendCommand.pid=@"010D";
    [sendCommand updateDataInTable];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.MenuTableView.delegate = self;
    self.MenuTableView.dataSource=self;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    [dictionary setValue:DateTime forKey:@"StartDateTime"];// store start date time
    
    
    self.alertController = [UIAlertController alertControllerWithTitle: @"Do you want to store trip information?" message: @"" preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"YES" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self writeDataToPlist];//stop recording and store trip information into plist
    
        [self performSegueWithIdentifier:@"goBackCarModelView" sender:nil];
    }]];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"NO" style: UIAlertActionStyleDefault handler:nil]];
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
}

-(void) writeDataToPlist{ // store information into temporary database
    //use plist（automatically create one）
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    NSLog(@"old sandBox is %@",sandBoxDataDic);
    
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
        sandBoxDataDic[@"Distance"]=drivingDistanceArray;
        
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
        sandBoxDataDic[@"Distance"]=drivingDistanceArray;
        
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
    NSLog(@"new sandBox is %@",sandBoxDataDic);
}

- (IBAction)goBackCarModelView:(id)sender {
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
            [self getAverageMPG]; //get average MPG
            detailLabel.text =@"AverageMPG";
            dataLabel.text=[dictionary valueForKey:@"AverageMPG"];
        }else if(indexPath.row==8){
            [self getFuelCost];//get fuel cost
            detailLabel.text =@"Fuel Cost";
            dataLabel.text=[dictionary valueForKey:@"FuelCost"];
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
        }else if(indexPath.row==12){
            [self getSharpBrakingTimes]; //get sharp braking times
            detailLabel.text =@"Sharp Braking Times";
            dataLabel.text=[dictionary valueForKey:@"SharpBrakingTimes"];
        }

    return cell;
}

-(void)getDrivingDistance //get driving distance
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];

    float drivingDistanceEachSecond=([[dictionary valueForKey:@"Speed"] floatValue]+[[dictionary valueForKey:@"PreviousSpeed"] floatValue])*interval/2/3600; // calculate distance using Calculus
    [dictionary setValue:[NSString stringWithFormat:@"%.2f", drivingDistanceEachSecond] forKey:@"DrivingDistanceForEachSecond"];
    
    totalDistance+=drivingDistanceEachSecond;
     [dictionary setValue:[NSString stringWithFormat:@"%.2f", totalDistance] forKey:@"DrivingDistance"];
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
    
    MPG=7.718*1.6*[[dictionary valueForKey:@"Speed"] floatValue]/[[dictionary valueForKey:@"MAF"] floatValue]; //MPG = (14.7 * 6.17 * 454 * VSS) / (3600 * MAF)= 7.718 * VSS(km/h) / MAF(g/h)
    
    [dictionary setValue:[NSString stringWithFormat:@"%.2f", MPG] forKey:@"RealtimeMPG"];
}

-(void)getTotalOilConsumption //get total oil consumption
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    if([[dictionary valueForKey:@"RealtimeMPG"] floatValue]==0){
        totalOilConsumption+=0;
    }else{
        NSLog(@"DrivingDistanceForEachSecond:%f", [[dictionary valueForKey:@"DrivingDistanceForEachSecond"] floatValue]);
        totalOilConsumption+=([[dictionary valueForKey:@"DrivingDistanceForEachSecond"] floatValue])/([[dictionary valueForKey:@"RealtimeMPG"] floatValue]); //totalOilConsumption+=DrivingDistanceForEachSecond/Realtime MPG
    }

    NSLog(@"OIL CONSUMPTION:%.2f", totalOilConsumption);
    [dictionary setValue:[NSString stringWithFormat:@"%.2f", totalOilConsumption] forKey:@"TotalOilConsumption"];
    
}

-(void)getFuelCost //get fuel cost
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    fuelCost=[[dictionary valueForKey:@"TotalOilConsumption"] floatValue]*[[dictionary valueForKey:@"OilPrice"] floatValue]; // fuel cost=Total oil Consumption(g) * oil price
    [dictionary setValue:[NSString stringWithFormat:@"%.2f",fuelCost] forKey:@"FuelCost"];
}

-(void)getAverageMPG //get average MPG
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    if(totalOilConsumption!=0){
        averageMPG=[[dictionary valueForKey:@"DrivingDistance"] floatValue]/totalOilConsumption;
        [dictionary setValue:[NSString stringWithFormat:@"%.2f", averageMPG] forKey:@"AverageMPG"];
    }else{
        [dictionary setValue:@"0.00" forKey:@"AverageMPG"];
    }

}

-(void)getSharpAccelerationTimes //get sharp acceleration times
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([[dictionary valueForKey:@"Speed"] floatValue]-[[dictionary valueForKey:@"PreviousSpeed"] floatValue]>10){
        sharpAccelerationTimes++;
        [dictionary setValue:[NSString stringWithFormat:@"%d",sharpAccelerationTimes] forKey:@"SharpAccelerationTimes"];
    }
}

-(void)getSharpBrakingTimes //get sharp braking times
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([[dictionary valueForKey:@"Speed"] floatValue]-[[dictionary valueForKey:@"PreviousSpeed"] floatValue]<-10){
        sharpBrakingTimes++;
        [dictionary setValue:[NSString stringWithFormat:@"%d",sharpBrakingTimes] forKey:@"SharpBrakingTimes"];
    }
}


@end
