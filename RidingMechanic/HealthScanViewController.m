//
//  HealthScanViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 3/29/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "HealthScanViewController.h"
#import <HcdProcessView.h>

@interface HealthScanViewController ()

@property (strong, nonatomic) HcdProcessView *customView;
@property (strong, nonatomic) UILabel *customLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UIButton *examineButton;

@end

@implementation HealthScanViewController

static dispatch_source_t timerForMain;
int count;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.customView = [[HcdProcessView alloc] initWithFrame:
                                  CGRectMake(self.view.frame.size.width * 0.18, 100,
                                             self.view.frame.size.width * 0.65,
                                             self.view.frame.size.width * 0.65)];
    self.customView.showBgLineView = YES;
    
    self.customLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.28, 105,
                                                               80,40)];
    [self.customLabel setText:@"0%"];
    [self.customView addSubview:self.customLabel];
    [self.view addSubview:self.customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self startChecking];

}

- (IBAction)rediagnosis:(id)sender {
    [self startChecking];
}


-(void)startChecking{
    self.customView.percent=0;
    count=0;
    [self.timeLabel setText:@""];
    
    self.customView.percent=1;
    
    dispatch_queue_t mainQueue = dispatch_get_main_queue();  // main thread
    
    // create timer
    timerForMain = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
    
    //set timer property
    // GCD 1s=10^9 ns
    // start time and time interval
    dispatch_source_set_timer(timerForMain, DISPATCH_TIME_NOW, 0.044 * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timerForMain, ^{
        count++;
        if(count==100){
            dispatch_source_cancel(timerForMain);
            timerForMain=nil;
            [self.timeLabel setText:[self getCurrentTime]];
        }
        [self.customLabel setText:[NSString stringWithFormat:@"%d%%",count]];
        [self.view setNeedsDisplay];
        
    });
    
    // start timer
    dispatch_resume(timerForMain);
}

-(NSString *)getCurrentTime{
    NSDate *date = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    NSString *DateTime = [formatter stringFromDate:date];
    
    return DateTime;
}



@end
