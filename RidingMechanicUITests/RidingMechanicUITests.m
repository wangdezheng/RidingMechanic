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
    [emailAddressTextField typeText:@"w79301305333@gmail.com"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [loginButton tap];
    XCTAssert(app.staticTexts[@"Incorrect username or password"].exists);
    
    [emailAddressTextField tap];
    [app.buttons[@"Clear text"] tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    [passwordSecureTextField tap];
    [app.buttons[@"Clear text"] tap];
    [passwordSecureTextField typeText:@"123"];
    [loginButton tap];
    
    XCTAssert(!emailAddressTextField.exists);
    XCTAssert(!passwordSecureTextField.exists);
    XCTAssert(!loginButton.exists);
    XCTAssert(!app.buttons[@"Register"].exists);
    XCTAssert(!app.staticTexts[@"Incorrect username or password"].exists);
}

-(void)testForgetPasswordFunction{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Help"] tap];
    
    XCUIElement *emailTextField = app.textFields[@"Email address"];
    XCTAssert(emailTextField.exists);
    [emailTextField tap];
    [emailTextField typeText:@"w7930130533@gmail.com"];
    
    XCUIElement *resetButton = app.buttons[@"Reset"];
    [resetButton tap];
    
    XCTAssert(app.alerts[@"Error!"].exists);
    XCUIElement *okButton = app.alerts[@"Error!"].buttons[@"OK"];
    [okButton tap];
    
    XCUIElement *clearTextButton = app.buttons[@"Clear text"];
    [clearTextButton tap];
    
    [resetButton tap];
    XCTAssert(app.alerts[@"Error!"].exists);
    [okButton tap];
    
    [emailTextField typeText:@"793013053@qq.com"];
    [resetButton tap];
    XCTAssert(!resetButton.exists);
    
}

-(void)testRegisterFunction{
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.buttons[@"Register"] tap];
    
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"793013053@qq.com"];
    XCTAssert(app.staticTexts[@"Sorry, this email had been used!"].exists);
    
    [app.buttons[@"Clear text"] tap];
    [emailAddressTextField typeText:@"351943031@qq.com.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    
    XCUIElement *confirmPasswordSecureTextField = app.secureTextFields[@"Confirm password"];
    [confirmPasswordSecureTextField tap];
    [confirmPasswordSecureTextField typeText:@"12"];
    
    XCUIElement *submitButton = app.buttons[@"Submit"];
    [submitButton tap];
    XCTAssert(app.alerts[@"Error!"].exists);
    [app.alerts[@"Error!"].buttons[@"OK"] tap];
    
    [confirmPasswordSecureTextField tap];
    [confirmPasswordSecureTextField typeText:@"123"];
    [submitButton tap];
    XCTAssert(app.alerts[@"Register Succeed"].exists);
    [app.alerts[@"Register Succeed"].buttons[@"OK"] tap];
    
}


-(void)testConnectionFunction{

    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [app.buttons[@"Login"] tap];
    [app.navigationBars[@"Riding Mechanic"].buttons[@"Wi Fi"] tap];
    [app.buttons[@"Device plugged please scan now"] tap];
    [app.buttons[@"Yes, Wifi conneted"] tap];
    
    XCTAssert(app.buttons[@"Start Trip"].exists);
}

-(void)testMoreModule{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [app.buttons[@"Login"] tap];
    [app.tabBars.buttons[@"More"] tap];
    
    XCUIElementQuery *tablesQuery2 = app.tables;
    XCUIElementQuery *tablesQuery = tablesQuery2;
    [tablesQuery.staticTexts[@"Alert"] tap];
    [tablesQuery.switches[@"Alert"] tap];
    [tablesQuery.switches[@"Alert"] tap];
    [tablesQuery.staticTexts[@"Speed Alert"] tap];
    [tablesQuery.switches[@"Speed Alert"] tap];
    [tablesQuery.switches[@"Speed Alert"] tap];
    
    XCUIElement *textField = [[tablesQuery2.cells containingType:XCUIElementTypeStaticText identifier:@"Speed Limit"] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField tap];
    [textField typeText:@"80"];
    [app.navigationBars[@"Speed Alert"].buttons[@"Alert"] tap];
    
    XCUIElement *tiredDrivingAlertStaticText = tablesQuery.staticTexts[@"Tired Driving Alert"];
    [tiredDrivingAlertStaticText tap];
    [tablesQuery.switches[@"Tired Driving Alert"] tap];
    [tablesQuery.switches[@"Tired Driving Alert"] tap];
    
    XCUIElement *textField2 = [[tablesQuery2.cells containingType:XCUIElementTypeStaticText identifier:@"Tired Driving Hour Limit"] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField2 tap];
    [textField2 typeText:@"4"];
    
    XCUIElement *alertButton = app.navigationBars[@"Tired Driving Alert"].buttons[@"Alert"];
    [alertButton tap];
    [tiredDrivingAlertStaticText tap];
    [alertButton tap];
    [tablesQuery.staticTexts[@"Water Temperature Alert"] tap];
    [tablesQuery.switches[@"Water Temperature Alert"] tap];
    [tablesQuery.switches[@"Water Temperature Alert"] tap];
    
    XCUIElement *textField3 = [[tablesQuery2.cells containingType:XCUIElementTypeStaticText identifier:@"Water Temperature Limit"] childrenMatchingType:XCUIElementTypeTextField].element;
    [textField3 tap];
    [textField3 typeText:@"220"];
    [app.navigationBars[@"Water Temperature Alert"].buttons[@"Alert"] tap];
    [app.navigationBars[@"Alert"].buttons[@"More"] tap];
    
    XCUIElement *vehicleStaticText = tablesQuery.staticTexts[@"Vehicle"];
    [vehicleStaticText tap];
    
    XCUIElement *textField4 = [tablesQuery2.cells childrenMatchingType:XCUIElementTypeTextField].element;
    [textField4 tap];
    [textField4 typeText:@"2.35"];
    
    XCUIElement *moreButton = app.navigationBars[@"Vehicle"].buttons[@"More"];
    [moreButton tap];
    [vehicleStaticText tap];
    [moreButton tap];
    [tablesQuery.staticTexts[@"Adapter"] tap];
    [app.navigationBars[@"Connectivity"].buttons[@"More"] tap];
    [tablesQuery.staticTexts[@"Unit"] tap];
    [app.navigationBars[@"Unit"].buttons[@"More"] tap];
    [tablesQuery.staticTexts[@"About"] tap];
    [app.navigationBars[@"About"].buttons[@"More"] tap];
    [tablesQuery.staticTexts[@"Account"] tap];
    [tablesQuery.staticTexts[@"Reset Password"] tap];
    
    XCUIElement *currentPasswordSecureTextField = app.secureTextFields[@"Current password"];
    [currentPasswordSecureTextField tap];
    [currentPasswordSecureTextField typeText:@"123"];
    
    XCUIElement *newPasswordSecureTextField = app.secureTextFields[@"New password"];
    [newPasswordSecureTextField tap];
    [newPasswordSecureTextField tap];
    [newPasswordSecureTextField typeText:@"111"];
    
    XCUIElement *confirmNewPasswordSecureTextField = app.secureTextFields[@"Confirm new password"];
    [confirmNewPasswordSecureTextField tap];
    [confirmNewPasswordSecureTextField tap];
    [confirmNewPasswordSecureTextField typeText:@"111"];
    [app.buttons[@"Submit"] tap];
    [app.alerts[@"Password change succeed"].buttons[@"OK"] tap];
    [tablesQuery.buttons[@"Log Out"] tap];
    [app.alerts[@"Log Out Succeed!"].buttons[@"Ok"] tap];
    
}

-(void)testHealthScanFunction{
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [app.buttons[@"Login"] tap];
    [app.tabBars.buttons[@"scan"] tap];
    [app.buttons[@"Rediagnosis"] tap];
}

-(void)testTripAnalysisFunction{
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [app.buttons[@"Login"] tap];
    
    XCUIElementQuery *tabBarsQuery = app.tabBars;
    [tabBarsQuery.buttons[@"analysis"] tap];
    
    XCUIApplication *app2 = app;
    [app2.buttons[@"8"] tap];
    [app2.buttons[@"10"] swipeRight];
    [app2.buttons[@"7"] tap];
    [app2.buttons[@"6"] tap];
    [app2.buttons[@"5"] tap];
    [app2.buttons[@"4"] tap];
    [app2.buttons[@"3"] tap];
    [app2.buttons[@"2"] tap];
    [app2.buttons[@"1"] tap];
    [tabBarsQuery.buttons[@"More"] tap];
    [app2.tables.staticTexts[@"Account"] tap];
    [app.tables.buttons[@"Log Out"] tap];
    [app.alerts[@"Log Out Succeed!"].buttons[@"Ok"] tap];

}

-(void)testStartTripFunction{
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    XCUIElement *emailAddressTextField = app.textFields[@"Email address"];
    [emailAddressTextField tap];
    [emailAddressTextField typeText:@"w793013053@gmail.com"];
    
    XCUIElement *passwordSecureTextField = app.secureTextFields[@"Password"];
    [passwordSecureTextField tap];
    [passwordSecureTextField typeText:@"123"];
    [app.buttons[@"Login"] tap];
    [app.navigationBars[@"Riding Mechanic"].buttons[@"Wi Fi"] tap];
    [app.buttons[@"Device plugged please scan now"] tap];
    [app.buttons[@"Yes, Wifi conneted"] tap];
    [app.buttons[@"Start Trip"] tap];
    
    XCUIElementQuery *tablesQuery = app.tables;
    [tablesQuery.staticTexts[@"Driving Distance"] tap];
    [tablesQuery.staticTexts[@"Realtime MPG"] tap];
    [tablesQuery.staticTexts[@"Total Fuel Consumption"] tap];
    [tablesQuery.staticTexts[@"Fuel Cost"] tap];
    [tablesQuery.staticTexts[@"Sharp Braking"] tap];
    [app.navigationBars[@"Trip Information"].buttons[@"Stop"] tap];
    [app.alerts[@"Do you want to store trip information?"].buttons[@"YES"] tap];
    
}











@end
