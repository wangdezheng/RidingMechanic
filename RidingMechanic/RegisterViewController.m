//
//  RegisterViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/11/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "RegisterViewController.h"
#import "RestAPI.h"

@interface RegisterViewController ()<RestAPIDelegate>
@property (strong, nonatomic) IBOutlet UITextField *emailField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) IBOutlet UITextField *confirPasswordField;

@property (strong, nonatomic) IBOutlet UILabel *emailWarnLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailPassLabel;

@property (strong, nonatomic) IBOutlet UILabel *passwordWarnLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordPassLabel;


@property (strong, nonatomic) IBOutlet UILabel *confirWarnLabel;
@property (strong, nonatomic) IBOutlet UILabel *confirmPassLabel;

@property (strong, nonatomic) IBOutlet UILabel *emailErrorLabel;
@property (strong, nonatomic) IBOutlet UILabel *passwordErrorLabel;
@property (strong, nonatomic) IBOutlet UILabel *confirErrorLabel;

@property (strong,nonatomic) UIAlertController * alertController;

@property (nonatomic,strong) RestAPI * restApi;

@property (strong,nonatomic) NSData *postBody;

@property (strong,nonatomic) NSMutableArray  *emailList;

@end

@implementation RegisterViewController

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

-(void)httpPostRequest
{
    NSString *str=@"http://localhost:9000/userInfo";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:self.postBody];
    [request setHTTPMethod:POST];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];
}

-(void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    NSError *error=nil;
    NSMutableArray *emailArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    for(int i=0;i<emailArray.count;i++){
        [self.emailList addObject:emailArray[i][@"email"]];
//        NSLog(@"%@",emailArray[i][@"email"]);
    }
}

-(IBAction)emailFieldEditingChange:(id)sender
{
    if(![_emailField.text containsString:@"@"]){
        [self.emailPassLabel setHidden:YES];
        [self.emailWarnLabel setHidden:NO];
        [self.emailErrorLabel setText:@"Email must be of the format:your@example.org"];
        [self.emailErrorLabel setHidden:NO];
    }else{
        [self.emailErrorLabel setHidden:YES];
        [self.emailWarnLabel setHidden:YES];
        [self.emailPassLabel setHidden:NO];
        if([self.emailList containsObject:self.emailField.text]){
            [self.emailPassLabel setHidden:YES];
            [self.emailWarnLabel setHidden:NO];
            [self.emailErrorLabel setText:@"Sorry, this email had been used!"];
            [self.emailErrorLabel setHidden:NO];
        }
    }
}

-(IBAction)passwordEditingChange:(id)sender
{
    if([self.passwordField.text isEqualToString:@""]){
        [self.passwordPassLabel setHidden:YES];
        [self.passwordWarnLabel setHidden:NO];
        [self.passwordErrorLabel setText:@"Password muts not be empty"];
        [self.passwordErrorLabel setHidden:NO];
    }else{
        [self.passwordPassLabel setHidden:NO];
        [self.passwordWarnLabel setHidden:YES];
        [self.passwordErrorLabel setHidden:YES];
    }
}


-(IBAction) confirPasswordFieldEditingChange:(id)sender
{
    if(![self.confirPasswordField.text isEqualToString:self.passwordField.text]){
        [self.confirWarnLabel setHidden:NO];
        [self.confirmPassLabel setHidden:YES];
        [self.confirErrorLabel setText:@"Passwords must match"];
        [self.confirErrorLabel setHidden:NO];
    }else{
        [self.confirWarnLabel setHidden:YES];
        [self.confirmPassLabel setHidden:NO];
        [self.confirErrorLabel setHidden:YES];
    }
}


-(IBAction)submit:(id)sender
{
    if([self.emailPassLabel isHidden]||[self.passwordPassLabel isHidden]||[self.confirmPassLabel isHidden]){
        [self presentViewController: self.alertController animated: YES completion: nil];
        return;
        
    }else{
        NSMutableDictionary *data=[[NSMutableDictionary alloc] init];
        
        [data setObject:self.emailField.text forKey:@"email"];
        [data setObject:self.passwordField.text forKey:@"password"];
        
        if([NSJSONSerialization isValidJSONObject:data]){
            self.postBody=nil;
            NSError *error=nil;
            self.postBody=[NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
        }else{
            NSLog(@"data can't convert to JSON type");
        }
        
        [self httpPostRequest];
        [self performSegueWithIdentifier:@"registerSuccessfully" sender:sender];
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO];
    [self httpGetRequest];
    self.alertController = [UIAlertController alertControllerWithTitle: @"Error!" message: nil preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"Please check your input" style: UIAlertActionStyleCancel handler:nil]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
