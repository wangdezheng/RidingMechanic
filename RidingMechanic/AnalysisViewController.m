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
@property (strong, nonatomic) IBOutlet UILabel *totalOilConsumptionLabel;

@property (strong, nonatomic) IBOutlet UITableView *showTripInfoTableView;
@property (strong,nonatomic) ShowTripInfoTableViewCell * tripInfoCell;
@property (strong,nonatomic) NSMutableArray * targetArray;
@property (strong, nonatomic) IBOutlet ASDayPicker *datepicker;
@property (strong, nonatomic)  UILabel *timeLabel;


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

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self test];
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
    
    [self.showTripInfoTableView reloadData];//reload data in table
    
    [self updateTotal];
    self.totalCostLabel.text=[NSString stringWithFormat:@"%.1f",totoalCost];
    self.totalMileLabel.text=[NSString stringWithFormat:@"%.1f",totoalMile];
    self.totalOilConsumptionLabel.text=[NSString stringWithFormat:@"%.1f",totoalOilConsumption];
    
}

-(void) updateTotal{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if(sandBoxDataDic){
       NSMutableArray * costArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"FuelCost"]];
       NSMutableArray * distanceArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"DrivingDistance"]];
        for(int i=0;i<self.targetArray.count;i++){
            totoalCost+=[[costArray objectAtIndex:[self.targetArray[i] integerValue]] floatValue];
            totoalMile+=[[distanceArray objectAtIndex:[self.targetArray[i] integerValue]] floatValue];
            totoalOilConsumption+=totoalCost/[[dictionary valueForKey:@"OilPrice"] floatValue];
        }
    }
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
    self.tripInfoCell= (ShowTripInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"tripInfoCell" forIndexPath:indexPath];
    //get sand box path
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
    
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    
    if(sandBoxDataDic){
        NSMutableArray * costArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"FuelCost"]];
        NSMutableArray * MPGArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"AverageMPG"]];
        NSMutableArray * distanceArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"DrivingDistance"]];
        NSMutableArray * accelArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"SharpAccelerationTimes"]];
        NSMutableArray * brakingArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"SharpBrakingTimes"]];
        
        self.tripInfoCell.costLabel.text=[[costArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue];
        
        self.tripInfoCell.mileLabel.text=[[distanceArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue];
        
        self.tripInfoCell.MPGLabel.text=[[MPGArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue];
        
        self.tripInfoCell.accelerationButton.userInteractionEnabled=NO;
        [self.tripInfoCell.accelerationButton setTitle:[[accelArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue] forState:UIControlStateNormal];
        
        self.tripInfoCell.brakingButton.userInteractionEnabled=NO;
        [self.tripInfoCell.brakingButton setTitle:[[brakingArray objectAtIndex:[[self.targetArray objectAtIndex:indexPath.section] integerValue]] stringValue] forState:UIControlStateNormal];
    }
    
    return self.tripInfoCell;
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
