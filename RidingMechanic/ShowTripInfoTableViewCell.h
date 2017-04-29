//
//  ShowTripInfoTableViewCell.h
//  RidingMechanic
//
//  Created by Dezheng Wang on 4/16/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTripInfoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *costLabel;
@property (strong, nonatomic) IBOutlet UILabel *mileLabel;
@property (strong, nonatomic) IBOutlet UILabel *mileUnitLabel;

@property (strong, nonatomic) IBOutlet UILabel *MPGLabel;
@property (strong, nonatomic) IBOutlet UIButton *accelerationButton;
@property (strong, nonatomic) IBOutlet UIButton *brakingButton;

@end
