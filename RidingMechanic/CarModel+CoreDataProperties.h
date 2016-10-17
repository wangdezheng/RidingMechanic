//
//  CarModel+CoreDataProperties.h
//  RidingMechanic
//
//  Created by Dezheng Wang  on 16/10/2016.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CarModel (CoreDataProperties)

+ (NSFetchRequest<CarModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *brand;
@property (nullable, nonatomic, copy) NSDecimalNumber *year;
@property (nullable, nonatomic, copy) NSString *version;
@property (nullable, nonatomic, copy) NSString *model;

@end

NS_ASSUME_NONNULL_END
