//
//  SetInitialStatus.m
//  RidingMechanic
//
//  Created by 王德正  on 12/17/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "SetInitialStatus.h"
#import "RestAPI.h"

@interface SetInitialStatus ()<RestAPIDelegate>

@property (strong,nonatomic) RestAPI * restApi;

@property (strong,nonatomic) NSMutableDictionary *userSettings;

@property (strong,nonatomic) NSMutableDictionary *localSettings;

@property (strong,nonatomic) NSMutableDictionary *tripInfo;

@property (nonatomic, strong) dispatch_source_t timer;


@end

@implementation SetInitialStatus

-(RestAPI *) restApi
{
    if(!_restApi)
    {
        _restApi=[[RestAPI alloc] init];
    }
    return _restApi;
}

-(NSMutableDictionary *) userSettings
{
    if(!_userSettings)
    {
        _userSettings=[[NSMutableDictionary alloc] init];
    }
    return _userSettings;
}

-(NSMutableDictionary *) localSettings
{
    if(!_localSettings)
    {
        _localSettings=[[NSMutableDictionary alloc] init];
    }
    return _localSettings;
}

-(NSMutableDictionary *) tripInfo
{
    if(!_tripInfo)
    {
        _tripInfo=[[NSMutableDictionary alloc] init];
    }
    return _tripInfo;
}

-(void)setInitial:(NSString *) user
{
    
    [self httpGetRequest:user];
    
    int64_t delayInSeconds = 500; //0.5s
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self setStatus:user];
        
    });
    
    delayInSeconds = 1000;//1S
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [self updateTrip];
    });

    
    delayInSeconds = 1500;//1.5s
    popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * USEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
       
        [self httpGetTripRequest:[[NSUserDefaults standardUserDefaults] valueForKey:@"userID"]];
    });
    
}


-(void)getReceivedData:(NSMutableData *)data sender:(RestAPI *)sender
{
    NSError *error=nil;
    NSMutableArray *infoArray=[[NSMutableArray alloc] init];
    infoArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    NSLog(@"User From server:%@",infoArray);
    if(infoArray[0][@"totalAlertSwitch"]){ //infoArray is user information
        [self.userSettings setValue:infoArray[0][@"totalAlertSwitch"] forKey:@"totalAlertSwitch"];
        [self.userSettings setValue:infoArray[0][@"speedAlertSwitch"] forKey:@"speedAlertSwitch"];
        [self.userSettings setValue:infoArray[0][@"speedLimit"] forKey:@"speedLimit"];
        [self.userSettings setValue:infoArray[0][@"tiredDrivingAlertSwitch"] forKey:@"tiredDrivingAlertSwitch"];
        [self.userSettings setValue:infoArray[0][@"tiredDrivingHour"] forKey:@"tiredDrivingHour"];
        [self.userSettings setValue:infoArray[0][@"waterTemperatureAlertSwitch"] forKey:@"waterTemperatureAlertSwitch"];
        [self.userSettings setValue:infoArray[0][@"waterTemperatureLimit"] forKey:@"waterTemperatureLimit"];
        [self.userSettings setValue:infoArray[0][@"fuelPrice"] forKey:@"fuelPrice"];
        [self.userSettings setValue:infoArray[0][@"unit"] forKey:@"unit"];
        [self.userSettings setValue:infoArray[0][@"userID"] forKey:@"userID"];
    }
}

-(void)httpGetRequest:(NSString *)body
{
    NSString *str=@"http://localhost:9000/userSettings/";
    str=[str stringByAppendingString:body];
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:GET];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];

}

-(void)httpGetTripRequest:(NSString *)body
{
    NSString *str=@"http://localhost:9000/tripInfo/";
    
    str=[str stringByAppendingString:[NSString stringWithFormat:@"%@",body]];

    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:GET];

    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSMutableArray *infoArray=[[NSMutableArray alloc] init];
        infoArray=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSLog(@"From server:%@",infoArray);
        if(infoArray){ //infoArray is trip information
            NSMutableArray * startDateTimeArray=[[NSMutableArray alloc] init];
            NSMutableArray * endDateTimeArray=[[NSMutableArray alloc] init];
            NSMutableArray * drivingDistanceArray=[[NSMutableArray alloc] init];//store driving distance
            NSMutableArray * MPGArray=[[NSMutableArray alloc] init];//store average MPG
            NSMutableArray * speedArray=[[NSMutableArray alloc] init];//store average speed
            NSMutableArray * fuelCostArray=[[NSMutableArray alloc] init];//store fuel cost
            NSMutableArray * accelerationArray=[[NSMutableArray alloc] init];//storeSharp Acceleration Times
            NSMutableArray * brakingArray=[[NSMutableArray alloc] init];//store store Sharp braking Times
            for(int i=0;i<infoArray.count;i++){
                [startDateTimeArray addObject:infoArray[i][@"startDateTime"]];
                [endDateTimeArray addObject:infoArray[i][@"endDateTime"]];
                [drivingDistanceArray addObject:infoArray[i][@"drivingDistance"]];
                [MPGArray addObject:infoArray[i][@"averageMPG"]];
                [speedArray addObject:infoArray[i][@"averageSpeed"]];
                [fuelCostArray addObject:infoArray[i][@"fuelCost"]];
                [accelerationArray addObject:infoArray[i][@"sharpAccelerationTime"]];
                [brakingArray addObject:infoArray[i][@"sharpBrakingTime"]];
            }
            [self.tripInfo setObject:startDateTimeArray forKey:@"startDateTime"];
            [self.tripInfo setObject:endDateTimeArray forKey:@"endDateTime"];
            [self.tripInfo setObject:drivingDistanceArray forKey:@"drivingDistance"];
            [self.tripInfo setObject:MPGArray forKey:@"averageMPG"];
            [self.tripInfo setObject:speedArray forKey:@"averageSpeed"];
            [self.tripInfo setObject:fuelCostArray forKey:@"fuelCost"];
            [self.tripInfo setObject:accelerationArray forKey:@"sharpAccelerationTime"];
            [self.tripInfo setObject:brakingArray forKey:@"sharpBrakingTime"];
            
            //down trip information from server database and give it to sandBoxDataDic
            NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *path = [pathArray objectAtIndex:0];
            NSString *filePatch = [path stringByAppendingPathComponent:@"TripInfo.plist"];
            
            [self.tripInfo writeToFile:filePatch atomically:YES];
            NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
            NSLog(@"Trip From server: %@",sandBoxDataDic);
        }

    }];
    [task resume];
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

-(void)httpPostTripRequest:(NSData *)data
{
    NSString *str=@"http://localhost:9000/tripInfo";
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    str=[str stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURL *url=[NSURL URLWithString:str];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    [request setHTTPBody:data];
    [request setHTTPMethod:POST];
    self.restApi.delegate=self;
    [self.restApi httpRequest:request];
}


-(void) updateTrip
{
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //get file path
    NSString *filePatch = [path stringByAppendingPathComponent:@"NewTripInfo.plist"];
    NSMutableDictionary *sandBoxDataDic = [[NSMutableDictionary alloc]initWithContentsOfFile:filePatch];
    
    if([sandBoxDataDic objectForKey:@"StartDateTime"]){ //need to update
        
        NSMutableArray *indexArray=[[NSMutableArray alloc] initWithArray:sandBoxDataDic[@"StartDateTime"]];
        NSMutableDictionary *tripInfo=[[NSMutableDictionary alloc] init];
        for(int i=0;i<indexArray.count;i++){
            tripInfo[@"userID"]=sandBoxDataDic[@"UserID"];
            tripInfo[@"startDateTime"]=sandBoxDataDic[@"StartDateTime"][i];
            tripInfo[@"endDateTime"]=sandBoxDataDic[@"EndDateTime"][i];
            tripInfo[@"drivingDistance"]=sandBoxDataDic[@"DrivingDistance"][i];
            tripInfo[@"averageMPG"]=sandBoxDataDic[@"AverageMPG"][i];
            tripInfo[@"averageSpeed"]=sandBoxDataDic[@"AverageSpeed"][i];
            tripInfo[@"fuelCost"]=sandBoxDataDic[@"FuelCost"][i];
            tripInfo[@"sharpAccelerationTime"]=sandBoxDataDic[@"SharpAccelerationTimes"][i];
            tripInfo[@"sharpBrakingTime"]=sandBoxDataDic[@"SharpBrakingTimes"][i];
        }
        NSLog(@"Trip to server: %@",tripInfo);
        NSData *putBody=[[NSData alloc] init];
        if([NSJSONSerialization isValidJSONObject:tripInfo]){
            putBody=[[NSData alloc] init];
            NSError *error=nil;
            putBody=[NSJSONSerialization dataWithJSONObject:tripInfo options:NSJSONWritingPrettyPrinted error:&error];
        }else{
            NSLog(@"data can't convert to JSON type");
        }
        [self httpPostTripRequest:putBody]; //update server database
        [sandBoxDataDic removeAllObjects];
        [sandBoxDataDic writeToFile:filePatch atomically:YES];
    }
}


-(void)setStatus:(NSString *) user{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    
    [dictionary setObject:@"unconnected" forKey:@"wifiStatus"];

    if(![dictionary objectForKey:@"AlertSwitch"]){    //update local database from serverdatabase
        if([[self.userSettings valueForKey:@"totalAlertSwitch"] integerValue]==1){
            [dictionary setObject:@"On" forKey:@"AlertSwitch"];
        }else{
            [dictionary setObject:@"Off" forKey:@"AlertSwitch"];
        }
    }else{// update server database from local database
        if([[dictionary objectForKey:@"AlertSwitch"] isEqualToString:@"On"]){
            [self.localSettings setValue:@"1" forKey:@"totalAlertSwitch"];
        }else{
            [self.localSettings setValue:@"0" forKey:@"totalAlertSwitch"];
        }
    }
    
    if(![dictionary objectForKey:@"SpeedAlertSwitch"]){ //update local database from serverdatabase
        if([[self.userSettings valueForKey:@"speedAlertSwitch"] integerValue]==1){
            [dictionary setObject:@"On" forKey:@"SpeedAlertSwitch"];
        }else{
            [dictionary setObject:@"Off" forKey:@"SpeedAlertSwitch"];
        }
    }else{// update server database from local database
        if([[dictionary objectForKey:@"SpeedAlertSwitch"] isEqualToString:@"On"]){
            [self.localSettings setValue:@"1" forKey:@"speedAlertSwitch"];
        }else{
            [self.localSettings setValue:@"0" forKey:@"speedAlertSwitch"];
        }
    }
    
    if(![dictionary objectForKey:@"SpeedLimit"]){ //update local database from serverdatabase
        [dictionary setObject:[[self.userSettings valueForKey:@"speedLimit"] stringValue] forKey:@"SpeedLimit"];
    }else{// update server database from local database
        [self.localSettings setValue:[dictionary valueForKey:@"SpeedLimit"] forKey:@"speedLimit"];
    }
    
    if(![dictionary objectForKey:@"TiredDrivingSwitch"]){ //update local database from serverdatabase
        if([[self.userSettings valueForKey:@"tiredDrivingAlertSwitch"] integerValue]==1){
            [dictionary setObject:@"On" forKey:@"TiredDrivingSwitch"];
        }else{
            [dictionary setObject:@"Off" forKey:@"TiredDrivingSwitch"];
        }
    }else{// update server database from local database
        if([[dictionary objectForKey:@"TiredDrivingSwitch"] isEqualToString:@"On"]){
            [self.localSettings setValue:@"1" forKey:@"tiredDrivingAlertSwitch"];
        }else{
            [self.localSettings setValue:@"0" forKey:@"tiredDrivingAlertSwitch"];
        }
    }
    
    
    if(![dictionary objectForKey:@"TiredDrivingHour"]){ //update local database from serverdatabase
        [dictionary setObject:[[self.userSettings valueForKey:@"tiredDrivingHour"] stringValue] forKey:@"TiredDrivingHour"];
    }else{// update server database from local database
        [self.localSettings setValue:[dictionary valueForKey:@"TiredDrivingHour"] forKey:@"tiredDrivingHour"];
    }
    
    if(![dictionary objectForKey:@"WaterTemperatureSwitch"]){ //update local database from serverdatabase
        if([[self.userSettings valueForKey:@"waterTemperatureAlertSwitch"] integerValue]==1){
            [dictionary setObject:@"On" forKey:@"WaterTemperatureSwitch"];
        }else{
            [dictionary setObject:@"Off" forKey:@"WaterTemperatureSwitch"];
        }
    }else{// update server database from local database
        if([[dictionary objectForKey:@"WaterTemperatureSwitch"] isEqualToString:@"On"]){
            [self.localSettings setValue:@"1" forKey:@"waterTemperatureAlertSwitch"];
        }else{
            [self.localSettings setValue:@"0" forKey:@"waterTemperatureAlertSwitch"];
        }
    }
    
    if(![dictionary objectForKey:@"WaterTemperature"]){ //update local database from serverdatabase
        [dictionary setObject:[[self.userSettings valueForKey:@"waterTemperatureLimit"] stringValue]forKey:@"WaterTemperature"];
    }else{// update server database from local database
        [self.localSettings setValue:[dictionary valueForKey:@"WaterTemperature"] forKey:@"waterTemperatureLimit"];
    }
    

    if(![dictionary objectForKey:@"FuelPrice"]){ //update local database from serverdatabase
        [dictionary setObject:[[self.userSettings valueForKey:@"fuelPrice"] stringValue] forKey:@"FuelPrice"];
    }else{// update server database from local database
        [self.localSettings setValue:[dictionary valueForKey:@"FuelPrice"] forKey:@"fuelPrice"];
    }
    
    if(![dictionary objectForKey:@"Unit"]){ //update local database from serverdatabase
        if([[self.userSettings valueForKey:@"unit"] integerValue]==1){
            [dictionary setObject:@"1" forKey:@"Unit"];
        }else{
            [dictionary setObject:@"0" forKey:@"Unit"];
        }
    }else{// update server database from local database
        if([[dictionary objectForKey:@"Unit"] isEqualToString:@"1"]){
            [self.localSettings setValue:@"1" forKey:@"unit"];
        }else{
            [self.localSettings setValue:@"0" forKey:@"unit"];
        }
    }
    if([self.localSettings valueForKey:@"totalAlertSwitch"]){
        [self.localSettings setValue:user forKey:@"username"];
        NSLog(@"User To server:%@",self.localSettings);
        NSData *putBody=[[NSData alloc] init];
        if([NSJSONSerialization isValidJSONObject:self.localSettings]){
            putBody=[[NSData alloc] init];
            NSError *error=nil;
            putBody=[NSJSONSerialization dataWithJSONObject:self.localSettings options:NSJSONWritingPrettyPrinted error:&error];
        }else{
            NSLog(@"data can't convert to JSON type");
        }
        [self httpPutRequest:putBody];
    }
}
@end
