//
//  CarModel+CoreDataProperties.m
//  RidingMechanic
//
//  Created by 王德正  on 25/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModel+CoreDataProperties.h"

@implementation CarModel (CoreDataProperties)

+ (NSFetchRequest<CarModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CarModel"];
}

@dynamic brand;
@dynamic model;
@dynamic year;

@end
