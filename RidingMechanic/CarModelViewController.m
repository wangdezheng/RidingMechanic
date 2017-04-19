//
//  CarModelViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/28/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModelViewController.h"
#import "Reachability.h"


@interface CarModelViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *wifiStatus;
@property (strong, nonatomic) IBOutlet UIButton *startTripButton;


@end

@implementation CarModelViewController



- (void)viewDidLoad
{
   [super viewDidLoad];
}


-(void)viewWillAppear:(BOOL)animated
{
    NSString * wifiStatus=[[NSUserDefaults standardUserDefaults] objectForKey:@"wifiStatus"];
    
    if([wifiStatus isEqualToString:@"connected"]){
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi Filled"];
        [self.startTripButton setHidden:NO];
        
    }else{
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi"];
        [self.startTripButton setHidden:NO];
    }
    
}


-(IBAction)startTrip:(id)sender
{
    [self performSegueWithIdentifier:@"showMenu" sender:sender];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
