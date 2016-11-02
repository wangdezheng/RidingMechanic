//
//  RidingMechanicUITests.m
//  RidingMechanicUITests
//
//  Created by Dezheng Wang  on 9/14/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface RidingMechanicUITests : XCTestCase

@end

@implementation RidingMechanicUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}


- (void)testIfConnectionWork {  //test if the  "Connect to device screen exists"
    XCUIApplication *app=[[XCUIApplication alloc] init];
    [app.buttons[@"Start Connecting"] tap];
    XCTAssert(app.staticTexts[@"    Open WIFI"].exists);
}

-(void) testWifiCloseDisplay{ //test when wifi closes, if the screen can display normally
    XCUIApplication *app=[[XCUIApplication alloc] init];
    [app.buttons[@"Start Connecting"] tap];
    
    XCTAssert(app.staticTexts[@"    Open WIFI"].exists);
    XCTAssert(app.staticTexts[@"    Plug in device"].exists);
    XCTAssert(app.staticTexts[@"    Connect to device"].exists);
    
    XCTAssert(!app.buttons[@"Device plugged please scan now"].exists);
    XCTAssert(!app.buttons[@"imagePortButton"].exists);
    XCTAssert(!app.staticTexts[@"Hint: Pay attention to new WIFI appears in WIFI list"].exists);
    XCTAssert(!app.buttons[@"Yes, Wifi conneted"].exists);
}

-(void) testWifiOpenDisplay{//test if the screen can display normally when wifi opens
    XCUIApplication *app=[[XCUIApplication alloc] init];
    [app.buttons[@"Start Connecting"] tap];
    
    XCTAssert(app.staticTexts[@"    Open WIFI"].exists);
    XCTAssert(app.staticTexts[@"    Plug in device"].exists);
    XCTAssert(app.buttons[@"Device plugged please scan now"].exists);
    XCTAssert(app.buttons[@"imagePortButton"].exists);
    XCTAssert(app.staticTexts[@"    Connect to device"].exists);
    
    XCTAssert(!app.staticTexts[@"Hint: Pay attention to new WIFI appears in WIFI list"].exists);
    XCTAssert(!app.buttons[@"Yes, Wifi conneted"].exists);

}

-(void) testClickPlugInButton{//test if screen can display normally when click plugInButton
    XCUIApplication *app=[[XCUIApplication alloc] init];
    [app.buttons[@"Start Connecting"] tap];
    [app.buttons[@"Device plugged please scan now"] tap];

    XCTAssert(app.staticTexts[@"    Open WIFI"].exists);
    XCTAssert(app.staticTexts[@"    Plug in device"].exists);
    XCTAssert(app.staticTexts[@"    Connect to device"].exists);
    XCTAssert(app.staticTexts[@"Hint: Pay attention to new WIFI appears in WIFI list"].exists);
    XCTAssert(app.buttons[@"Yes, Wifi conneted"].exists);
    
    XCTAssert(!app.buttons[@"Device plugged please scan now"].exists);
    XCTAssert(!app.buttons[@"imagePortButton"].exists);
}





//
//- (void)testWifiCloseWhenConnecting {
//    [[[XCUIApplication alloc] init].buttons[@"Start Connecting"] tap];
//
//    
//}

@end
