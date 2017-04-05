//
//  HealthScanViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 3/29/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "HealthScanViewController.h"
#import <HcdProcessView.h>
#import "SendCommand.h"

@interface HealthScanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) HcdProcessView *customView;
@property (strong, nonatomic) UILabel *customLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UITableView *diagInfoTableView;
@property (strong, nonatomic) NSMutableArray *troubleCodeArray;
@property (strong, nonatomic) NSMutableArray *infoArray;

@end

@implementation HealthScanViewController

static dispatch_source_t timerForMain;
int count;


-(NSMutableArray *) troubleCodeArray
{
    if(!_troubleCodeArray)
    {
        _troubleCodeArray=[[NSMutableArray alloc] init];
    }
    return _troubleCodeArray;
}

-(NSMutableArray *) infoArray
{
    if(!_infoArray)
    {
        _infoArray=[[NSMutableArray alloc] init];
    }
    return _infoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.diagInfoTableView.delegate = self;
    self.diagInfoTableView.dataSource=self;
    
    self.customView = [[HcdProcessView alloc] initWithFrame:
                                  CGRectMake(self.view.frame.size.width * 0.18, 100,
                                             self.view.frame.size.width * 0.65,
                                             self.view.frame.size.width * 0.65)];
    self.customView.showBgLineView = YES;
    
    self.customLabel=[[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width * 0.17, 105,
                                                               120,40)];
    [self.customLabel setText:@"0%"];
    [self.customLabel setFont:[UIFont systemFontOfSize:15]];
    self.customLabel.textAlignment = NSTextAlignmentCenter;
    [self.customView addSubview:self.customLabel];
    [self.view addSubview:self.customView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.diagInfoTableView setHidden:YES];
    [self startChecking];
}

- (IBAction)rediagnosis:(id)sender {
    [self.diagInfoTableView setHidden:YES];
    [self startChecking];
}


-(void)startChecking{
    self.customView.percent=0;
    count=0;
    [self.timeLabel setText:@""];
    
    self.customView.percent=1;
    
//     send diagnostic pid to the car
    SendCommand *sendcommand=[SendCommand sharedSendCommand];
    [sendcommand senDiagnosticCode];


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
        [self.customLabel setText:[NSString stringWithFormat:@"%d%%",count]];
        if(count==100){
            dispatch_source_cancel(timerForMain);
            timerForMain=nil;
            [self.timeLabel setText:[self getCurrentTime]];
            [self.diagInfoTableView reloadData];
            if(self.troubleCodeArray.count==0){//doesn't have trouble code
               [self.customLabel setText:@"Congradulations!"];
            }else{
               [self.customLabel setText:@"Trouble Codes!"];
               [self.diagInfoTableView setHidden:NO]; //show trouble code
            }
        }
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([dictionary valueForKey:@"DiagnosticInformation"]){
        NSDictionary *info=[[NSDictionary alloc] init];
        info=[dictionary valueForKey:@"DiagnosticInformation"];
        [self.troubleCodeArray removeAllObjects];// clear array everytime before add object
        [self.infoArray removeAllObjects];
        for(id key in info){
            [self.troubleCodeArray addObject:key];
            [self.infoArray addObject:[info objectForKey:key]];
        }
        return [self.troubleCodeArray count];
    }else{
       return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%@\t%@",self.troubleCodeArray[indexPath.row],self.infoArray[indexPath.row]]];
    
    return cell;
}





@end
