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
@property (strong, nonatomic) IBOutlet UILabel *lineLabel;
@property (strong, nonatomic) IBOutlet UILabel *upperLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *bottomLineLabel;


@end

@implementation RootViewController


-(void) viewWillAppear:(BOOL)animated
{

    //[self.routeAnalysisLabel setBackgroundColor:[UIColor cyanColor] ];
    //[self.healthScanLabel setBackgroundColor:[UIColor cyanColor]];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    self.lineLabel.layer.borderWidth=0.5;
    self.upperLineLabel.layer.borderWidth=0.5;
    self.bottomLineLabel.layer.borderWidth=0.5;
}

@end
