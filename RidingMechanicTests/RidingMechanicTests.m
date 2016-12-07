//
//  RidingMechanicTests.m
//  RidingMechanicTests
//
//  Created by Dezheng Wang  on 9/14/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "Car+CoreDataClass.h"


@interface RidingMechanicTests : XCTestCase
@property (strong,nonatomic) AppDelegate *myDelegate;

@end

@implementation RidingMechanicTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testQueryWifiStatus {
    self.myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:@"Car"];
    request.fetchLimit=1;
    request.predicate=nil;
    request.sortDescriptors=@[[NSSortDescriptor sortDescriptorWithKey:@"wifiStatus" ascending:YES selector:@selector(localizedStandardCompare:)]];
    NSError *error = nil;
    if(![self.myDelegate.managedObjectContext executeFetchRequest:request error:&error]){
        NSLog(@"Query Error");
    }
    NSArray *results=[self.myDelegate.managedObjectContext executeFetchRequest:request error:&error];
    XCTAssertNil(error);
    XCTAssertEqual(results.count, 1);
    NSDictionary * result = results[0];
    XCTAssertEqual(result[@"wifiStatus"], @"unconnected");
    
}


- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
