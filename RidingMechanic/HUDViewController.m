//
//  HUDViewController.m
//  RidingMechanic
//
//  Created by 王德正  on 12/26/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "HUDViewController.h"

@interface HUDViewController ()
@property (strong, nonatomic) IBOutlet UIView *tabBarView;
@property (strong, nonatomic) IBOutlet UIView *titleBarView;

@end

@implementation HUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tabBarController setHidesBottomBarWhenPushed:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)singleTap:(id)sender
{
    CAAnimation *animationForTitle=[self animationForTabBarView:self.titleBarView];
    [self.titleBarView.layer addAnimation:animationForTitle forKey:@"moveTitleBar"];
    if(self.titleBarView.center.y<0){
        self.titleBarView.center=CGPointMake(self.titleBarView.center.x, self.titleBarView.center.y+120);
    }else{
        self.titleBarView.center=CGPointMake(self.titleBarView.center.x, self.titleBarView.center.y-120);
    }

    CAAnimation *animationForTab=[self animationForTabBarView:self.tabBarView];
    [self.tabBarView.layer addAnimation:animationForTab forKey:@"moveTabBar"];

    if(self.tabBarView.center.y<self.view.frame.size.height){
        self.tabBarView.center=CGPointMake(self.tabBarView.center.x, self.tabBarView.center.y+60);
    }else{
        self.tabBarView.center=CGPointMake(self.tabBarView.center.x, self.tabBarView.center.y-60);
    }
    
    [self.view setNeedsDisplay];
}

-(CAAnimation *) animationForTitleBarView:(UIView *) titleBarView
{
    CABasicAnimation * positionAnimation = [CABasicAnimation animationWithKeyPath: @"position"];
    positionAnimation.fromValue=[NSValue valueWithCGPoint:titleBarView.center];

    positionAnimation.duration=0.5;
    
    return positionAnimation;
}

-(CAAnimation *) animationForTabBarView:(UIView *) tabBarView
{
    CABasicAnimation * positionAnimation = [CABasicAnimation animationWithKeyPath: @"position"];

    positionAnimation.duration=0.5;
    
    return positionAnimation;
}



@end
