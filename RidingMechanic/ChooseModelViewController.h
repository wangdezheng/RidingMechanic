//
//  ChooseModelViewController.h
//  RidingMechanic
//
//  Created by 王德正  on 11/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CarModel+CoreDataProperties.h"

@interface ChooseModelViewController : UITableViewController
@property (strong,nonatomic) NSFetchedResultsController* fetchedRequestController;
@property (strong,nonatomic) NSManagedObjectContext* managedObjectContex;
@property (strong,nonatomic) AppDelegate *myDelegate;
@end
