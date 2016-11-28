//
//  LoginViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/11/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "LoginViewController.h"
#import "RestAPI.h"

@interface LoginViewController ()<RestAPIDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UILabel *loginFailedLabel;


@property (nonatomic,strong) RestAPI * restApi;

@property (strong,nonatomic) NSData *postBody;

@property (strong,nonatomic) NSMutableArray  *emailList;
@property (strong,nonatomic) NSMutableArray  *passwordList;

@end

@implementation LoginViewController

-(RestAPI *) restApi
{
    if(!_restApi)
    {
        _restApi=[[RestAPI alloc] init];
    }
    return _restApi;
}

-(NSMutableArray *)emailList
{
    if(!_emailList)
    {
        _emailList=[[NSMutableArray alloc] init];
    }
    return _emailList;
}

-(NSMutableArray *)passwordList
{
    if(!_passwordList)
    {
        _passwordList=[[NSMutableArray alloc] init];
    }
    return _passwordList;
}

-(void)httpGetRequest
{
    NSString *str=@"http://localhost:9000/userInfo";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:GET];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];
}

-(void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    NSError *error=nil;
    NSMutableArray *emailArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    for(int i=0;i<emailArray.count;i++){
        [self.emailList addObject:emailArray[i][@"email"]];
        [self.passwordList addObject:emailArray[i][@"password"]];
//        NSLog(@"%@,%@",emailArray[i][@"email"],emailArray[i][@"password"]);
    }
}

-(IBAction) login:(id)sender
{
    for(int i=0;i<self.emailList.count;i++){
        if([self.emailList[i] isEqualToString: self.emailField.text]&&[self.passwordList[i] isEqualToString:self.passwordField.text]){
            [self performSegueWithIdentifier:@"loginSuccessfully" sender:sender];
            break;
        }
        if(i==self.emailList.count-1){
            [self.loginFailedLabel setText:@"Incorrect username or password"];
            [self.loginFailedLabel setHidden:NO];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES];
    [self httpGetRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
