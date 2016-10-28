//
//  RootViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "RootViewController.h"
#import "QuartzCore/QuartzCore.h"


@interface RootViewController ()
@property (strong, nonatomic) IBOutlet UILabel *imageLabel;
@property (strong, nonatomic) IBOutlet UILabel *carModelLabel;
@property (strong, nonatomic) IBOutlet UILabel *connectionStatusLabel;
@property (strong, nonatomic) IBOutlet UIButton *startLabel;
@property (strong, nonatomic) IBOutlet UILabel *routeAnalysisLabel;
@property (strong, nonatomic) IBOutlet UILabel *healthScanLabel;


@end

@implementation RootViewController


-(void) viewWillAppear:(BOOL)animated
{

    //[self.routeAnalysisLabel setBackgroundColor:[UIColor cyanColor] ];
    //[self.healthScanLabel setBackgroundColor:[UIColor cyanColor]];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.routeAnalysisLabel.layer.borderWidth=0.25;
    self.healthScanLabel.layer.borderWidth=0.3;
}

@end
