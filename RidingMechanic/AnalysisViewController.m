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
@property (strong, nonatomic) IBOutlet ASDayPicker *datepicker;
@property (strong, nonatomic)  UILabel *timeLabel;


@end

@implementation AnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showTripInfoTableView.delegate=self;
    self.showTripInfoTableView.dataSource=self;
//    CGRect frame = self.showTripInfoTableView.tableHeaderView.frame;
//    frame.size.height = 1;
//    UIView *headerView = [[UIView alloc] initWithFrame:frame];
//    [self.self.showTripInfoTableView setTableHeaderView:headerView];
    
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
    self.timeLabel.text =  [NSDateFormatter localizedStringFromDate:day dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterNoStyle];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text=@"1";
    
    return cell;
}

- (NSString *) tableView: (UITableView *) tableView titleForHeaderInSection: (NSInteger) section {
    NSString *sectionName;
    switch (section)
    {
        case 0:
            sectionName=@"04-01 12:00";
            break;
        case 1:
            sectionName=@"03-01 10:00";
            break;
        default:
            break;
    }
    return sectionName;
}



@end
