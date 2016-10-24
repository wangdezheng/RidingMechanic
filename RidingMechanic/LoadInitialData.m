//
//  LoadInitialData.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 24/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "LoadInitialData.h"


@implementation LoadInitialData

- (void)loadInitialData
{
    //get app delegate
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CarModel *car1=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    
    [car1 setBrand:@"HONDA"];
    [car1 setYear:@"2010"];
    [car1 setVersion:@"Taurus"];
    [car1 setModel:@"F250"];
    
    CarModel *car2=(CarModel *)[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext: self.myDelegate.managedObjectContext];
    
    [car2 setBrand:@"Chevrolet"];
    [car2 setYear:@"2007"];
    [car2 setVersion:@"525"];
    [car2 setModel:@"xi"];
    
    NSError *error;
    BOOL isSaveSuccess = [self.myDelegate.managedObjectContext save:&error];
    
    if (!isSaveSuccess) {
        NSLog(@"Error: %@,%@",error,[error userInfo]);
    }else {
        NSLog(@"Save successful!");
    }
    
}

@end
