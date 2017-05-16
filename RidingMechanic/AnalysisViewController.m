//
//  AnalysisViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 3/23/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "AnalysisViewController.h"
#import "ASDayPicker.h"
#import "ShowTripInfoTableViewCell.h"

@interface AnalysisViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UILabel *totalCostLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalMileLabel;
@property (strong, nonatomic) IBOutlet UILabel *totalMileUnitLabel;

@property (strong, nonatomic) IBOutlet UILabel *totalOilConsumptionLabel;

@property (strong, nonatomic) IBOutlet UITableView *showTripInfoTableView;
@property (strong,nonatomic) ShowTripInfoTableViewCell * tripInfoCell;
@property (strong,nonatomic) NSMutableArray * targetArray;
@property (strong, nonatomic) IBOutlet ASDayPicker *datepicker;
@property (strong, nonatomic)  UILabel *timeLabel;

@property (strong,nonatomic) NSMutableDictionary * localTrip;


@end

@implementation AnalysisViewController
float totoalCost=0;
float totoalMile=0;
float totoalOilConsumption=0;


-(NSMutableArray *)targetArray
{
    if(!_targetArray){
        _targetArray=[[NSMutableArray alloc] init];
    }
    return _targetArray;
}

-(NSMutableDictionary *)localTrip
{
    if(!_localTrip){
        _localTrip=[[NSMutableDictionary alloc] init];
    }
    return _localTrip;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test];
    self.targetArray=[self getDataFromPlist:[NSString stringWithFormat:@"%@",[NSDate date]]];
    
    self.showTripInfoTableView.delegate=self;
    self.showTripInfoTableView.dataSource=self;
    
    self.timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.datepicker.frame.size.width/2-40, self.datepicker.frame.size.height-20, 80,20)];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.datepicker addSubview:self.timeLabel];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekday:2]; // Monday
    [components setWeekdayOrdinal:1]; // The first Monday in the month
    [components setMonth:4]; // April
    [components setYear:2016];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *startDate = [gregorian dateFromComponents:components];
    
    self.datepicker.selectedDateBackgroundImage = [UIImage imageNamed:@"selection"];
    [self.datepicker setStartDate:startDate endDate:[NSDate date]];
    [self.datepicker addObserver:self forKeyPath:@"selectedDate" options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew context:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    NSString *newFilePatch = [path stringByAppendingPathComponent:@"NewTripInfo.plist"];
    NSMutableDictionary *newSandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:newFilePatch]; // new added trip
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    if([newSandBoxDataDic valueForKey:@"StartDateTime"]){ //new added trip is not empty
        NSMutableArray * startDateTimeArray=[[NSMutableArray alloc] init];
        NSMutableArray * endDateTimeArray=[[NSMutableArray alloc] init];
        NSMutableArray * drivingDistanceArray=[[NSMutableArray alloc] init];
        NSMutableArray * MPGArray=[[NSMutableArray alloc] init];
        NSMutableArray * speedArray=[[NSMutableArray alloc] init];
        NSMutableArray * fuelCostArray=[[NSMutableArray alloc] init];
        NSMutableArray * accelerationArray=[[NSMutableArray alloc] init];
        NSMutableArray * brakingArray=[[NSMutableArray alloc] init];
        if([sandBoxDataDic valueForKey:@"startDateTime"]){ //local trip database is not empty
            startDateTimeArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"startDateTime"]];
            endDateTimeArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"endDateTime"]];
            drivingDistanceArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"drivingDistance"]];
            MPGArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"averageMPG"]];
            speedArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"averageSpeed"]];
            fuelCostArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"fuelCost"]];
            accelerationArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"sharpAccelerationTime"]];
            brakingArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"sharpBrakingTime"]];
            
            NSMutableArray * new=[[NSMutableArray alloc] initWithArray:newSandBoxDataDic[@"StartDateTime"]];
            for(int i=0;i<new.count;i++){
                [startDateTimeArray addObject:newSandBoxDataDic[@"StartDateTime"][i]];
                [endDateTimeArray addObject:newSandBoxDataDic[@"EndDateTime"][i]];
                [drivingDistanceArray addObject:newSandBoxDataDic[@"DrivingDistance"][i]];
                [MPGArray addObject:newSandBoxDataDic[@"AverageMPG"][i]];
                [speedArray addObject:newSandBoxDataDic[@"AverageSpeed"][i]];
                [fuelCostArray addObject:newSandBoxDataDic[@"FuelCost"][i]];
                [accelerationArray addObject:newSandBoxDataDic[@"SharpAccelerationTimes"][i]];
                [brakingArray addObject:newSandBoxDataDic[@"SharpBrakingTimes"][i]];
            }
        }else{
            NSMutableArray * new=[[NSMutableArray alloc] initWithArray:newSandBoxDataDic[@"StartDateTime"]];
            for(int i=0;i<new.count;i++){
                [startDateTimeArray addObject:newSandBoxDataDic[@"StartDateTime"][i]];
                [endDateTimeArray addObject:newSandBoxDataDic[@"EndDateTime"][i]];
                [drivingDistanceArray addObject:newSandBoxDataDic[@"DrivingDistance"][i]];
                [MPGArray addObject:newSandBoxDataDic[@"AverageMPG"][i]];
                [speedArray addObject:newSandBoxDataDic[@"AverageSpeed"][i]];
                [fuelCostArray addObject:newSandBoxDataDic[@"FuelCost"][i]];
                [accelerationArray addObject:newSandBoxDataDic[@"SharpAccelerationTimes"][i]];
                [brakingArray addObject:newSandBoxDataDic[@"SharpBrakingTimes"][i]];
            }
        }
        [sandBoxDataDic setObject:startDateTimeArray forKey:@"startDateTime"];
        [sandBoxDataDic setObject:endDateTimeArray forKey:@"endDateTime"];
        [sandBoxDataDic setObject:drivingDistanceArray forKey:@"drivingDistance"];
        [sandBoxDataDic setObject:MPGArray forKey:@"averageMPG"];
        [sandBoxDataDic setObject:speedArray forKey:@"averageSpeed"];
        [sandBoxDataDic setObject:fuelCostArray forKey:@"fuelCost"];
        [sandBoxDataDic setObject:accelerationArray forKey:@"sharpAccelerationTime"];
        [sandBoxDataDic setObject:brakingArray forKey:@"sharpBrakingTime"];
    }
    self.localTrip=[[NSMutableDictionary alloc] initWithDictionary:sandBoxDataDic];
    NSLog(@"Total:%@",self.localTrip);
    
    NSDate *day = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:day]; //convert to require format
    
    self.timeLabel.text =  [NSDateFormatter localizedStringFromDate:day dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    
    
    self.targetArray=[self getDataFromPlist:DateTime];
    [self.showTripInfoTableView reloadData];//reload data in table
    [self updateTotal];
    self.totalCostLabel.text=[NSString stringWithFormat:@"%.2f",totoalCost];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Unit"] isEqualToString:@"0"]){ //metric
        self.totalMileUnitLabel.text=@"km";
        self.totalMileLabel.text=[NSString stringWithFormat:@"%.2f",totoalMile*1.6];
    }else{
        self.totalMileUnitLabel.text=@"mile";
        self.totalMileLabel.text=[NSString stringWithFormat:@"%.2f",totoalMile];
    }
    self.totalOilConsumptionLabel.text=[NSString stringWithFormat:@"%.2f",totoalOilConsumption];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSDate *day = change[NSKeyValueChangeNewKey];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSString *DateTime = [formatter stringFromDate:day]; //convert to require format
    
    self.timeLabel.text =  [NSDateFormatter localizedStringFromDate:day dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
    
    self.targetArray=[self getDataFromPlist:DateTime];
    
    [self.showTripInfoTableView reloadData];//reload data in table
    
    [self updateTotal];
    self.totalCostLabel.text=[NSString stringWithFormat:@"%.2f",totoalCost];
    
    if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Unit"] isEqualToString:@"0"]){ //metric
        self.totalMileUnitLabel.text=@"km";
        self.totalMileLabel.text=[NSString stringWithFormat:@"%.2f",totoalMile*1.6];
    }else{
        self.totalMileUnitLabel.text=@"mile";
        self.totalMileLabel.text=[NSString stringWithFormat:@"%.2f",totoalMile];
    }
    self.totalOilConsumptionLabel.text=[NSString stringWithFormat:@"%.2f",totoalOilConsumption];
    
}

-(void) updateTotal{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    totoalCost=0;
    totoalMile=0;
    totoalOilConsumption=0;
    if(self.localTrip){
       NSMutableArray * costArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"fuelCost"]];
        NSLog(@"COST:%@",costArray);
       NSMutableArray * distanceArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"drivingDistance"]];
        for(int i=0;i<self.targetArray.count;i++){
            totoalCost+=[[costArray objectAtIndex:[self.targetArray[i] integerValue]] floatValue];
            totoalMile+=[[distanceArray objectAtIndex:[self.targetArray[i] integerValue]] floatValue];
            totoalOilConsumption+=totoalCost/[[dictionary valueForKey:@"FuelPrice"] floatValue];
        }
    }
}

-(NSMutableArray *) getDataFromPlist:(NSString *)dateTime{  //get corresponding data according to specific date
    NSMutableArray *indexArray=[[NSMutableArray alloc] init];
    if (self.localTrip) {
        NSArray *dateArray=[[NSArray alloc] init];
        dateArray=self.localTrip[@"startDateTime"];
        for(int i=0;i<dateArray.count;i++){
            if([[dateArray[i] substringWithRange:NSMakeRange(0, 10)] isEqualToString:dateTime]){
                [indexArray addObject:[NSNumber numberWithInteger:i]];
            }
        }
        
    }
    return  indexArray;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.targetArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    self.tripInfoCell= (ShowTripInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"tripInfoCell" forIndexPath:indexPath];
    
    if(self.localTrip){
        NSMutableArray * costArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"fuelCost"]];
        NSMutableArray * MPGArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"averageMPG"]];
        NSMutableArray * distanceArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"drivingDistance"]];
        NSMutableArray * accelArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"sharpAccelerationTime"]];
        NSMutableArray * brakingArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"sharpBrakingTime"]];
        
        float cost=[[costArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] floatValue];
        self.tripInfoCell.costLabel.text=[NSString stringWithFormat:@"%.2f",cost];

        if([[[NSUserDefaults standardUserDefaults] objectForKey:@"Unit"] isEqualToString:@"0"]){ //metric
            self.tripInfoCell.mileUnitLabel.text=@"km";
            float distance=[[distanceArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] floatValue];
            distance=distance*1.6;
            self.tripInfoCell.mileLabel.text=[NSString stringWithFormat:@"%.2f",distance];
        }else{
            self.tripInfoCell.mileUnitLabel.text=@"mile";
            float distance=[[distanceArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] floatValue];
            self.tripInfoCell.mileLabel.text=[NSString stringWithFormat:@"%.2f",distance];
        }

        float mpg=[[MPGArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] floatValue];
        self.tripInfoCell.MPGLabel.text=[NSString stringWithFormat:@"%.2f",mpg];
        
        self.tripInfoCell.accelerationButton.userInteractionEnabled=NO;
        [self.tripInfoCell.accelerationButton setTitle:[[accelArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue] forState:UIControlStateNormal];
        
        self.tripInfoCell.brakingButton.userInteractionEnabled=NO;
        [self.tripInfoCell.brakingButton setTitle:[[brakingArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue] forState:UIControlStateNormal];
    }
    
    return self.tripInfoCell;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    NSString *sectionName=@"";

    if(self.localTrip){
        NSMutableArray * startdateArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"startDateTime"]];
        NSMutableArray * enddateArray=[[NSMutableArray alloc] initWithArray:self.localTrip[@"endDateTime"]];
        
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        NSString *str=[startdateArray objectAtIndex:[self.targetArray[section] integerValue]];
        
        NSString *start=@"";
        NSString *end=@"";
        
        if(str.length>20){
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSSZ"];
            NSDate *startDate = [dateFormatter dateFromString:[startdateArray objectAtIndex:[self.targetArray[section] integerValue]]];
            NSDate *endDate = [dateFormatter dateFromString:[enddateArray objectAtIndex:[self.targetArray[section] integerValue]]];
            
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd hh:mm"];
             start= [formatter stringFromDate:startDate];
             end=[formatter stringFromDate:endDate];
        }else{
            start=[startdateArray objectAtIndex:[self.targetArray[section] integerValue]];
            end=[enddateArray objectAtIndex:[self.targetArray[section] integerValue]];
        }
        

        sectionName=start;
        sectionName=[sectionName stringByAppendingString:@"-----"];
        sectionName=[sectionName stringByAppendingString:end];

    }
    return sectionName;
}





@end
