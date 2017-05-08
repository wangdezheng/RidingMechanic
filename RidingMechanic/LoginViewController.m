//
//  LoginViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/11/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "LoginViewController.h"
#import "RestAPI.h"
#import "SetInitialStatus.h"

@interface LoginViewController ()<RestAPIDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;

@property (strong, nonatomic) IBOutlet UILabel *loginFailedLabel;


@property (nonatomic,strong) RestAPI * restApi;

@property (strong,nonatomic) NSData *postBody;

@property (strong,nonatomic) NSMutableArray  *emailList;
@property (strong,nonatomic) NSMutableArray  *passwordList;
@property (strong,nonatomic) NSMutableArray  *IDList;

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

-(NSMutableArray *)IDList
{
    if(!_IDList)
    {
        _IDList=[[NSMutableArray alloc] init];
    }
    return _IDList;
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
    NSMutableArray *userArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    for(int i=0;i<userArray.count;i++){
        [self.emailList addObject:userArray[i][@"username"]];
        [self.passwordList addObject:userArray[i][@"cast(AES_Decrypt(password,username) AS CHAR)"]];
        [self.IDList addObject:userArray[i][@"userID"]];
    }
}


-(IBAction) login:(id)sender
{
    for(int i=0;i<self.emailList.count;i++){
        if([self.emailList[i] isEqualToString: self.emailField.text]&&[self.passwordList[i] isEqualToString:self.passwordField.text]){

            [[NSUserDefaults standardUserDefaults] setObject:self.emailField.text forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passwordField.text forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] setObject:self.IDList[i] forKey:@"userID"];
            
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ //load data from server  in background
                 SetInitialStatus *setInit=[[SetInitialStatus alloc] init];
                 [setInit setInitial:self.emailField.text];
             });

            
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
