//
//  CarModelViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/28/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModelViewController.h"
#import "Reachability.h"
#import "InitSupportedCommand.h"


@interface CarModelViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *wifiStatus;
@property (strong, nonatomic) IBOutlet UIButton *startTripButton;


@end

@implementation CarModelViewController

dispatch_source_t timer;
Boolean status =false;
int n=0;

- (void)viewDidLoad
{
   [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated
{
    NSString * wifiStatus=[[NSUserDefaults standardUserDefaults] objectForKey:@"wifiStatus"];
    NSLog(@"%@",wifiStatus);
    if([wifiStatus isEqualToString:@"connected"]){
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi Filled"];
        [self.startTripButton setHidden:NO];
        
        InitSupportedCommand * init=[[InitSupportedCommand alloc] init];//start to connect to server
        
        status=false;
        status=[init startConnectingToServer];
        if(status){
            NSLog(@"Success! Start sneding initial commands");
            
            dispatch_queue_t  queue = dispatch_get_global_queue(0, 0);
            
            // create timer
            timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            
            //set timer property
            // GCD 1s=10^9 ns
            // start time and time interval
            dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
            
            // call task
            dispatch_source_set_event_handler(timer, ^{
                Session * session=[[Session alloc] init];
                [session sendMessage:@"0100"];
            });
            
            // start timer
            dispatch_resume(timer);
            
        }else{
            NSLog(@"Fail!");
        }
    }else{
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi"];
        [self.startTripButton setHidden:YES];
    }
    
}


-(IBAction)startTrip:(id)sender
{
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
