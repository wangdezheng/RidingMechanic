//
//  ResetPasswordViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 12/7/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "RestAPI.h"
#import "LoginViewController.h"

@interface ResetPasswordViewController ()<RestAPIDelegate>
@property (strong, nonatomic) IBOutlet UITextField *currentPwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *pwdTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPwdTextField;

@property (nonatomic,strong) RestAPI * restApi;
@property (strong,nonatomic) NSData *putBody;

@property (strong,nonatomic) UIAlertController * alertController;

@end

@implementation ResetPasswordViewController

-(RestAPI *) restApi
{
    if(!_restApi)
    {
        _restApi=[[RestAPI alloc] init];
    }
    return _restApi;
}

-(void)httpPutRequest
{
    NSString *str=@"http://localhost:9000/userInfo";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:self.putBody];
    [request setHTTPMethod:PUT];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];
}

-(void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    //noting to receive
}

- (void)viewDidLoad {
    [super viewDidLoad];
     self.alertController = [UIAlertController alertControllerWithTitle: @"Error!" message: @"" preferredStyle: UIAlertControllerStyleAlert];
     [self.alertController addAction: [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
         if([self.alertController.message isEqualToString:@""]){
            [self.navigationController popViewControllerAnimated:YES];
         }
     }]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)submit:(id)sender
{
    NSMutableArray *userInfoArray=[[NSMutableArray alloc] initWithCapacity:2];
    userInfoArray=[[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    NSLog(@"%@",userInfoArray[0]);
    NSLog(@"%@",userInfoArray[1]);
    if(![_currentPwdTextField.text isEqualToString:userInfoArray[1]]){
        self.alertController.message=@"Current password is incorrect";
        [self presentViewController:self.alertController animated:YES completion:nil];
        return;
    }
    if([_pwdTextField.text isEqualToString:@""]||[_confirmPwdTextField.text isEqualToString:@""]){
        self.alertController.message=@"New password should not be empty";
        [self presentViewController:self.alertController animated:YES completion:nil];
        return;
    }
    if([_currentPwdTextField.text isEqualToString:_pwdTextField.text]){
        self.alertController.message=@"New password and current password should be different";
        [self presentViewController:self.alertController animated:YES completion:nil];
        return;
    }
    if(![_pwdTextField.text isEqualToString:_confirmPwdTextField.text]){
        self.alertController.message=@"The New Password and Confirm New Password fields did not match";
        [self presentViewController:self.alertController animated:YES completion:nil];
        return;
    }
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc] init];
    [data setObject:userInfoArray[0] forKey:@"email"];
    [data setObject:self.pwdTextField.text forKey:@"password"];
    
    if([NSJSONSerialization isValidJSONObject:data]){
        self.putBody=[[NSData alloc] init];
        NSError *error=nil;
        self.putBody=[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    }else{
        NSLog(@"data can't convert to JSON type");
    }
    
    [self httpPutRequest];

    
    NSMutableArray *userInfo=[[NSMutableArray alloc] initWithCapacity:2];
    userInfo[0]=userInfoArray[0];
    userInfo[1]=self.pwdTextField.text;
    [[NSUserDefaults standardUserDefaults] setObject:userInfo forKey:@"userInfo"];//update userInfo

    self.alertController.title=@"Password change succeed";
    self.alertController.message=@"";
    [self presentViewController:self.alertController animated:YES completion:nil];
}

@end
