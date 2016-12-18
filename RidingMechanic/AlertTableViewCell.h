//
//  AlertTableViewCell.h
//  RidingMechanic
//
//  Created by 王德正  on 12/14/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UITextField *speedTextField;
@property (strong, nonatomic) IBOutlet UILabel *speedLabel;
@property (strong, nonatomic) IBOutlet UITextField *tiredDrivingTextField;
@property (strong, nonatomic) IBOutlet UITextField *waterTemperatureTextField;
@property (strong, nonatomic) IBOutlet UILabel *waterTemperatureLabel;


@end
