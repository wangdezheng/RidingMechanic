//
//  CarModelViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/28/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModelViewController.h"
#import "QueryFromCoreData.h"
#import "Reachability.h"

@interface CarModelViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *wifiStatus;
@property (strong, nonatomic) IBOutlet UIButton *startTripButton;


@end

@implementation CarModelViewController

- (void)viewDidLoad
{
    
}

-(void)viewWillAppear:(BOOL)animated
{
    QueryFromCoreData *query=[[QueryFromCoreData alloc] init];
    if([[query queryWifiStatus ] isEqualToString:@"connected"]){
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi Filled"];
        [self.startTripButton setHidden:NO];
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
