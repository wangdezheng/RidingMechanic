//
//  CarModel+CoreDataProperties.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 16/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModel+CoreDataProperties.h"

@implementation CarModel (CoreDataProperties)

+ (NSFetchRequest<CarModel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CarModel"];
}

@dynamic brand;
@dynamic year;
@dynamic version;
@dynamic model;

@end
