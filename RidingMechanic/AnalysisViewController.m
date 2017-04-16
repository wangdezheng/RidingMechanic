//
//  AnalysisViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 3/23/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "AnalysisViewController.h"
#import "ASDayPicker.h"

@interface AnalysisViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *showTripInfoTableView;
@property (strong,nonatomic) NSMutableArray * targetArray;
@property (strong, nonatomic) IBOutlet ASDayPicker *datepicker;
@property (strong, nonatomic)  UILabel *timeLabel;


@end

@implementation AnalysisViewController

-(NSMutableArray *)targetArray
{
    if(!_targetArray){
        _targetArray=[[NSMutableArray alloc] init];
    }
    return _targetArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self test];
    self.targetArray=[self getDataFromPlist:[NSString stringWithFormat:@"%@",[NSDate date]]];
    
    self.showTripInfoTableView.delegate=self;
    self.showTripInfoTableView.dataSource=self;
    
    self.timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.datepicker.frame.size.width/2-50, self.datepicker.frame.size.height-25, 80,20)];
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
    [self.showTripInfoTableView reloadData];
    
    
}

-(void) test{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    if(!sandBoxDataDic){
         sandBoxDataDic = [NSMutableDictionary new];
        NSLog(@"111");
        NSMutableArray * startDateTimeArray=[[NSMutableArray alloc] init];//store start date and time
        [startDateTimeArray addObject:@"2017-04-13 08:12"];
        [startDateTimeArray addObject:@"2017-04-13 22:12"];
        [startDateTimeArray addObject:@"2017-04-14 09:12"];
        sandBoxDataDic[@"StartDateTime"]=startDateTimeArray;
        
        NSMutableArray * endDateTimeArray=[[NSMutableArray alloc] init];//store start date and time
        [endDateTimeArray addObject:@"2017-04-13 09:12"];
        [endDateTimeArray addObject:@"2017-04-13 23:12"];
        [endDateTimeArray addObject:@"2017-04-14 10:12"];
        sandBoxDataDic[@"EndDateTime"] = endDateTimeArray;
        
        NSMutableArray * drivingDistanceArray=[[NSMutableArray alloc] init];//store driving distance
        [drivingDistanceArray addObject:@"15"];
        [drivingDistanceArray addObject:@"30"];
        [drivingDistanceArray addObject:@"40"];
        sandBoxDataDic[@"Distance"]=drivingDistanceArray;
        
        NSMutableArray * MPGArray=[[NSMutableArray alloc] init];//store average MPG
        [MPGArray addObject:@"15.0"];
        [MPGArray addObject:@"16.0"];
        [MPGArray addObject:@"17.0"];
        sandBoxDataDic[@"AverageMPG"]=MPGArray;
        
        NSMutableArray * speedArray=[[NSMutableArray alloc] init];//store average speed
        [speedArray addObject:@"30.0"];
        [speedArray addObject:@"35.0"];
        [speedArray addObject:@"36.0"];
        sandBoxDataDic[@"AverageSpeed"]=speedArray;
        
        NSMutableArray * fuelCostArray=[[NSMutableArray alloc] init];//store fuel cost
        [fuelCostArray addObject:@"2.5"];
        [fuelCostArray addObject:@"3.5"];
        [fuelCostArray addObject:@"3.6"];
        sandBoxDataDic[@"FuelCost"]=fuelCostArray;
        
        NSMutableArray * accelerationArray=[[NSMutableArray alloc] init];//store Sharp Acceleration Times
        [accelerationArray addObject:@"1"];
        [accelerationArray addObject:@"2"];
        [accelerationArray addObject:@"3"];
        sandBoxDataDic[@"SharpAccelerationTimes"]=accelerationArray;
        
        NSMutableArray * brakingArray=[[NSMutableArray alloc] init];//store store Sharp braking Times
        [brakingArray addObject:@"2"];
        [brakingArray addObject:@"3"];
        [brakingArray addObject:@"4"];
        sandBoxDataDic[@"SharpBrakingTimes"]=brakingArray;
    }
    

    
    NSLog(@"new sandBox is %@",sandBoxDataDic);
    
    
    [sandBoxDataDic writeToFile:filePatch atomically:YES];
    sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    NSLog(@"new sandBox is %@",sandBoxDataDic);
}

-(NSMutableArray *) getDataFromPlist:(NSString *)dateTime{  //get corresponding data according to specific date
    //get sand box path
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
   
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    NSLog(@"SAND BOX:%@",sandBoxDataDic);
    NSMutableArray *indexArray=[[NSMutableArray alloc] init];
    if (sandBoxDataDic) {
         NSLog(@"Date:%@",dateTime);
        NSArray *dateArray=[[NSArray alloc] init];
        dateArray=sandBoxDataDic[@"StartDateTime"];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=@"1";
    
    return cell;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    NSString *sectionName=@"";
    
    //get sand box path
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];

    if(sandBoxDataDic){
        NSMutableArray * startdateArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"StartDateTime"]];
        NSMutableArray * enddateArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"EndDateTime"]];
        sectionName=[startdateArray objectAtIndex:[self.targetArray[section] integerValue]];
        sectionName=[sectionName stringByAppendingString:@"-----"];
        sectionName=[sectionName stringByAppendingString:[enddateArray objectAtIndex:[self.targetArray[section] integerValue]]];
    }
    return sectionName;
}



@end
