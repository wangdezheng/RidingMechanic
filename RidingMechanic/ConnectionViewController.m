//
//  ConnectionViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 27/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "ConnectionViewController.h"
#import "Reachability.h"

@interface ConnectionViewController ()
@property (strong, nonatomic) IBOutlet UILabel *openWIfiLabel;
@property (strong, nonatomic) IBOutlet UILabel *plugInLbael;
@property (strong, nonatomic) IBOutlet UIButton *imagePortButton;
@property (strong, nonatomic) IBOutlet UIButton *scanButton;
@property (strong, nonatomic) IBOutlet UILabel *connectToDeviceLabel;

@property (strong, nonatomic) IBOutlet UILabel *statusOfWifiLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusOfDevice;
@property (strong, nonatomic) IBOutlet UILabel *statusOfConnectionLabel;

@property (strong, nonatomic) IBOutlet UILabel *hintLabel;


@property (strong, nonatomic) IBOutlet UIButton *confirmButton;

@property Reachability *reachabilityInfo;

-(void)reachabilityChanged: (NSNotification *) aNSNotification;
-(void)readyToPlugIn;

@end

@implementation ConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.openWIfiLabel.layer.borderWidth=0.5;
    self.connectToDeviceLabel.layer.borderWidth=0.5;
    
    [self.imagePortButton setHidden:YES];
    [self.scanButton setHidden:YES];
    
    [self.statusOfWifiLabel setHidden:YES];
    [self.statusOfDevice setHidden:YES];
    [self.statusOfConnectionLabel setHidden:YES];
    
    [self.hintLabel setHidden:YES];
    [self.confirmButton setHidden:YES];
    
    [self.openWIfiLabel setTextColor:[UIColor blueColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    self.reachabilityInfo = [Reachability reachabilityForInternetConnection];
    [self.reachabilityInfo startNotifier];
    
}

-(void)reachabilityChanged: (NSNotification *) aNSNotification{
    Reachability *reachability=[aNSNotification object];
    NetworkStatus status=[reachability currentReachabilityStatus];
    NSLog(@"Status:%ld",status);
    if(status==1){
        [self readyToPlugIn];
    }
}


-(void)readyToPlugIn{
    [self.openWIfiLabel setTextColor:[UIColor cyanColor]];
    [self.statusOfWifiLabel setHidden:NO];
    
    [self.imagePortButton setHidden:NO];
    [self.imagePortButton setEnabled:NO];
    
    [self.scanButton setHidden:NO];
    
    float newY=self.connectToDeviceLabel.frame.origin.y+self.imagePortButton.frame.size.height+self.scanButton.frame.size.height+20;
    self.connectToDeviceLabel.frame = CGRectMake(self.connectToDeviceLabel.frame.origin.x, newY, self.connectToDeviceLabel.frame.size.width,self.connectToDeviceLabel.frame.size.height);
    
    [self.plugInLbael setTextColor:[UIColor blueColor]];
}


-(IBAction) readyToScan:(id)sender{
    [self.plugInLbael setTextColor:[UIColor cyanColor]];
    [self.statusOfDevice setHidden:NO];
    [self.hintLabel setHidden:NO];
    [self.confirmButton setHidden:NO];
    
    [self.connectToDeviceLabel setTextColor:[UIColor blueColor]];
    
    [self.imagePortButton setHidden:YES];
    [self.scanButton setHidden:YES];
    
    float newY=self.connectToDeviceLabel.frame.origin.y-self.imagePortButton.frame.size.height-self.scanButton.frame.size.height-20;
    self.connectToDeviceLabel.frame = CGRectMake(self.connectToDeviceLabel.frame.origin.x, newY, self.connectToDeviceLabel.frame.size.width,self.connectToDeviceLabel.frame.size.height);
}

-(IBAction)checkWifiConneted:(id)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
