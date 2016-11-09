//
//  RequsetAPI.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/8/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "RestAPI.h"

@interface RestAPI() <NSURLSessionDataDelegate>

@property (nonatomic,strong) NSMutableData * receivedData;
@property (nonatomic,strong) NSURLSession *requestSession;
@property (nonatomic,strong) NSURLSessionConfiguration * config;

@end

@implementation RestAPI

-(NSMutableData *) receivedData 
{
    if(!_receivedData){
        _receivedData=[[NSMutableData alloc] init];
    }
    
    return _receivedData;
}

-(NSURLSession *) requestSession
{
    if(_requestSession){
        _requestSession=[[NSURLSession alloc] init];
    }
    
    return _requestSession;
}

-(void)httpRequest:(NSMutableURLRequest *)request
{
    self.config=[NSURLSessionConfiguration defaultSessionConfiguration];
    self.requestSession=[NSURLSession sessionWithConfiguration:self.config delegate:self delegateQueue:nil];
    
    NSURLSessionDataTask *task = [self.requestSession dataTaskWithRequest:request];
    
    [task resume];
    
}

-(void) URLSession:(NSURLSession *)session dataTask:(nonnull NSURLSessionDataTask *)dataTask didReceiveResponse:(nonnull NSURLResponse *)response completionHandler:(nonnull void (^)(NSURLSessionResponseDisposition))completionHandler{
    
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    [self.receivedData appendData:data];
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if(error){
    NSLog(@"%@",error.description);
    }
    
    [self.delegate getReceivedData:self.receivedData sender:self];
    self.delegate=nil;
    self.requestSession=nil;
    self.receivedData=nil;
}

@end
