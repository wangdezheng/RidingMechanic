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

-(void) testLoginFunction{//test if login funtion works correctly
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123456"];
    XCUIElement *loginButton = app.buttons[@"Login"];
    [loginButton tap];
    XCTAssert(app.staticTexts[@"Incorrect username or password"].exists);
    
    [emailAddressTextField tap];
    [app.buttons[@"Clear text"] tap];
    [passwordSecureTextField tap];
    [app.buttons[@"Clear text"] tap];
    [loginButton tap];
    XCTAssert(app.staticTexts[@"Incorrect username or password"].exists);
    
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [loginButton tap];
    
    
    XCTAssert(!emailAddressTextField.exists);
    XCTAssert(!passwordSecureTextField.exists);
    XCTAssert(!loginButton.exists);
    XCTAssert(!app.buttons[@"Register"].exists);
    XCTAssert(!app.staticTexts[@"Incorrect username or password"].exists);
}

-(void)testRegisterFunction{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Register"] tap];
    
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    XCTAssert(app.staticTexts[@"!"].exists);
    XCTAssert(app.staticTexts[@"Sorry, this email had been used!"].exists);
    
    [emailAddressTextField typeText:@"793013053@qq.com"];
    XCTAssert(!app.staticTexts[@"!"].exists);
    XCTAssert(!app.staticTexts[@"Sorry, this email had been used!"].exists);

    XCUIElement *submitButton = app.buttons[@"Submit"];
    [submitButton tap];
    
    XCUIElement *errorAlert = app.alerts[@"Error!"];
    XCTAssert(errorAlert.exists);
    XCUIElement *pleaseCheckYourInputButton = errorAlert.buttons[@"Please check your input"];
    XCTAssert(pleaseCheckYourInputButton.exists);
    [pleaseCheckYourInputButton tap];
    
    XCUIElement *passwordSecureTextField = app.textFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    
    XCUIElement *confirmPasswordSecureTextField = app.textFields[@"Confirm password"];
    [confirmPasswordSecureTextField tap];
    [confirmPasswordSecureTextField typeText:@"123456"];
    
    XCTAssert(app.staticTexts[@"!"].exists);
    XCTAssert(app.staticTexts[@"Passwords must match"].exists);
    
    [submitButton tap];
    XCTAssert(errorAlert.exists);
    XCTAssert(pleaseCheckYourInputButton.exists);
    [pleaseCheckYourInputButton tap];
    
    
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [confirmPasswordSecureTextField tap];
    [confirmPasswordSecureTextField typeText:@"123"];
    [app.buttons[@"Submit"] tap];
    
    XCTAssert(app.buttons[@"Login"].exists);
}




@end
