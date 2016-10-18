//
//  CarModel+ConfigurationModel.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 17/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModel+ConfigurationModel.h"

@implementation CarModel (ConfigurationModel)

-(void) loadCarModel
{
    NSManagedObject *carModel=[NSEntityDescription insertNewObjectForEntityForName:@"CarModel" inManagedObjectContext:self.managedObjectContext];
    [carModel setValue:@"Ford" forKey:@"brand"];
    [carModel setValue:@"2010" forKey:@"year"];
    [carModel setValue:@"Taurus" forKey:@"version"];
    [carModel setValue:@"F250" forKey:@"model"];
    
    [carModel setValue:@"BMW" forKey:@"brand"];
    [carModel setValue:@"2007" forKey:@"year"];
    [carModel setValue:@"525" forKey:@"version"];
    [carModel setValue:@"xi" forKey:@"model"];
}
@end
