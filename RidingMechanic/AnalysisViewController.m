//
//  AnalysisViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 3/23/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "AnalysisViewController.h"
#import "ASDayPicker.h"

@interface AnalysisViewController ()
@property (strong, nonatomic) IBOutlet UITableView *showTripInfoTableView;
@property (strong, nonatomic) IBOutlet ASDayPicker *datepicker;
@property (strong, nonatomic)  UILabel *timeLabel;


@end

@implementation AnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.datepicker.frame.size.width/2-40, self.datepicker.frame.size.height-20, 80,20)];
    [self.timeLabel setFont:[UIFont systemFontOfSize:13]];
    
    [self.datepicker addSubview:self.timeLabel];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekday:2]; // Monday
    [components setWeekdayOrdinal:1]; // The first Monday in the month
    [components setMonth:4]; // April
    [components setYear:2017];
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
    self.timeLabel.text =  [NSDateFormatter localizedStringFromDate:day dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
