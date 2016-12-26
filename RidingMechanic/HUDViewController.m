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
    CAAnimation *animation=[self animationForTabBarView:self.tabBarView];
    [self.tabBarView.layer addAnimation:animation forKey:@"moveTabBar"];

    if(self.tabBarView.center.y<self.view.frame.size.height){
        self.tabBarView.center=CGPointMake(self.tabBarView.center.x, self.tabBarView.center.y+60);
    }else{
        self.tabBarView.center=CGPointMake(self.tabBarView.center.x, self.tabBarView.center.y-60);
    }
    [self.view setNeedsDisplay];
}

-(CAAnimation *) animationForTabBarView:(UIView *) tabBarView
{
    CABasicAnimation * positionAnimation = [CABasicAnimation animationWithKeyPath: @"position"];
    positionAnimation.fromValue=[NSValue valueWithCGPoint:tabBarView.center];
    if(tabBarView.center.y<self.view.frame.size.height){
        positionAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(tabBarView.center.x, tabBarView.center.y+60)];
    }else{
        positionAnimation.toValue=[NSValue valueWithCGPoint:CGPointMake(tabBarView.center.x, tabBarView.center.y-60)];
    }
    positionAnimation.duration=0.5;
    
    return positionAnimation;
}


@end
