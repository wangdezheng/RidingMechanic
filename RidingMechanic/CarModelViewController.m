//
//  CarModelViewController.m
//  RidingMechanic
//
//  Created by Dezheng Wang  on 11/28/16.
//  Copyright © 2016 Dezheng Wang. All rights reserved.
//

#import "CarModelViewController.h"
#import "Reachability.h"
#import "SendCommand.h"


@interface CarModelViewController ()
@property (strong, nonatomic) IBOutlet UIBarButtonItem *wifiStatus;
@property (strong, nonatomic) IBOutlet UIButton *startTripButton;
@property (assign,nonatomic) NSInteger drivingTime;

@property (strong, nonatomic) IBOutlet UILabel *speedLabel;
@property (strong, nonatomic) IBOutlet UILabel *RMPLabel;
@property (strong, nonatomic) IBOutlet UILabel *voltageLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;

@property (strong,nonatomic) UIAlertController * alertController;


@end

@implementation CarModelViewController
static dispatch_source_t timerForMain;



- (void)viewDidLoad
{
   [super viewDidLoad];
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"wifiStatus"];
    self.alertController = [UIAlertController alertControllerWithTitle: @"Please connect to the scaner " message: @"Click Wi-Fi button at upper right corner" preferredStyle: UIAlertControllerStyleAlert];
    [self.alertController addAction: [UIAlertAction actionWithTitle: @"OK" style: UIAlertActionStyleDefault handler:^(UIAlertAction *action){
    }]];
    
    [self.parentViewController presentViewController:self.alertController animated:YES completion:Nil];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString * wifiStatus=[[NSUserDefaults standardUserDefaults] objectForKey:@"wifiStatus"];
    
    if([wifiStatus isEqualToString:@"YES"]){
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi Filled"];
        [self.startTripButton setHidden:NO];
        
        SendCommand * sendCommand=[SendCommand sharedSendCommand];
        if(sendCommand.timerForUpdate){
            [sendCommand resumeTimerForUpdate];
        }else{
            sendCommand.pid=@"010D";
            [sendCommand updateDataInTable];
        }
        self.drivingTime=0;
        if(timerForMain){
            [self resumeTimer];
        }else{
           [self startReadingData];
        }
        
        
    }else{
        self.wifiStatus.image=[UIImage imageNamed:@"Wi-Fi"];
        [self.startTripButton setHidden:NO];
        self.speedLabel.text=@"N/A";
        self.RMPLabel.text=@"N/A";
        self.temperatureLabel.text=@"N/A";
        self.voltageLabel.text=@"N/A";
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    SendCommand * sendCommand=[SendCommand sharedSendCommand];
    [sendCommand pauseTimerForUpdate];
    [self pauseTimer];
}

-(void)pauseTimer
{
    if(timerForMain){
        dispatch_suspend(timerForMain);
    }
}

-(void)resumeTimer
{
    if(timerForMain){
        dispatch_resume(timerForMain);
    }
}


-(void) startReadingData
{
    dispatch_queue_t mainQueue = dispatch_get_main_queue();  // main thread

    timerForMain = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, mainQueue);
    
    dispatch_source_set_timer(timerForMain, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0);
    
    // call task
    dispatch_source_set_event_handler(timerForMain, ^{
        self.drivingTime++;
        NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
        [dictionary setValue:[NSNumber numberWithInteger:self.drivingTime] forKey:@"DrivingTime"];
        NSString * speed=@"";
        if([[dictionary valueForKey:@"Unit"] isEqualToString:@"1"]){
            speed=[NSString stringWithFormat:@"%.1f",[[dictionary valueForKey:@"Speed"] floatValue]];//mile/h
            speed=[speed stringByAppendingString:@"\tmile/h"];
        }else{
            speed=[NSString stringWithFormat:@"%.1f",[[dictionary valueForKey:@"Speed"] floatValue]*1.6]; //km/h
            speed=[speed stringByAppendingString:@"\tkm/h"];
        }
        self.speedLabel.text=speed;
        
        self.RMPLabel.text=[dictionary valueForKey:@"RPM"];
        
        NSString * voltage=@"";
        voltage=[dictionary valueForKey:@"RPM"];
        voltage=[voltage stringByAppendingString:@"\t V"];
        self.voltageLabel.text=voltage;
        
        NSString *tem=@"";
        if([[dictionary valueForKey:@"Unit"] isEqualToString:@"1"]){
            int value=[[dictionary valueForKey:@"EngineCoolantTemperature"] floatValue];
            value=(value*1.8)+32;
            tem=[NSString stringWithFormat:@"%d",value];
            tem=[tem stringByAppendingString:@"\t°F"];
        }else{
            tem=[dictionary valueForKey:@"EngineCoolantTemperature"]; //C
            tem=[tem stringByAppendingString:@"\t°C"];
        }
        self.temperatureLabel.text=tem;
        [self.view setNeedsDisplay];
        
        
    });
    
    // start timer
    dispatch_resume(timerForMain);
}


-(IBAction)startTrip:(id)sender
{
    [self performSegueWithIdentifier:@"showMenu" sender:sender];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
