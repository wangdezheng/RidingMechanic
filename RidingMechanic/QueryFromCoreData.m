//
//  QueryFromCoreData.m
//  RidingMechanic
//
//  Created by 王德正  on 12/5/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "QueryFromCoreData.h"
#import "AppDelegate.h"

@interface QueryFromCoreData()
@property (strong,nonatomic) AppDelegate *myDelegate;

@end

@implementation QueryFromCoreData

-(NSString *)queryWifiStatus
{
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.fetchLimit=1;
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"wifiStatus" ascending:YES selector:@selector(localizedStandardCompare:)]];
    NSError *error = nil;
    if(![self.myDelegate.managedObjectContext executeFetchRequest:request error:&error]){
        NSLog(@"Query Error");
        return @"unconnected";
    }
    Car * car=[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error][0];
    NSLog(@"%@",car.wifiStatus);
    return car.wifiStatus;

}

-(Car *)changeWifiStatus
{
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.fetchLimit=1;
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"wifiStatus" ascending:YES selector:@selector(localizedStandardCompare:)]];
    NSError *error = nil;
    if(![self.myDelegate.managedObjectContext executeFetchRequest:request error:&error]){
        NSLog(@"Query Error");
        return nil;
    }
    Car * car=[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error][0];
    return car;
}
@end
