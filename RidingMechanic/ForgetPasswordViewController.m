//
//  ForgetPasswordViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang on 4/28/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "ForgetPasswordViewController.h"
#import "RestAPI.h"
#import <SKPSMTPMessage.h>


@interface ForgetPasswordViewController ()<RestAPIDelegate>

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (nonatomic,strong) RestAPI * restApi;
@property (strong,nonatomic) NSMutableArray  *emailList;

@property (strong,nonatomic) UIAlertController * alertController;

@end

@implementation ForgetPasswordViewController


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

-(void)httpPutRequest:(NSData *)data
{
    NSString *str=@"http://localhost:9000/userInfo";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:data];
    [request setHTTPMethod:PUT];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];
}

-(void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    NSError *error=nil;
    NSMutableArray *emailArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    for(int i=0;i<emailArray.count;i++){
        [self.emailList addObject:emailArray[i][@"username"]];
    }
}

- (IBAction)resetPassword:(id)sender {
    Boolean find=NO;
    for(int i=0;i<self.emailList.count;i++){
        if([self.emailList[i] isEqualToString:self.emailTextField.text]){
            find=YES;
            break;
        }
    }
    
    if(find){ // email exists and change password
        NSMutableDictionary *info=[[NSMutableDictionary alloc] init];
        NSInteger number = arc4random_uniform(900000) + 100000;
        info[@"username"]=self.emailTextField.text;
        info[@"password"]=[[NSNumber numberWithInteger:number] stringValue];
        
        [self sendEmailToUser:info]; //send new password to users
        
        NSData *putBody=[[NSData alloc] init];
        if([NSJSONSerialization isValidJSONObject:info]){
            NSError *error=nil;
            putBody=[NSJSONSerialization dataWithJSONObject:info options:NSJSONWritingPrettyPrinted error:&error];
        }else{
            NSLog(@"data can't convert to JSON type");
        }
        [self httpPutRequest:putBody];
        [self.navigationController popViewControllerAnimated:YES]; //reset successfully and go back
    }else{
        [self presentViewController: self.alertController animated: YES completion: nil];
    }
}

-(void)sendEmailToUser:(NSMutableDictionary *)user
{
    SKPSMTPMessage *mail = [[SKPSMTPMessage alloc] init];
    [mail setSubject:@"Riding Mechanic Retrieve Password"];
    [mail setToEmail:[user valueForKey:@"username"]];
    [mail setFromEmail:@"w793013053@gmail.com"];
    [mail setRelayHost:@"smtp.gmail.com"];
    [mail setRequiresAuth:YES];
    [mail setLogin:@"w793013053@gmail.com"];
    [mail setPass:@"Wdz19940712"];
    [mail setWantsSecure:YES];

    NSString *message=[NSString stringWithFormat:@"Dear User:\n\t Your password has been initialized as:%@, please change password after login.\n\t Ignore this message if you didn't ask for a new password.\n\nHave a good day!\nRiding Mechanic",user[@"password"]];
    
    NSDictionary *plainPart = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain",kSKPSMTPPartContentTypeKey,message,kSKPSMTPPartMessageKey,@"8bit",kSKPSMTPPartContentTransferEncodingKey,nil];
    mail.parts=[NSArray arrayWithObject:plainPart];
    
    [mail send];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [self httpGetRequest];
    [self.navigationController setNavigationBarHidden:NO];
    self.alertController = [UIAlertController alertControllerWithTitle: @"Error!" message: @"Eamil doesn't exist, please retry" preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleCancel handler:^(UIAlertAction *action){
    }]];
}

@end
