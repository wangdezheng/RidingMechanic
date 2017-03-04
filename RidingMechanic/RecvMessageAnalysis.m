//
//  RecvMessageAnalysis.m
//  IM
//
//  Created by Dezheng Wang  on 2/6/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "RecvMessageAnalysis.h"
@interface RecvMessageAnalysis(){
    NSString *substring;
    NSString *result;
    NSMutableArray *indexArray;
    NSMutableArray *supportedPidIndexArray;
    NSMutableArray *pidArray;
}

@end

@implementation RecvMessageAnalysis
-(void)updateSupportedPIDs: (NSString * )pid recvCode:(NSString *) code
{
    if(code.length==8){
    }else{
        NSLog(@"Receive code's length is not correct!");
        return;
    }
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];// store support PIDs
    if([pid isEqualToString:@"0100"]){
        supportedPidIndexArray=[[NSMutableArray alloc] initWithCapacity:32];
        supportedPidIndexArray=[self analyzeSupportedPIDS:code];
        pidArray=[[NSMutableArray alloc] initWithObjects:@"0101",@"0102",@"0103",@"0104",@"0105",@"0106",@"0107",@"0108",@"0109",@"010A",@"010B",@"010C",@"010D",@"010E",@"010F",@"0110",@"0111",@"0112",@"0113",@"0114",@"0115",@"0116",@"0117",@"0118",@"0119",@"011A",@"011B",@"011C",@"011D",@"011E",@"011F",@"0120", nil];
        [dictionary setValue:supportedPidIndexArray[4] forKey:pidArray[4]];//0105
        [dictionary setValue:supportedPidIndexArray[11] forKey:pidArray[11]];//010C
        [dictionary setValue:supportedPidIndexArray[12] forKey:pidArray[12]];//010D
        [dictionary setValue:supportedPidIndexArray[15] forKey:pidArray[15]];//0110
        [dictionary setValue:supportedPidIndexArray[30] forKey:pidArray[30]];//011F
        [dictionary setValue:supportedPidIndexArray[31] forKey:pidArray[31]];//0120
//        for(int i=0;i<pidArray.count;i++){
//            [dictionary setValue:supportedPidIndexArray[i] forKey:pidArray[i]];
//            NSLog(@"%@ %@",supportedPidIndexArray[i],pidArray[i]);
//        }
    }else if([pid isEqualToString:@"0120"]){
        if([[dictionary valueForKey:@"0120"] isEqualToString:@"1"]){
            supportedPidIndexArray=[[NSMutableArray alloc] initWithCapacity:32];
            supportedPidIndexArray=[self analyzeSupportedPIDS:code];
            pidArray=[[NSMutableArray alloc] initWithObjects:@"0121",@"0122",@"0123",@"0124",@"0125",@"0126",@"0127",@"0128",@"0129",@"012A",@"012B",@"012C",@"012D",@"012E",@"012F",@"0130",@"0131",@"0132",@"0133",@"0134",@"0135",@"0136",@"0137",@"0138",@"0139",@"013A",@"013B",@"013C",@"013D",@"013E",@"013F",@"0140", nil];
            [dictionary setValue:supportedPidIndexArray[31] forKey:pidArray[31]];//0140
//            for(int i=0;i<pidArray.count;i++){
//                [dictionary setValue:supportedPidIndexArray[i] forKey:pidArray[i]];
//                NSLog(@"%@ %@",supportedPidIndexArray[i],pidArray[i]);
//            }
        }else{//doesn't support PID '0120'
            NSLog(@"Pid '0120' is not supported");
            return;
        }
    }else if([pid isEqualToString:@"0140"]){
        if([[dictionary valueForKey:@"0140"] isEqualToString:@"1"]){
            supportedPidIndexArray=[[NSMutableArray alloc] initWithCapacity:32];
            supportedPidIndexArray=[self analyzeSupportedPIDS:code];
            pidArray=[[NSMutableArray alloc] initWithObjects:@"0141",@"0142",@"0143",@"0144",@"0145",@"0146",@"0147",@"0148",@"0149",@"014A",@"014B",@"014C",@"014D",@"014E",@"014F",@"0150",@"0151",@"0152",@"0153",@"0154",@"0155",@"0156",@"0157",@"0158",@"0159",@"015A",@"015B",@"015C",@"015D",@"015E",@"015F",@"0160", nil];
            [dictionary setValue:supportedPidIndexArray[1] forKey:pidArray[1]];//0142
//            for(int i=0;i<pidArray.count;i++){
//                [dictionary setValue:supportedPidIndexArray[i] forKey:pidArray[i]];
//                NSLog(@"%@ %@",supportedPidIndexArray[i],pidArray[i]);
//            }
        }else{//doesn't support PID '0140'
            NSLog(@"PID '0140' is not supported");
            return;
        }
    }
//    else if([pid isEqualToString:@"0160"]){
//        if([[dictionary valueForKey:@"0160"] isEqualToString:@"1"]){
//            supportedPidIndexArray=[[NSMutableArray alloc] initWithCapacity:32];
//            supportedPidIndexArray=[self analyzeSupportedPIDS:code];
//            pidArray=[[NSMutableArray alloc] initWithObjects:@"0161",@"0162",@"0163",@"0164",@"0165",@"0166",@"0167",@"0168",@"0169",@"016A",@"016B",@"016C",@"016D",@"016E",@"016F",@"0170",@"0171",@"0172",@"0173",@"0174",@"0175",@"0176",@"0177",@"0178",@"0179",@"017A",@"017B",@"017C",@"017D",@"017E",@"017F",@"0180", nil];
//            for(int i=0;i<pidArray.count;i++){
//                [dictionary setValue:supportedPidIndexArray[i] forKey:pidArray[i]];
//                NSLog(@"%@ %@",supportedPidIndexArray[i],pidArray[i]);
//            }
//        }else{//doesn't support PID '0160'
//            NSLog(@"Your pid is not supported");
//            return;
//        }
//    }else if([pid isEqualToString:@"0180"]){
//        
//    }
    
}

-(NSMutableArray *) analyzeSupportedPIDS:(NSString *) code {
    indexArray=[[NSMutableArray alloc] initWithCapacity:32];
    for(int i=0;i<=7;i++){
        substring=[code substringWithRange:NSMakeRange(i, 1)];
        NSLog(@"%@",substring);
        if([substring isEqualToString:@"0"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"1"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"2"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"3"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"4"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"5"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"6"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"7"]){
            indexArray[i*4]=@"0";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"8"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"9"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"A"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"B"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"0";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"C"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"D"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"0";
            indexArray[i*4+3]=@"1";
        }else if([substring isEqualToString:@"E"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"0";
        }else if([substring isEqualToString:@"F"]){
            indexArray[i*4]=@"1";
            indexArray[i*4+1]=@"1";
            indexArray[i*4+2]=@"1";
            indexArray[i*4+3]=@"1";
        }else{//exception
            NSLog(@"Exception!");
            return nil;;
        }
    }
    return indexArray;
}

-(NSString *)analysizeRcvcode:(NSString *)code baseOnPID:(NSString *)pid
{
    NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
    if([[dictionary valueForKey:pid] isEqualToString:@"1"]){
        if([pid isEqualToString:@"010C"]){//get Engine RPM (rmp)
            if(code.length==4){
                NSInteger a=[[code substringWithRange:NSMakeRange(0, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(1, 1)] floatValue];
                NSInteger b=[[code substringWithRange:NSMakeRange(2, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(3, 1)] floatValue];
                float sum=(256*a+b)/4;
                if(sum>16383.75||sum<0){
                    NSLog(@"RPM out of bounds");
                    return nil;
                }else{
                    result=[NSString stringWithFormat:@"%.3f",sum];//get Engine RPM (rmp)
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
                return nil;
            }
        }else if([pid isEqualToString:@"010D"]){//get Vehicle speed(km/h)
            if(code.length==2){
                NSInteger a=[[code substringWithRange:NSMakeRange(0, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(1, 1)] floatValue];
                a=a*1.6;
                if(a<0||a>255){
                    NSLog(@"Speed out of bounds");
                    return nil;
                }else{
                    result=[NSString stringWithFormat:@"%ld",(long)a];//get Vehicle speed (m/h)
                    
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
                return nil;
            }
        }else if([pid isEqualToString:@"011F"]){//get Run time since engine start (seconds)
            if(code.length==4){
                NSInteger a=[[code substringWithRange:NSMakeRange(0, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(1, 1)] floatValue];
                NSInteger b=[[code substringWithRange:NSMakeRange(2, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(3, 1)] floatValue];
                NSInteger sum=a*256+b;
                if(sum<0||sum>65535){
                    NSLog(@"Run time since engine start out of bounds");
                    return nil;
                }else{
                    result=[NSString stringWithFormat:@"%ld",(long)sum];//get Run time since engine start(seconds)
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
                return nil;
            }
        }else if([pid isEqualToString:@"015E"]){//get Engine fuel rate (L/h)
            if(code.length==4){
                NSInteger a=[[code substringWithRange:NSMakeRange(0, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(1, 1)] floatValue];
                NSInteger b=[[code substringWithRange:NSMakeRange(2, 1)] floatValue]*16+[[code substringWithRange:NSMakeRange(3, 1)] floatValue];
                float sum=(a*256+b)/20;
                if(sum<0||sum>3276.75){
                    NSLog(@"Engine fuel rate out of bounds");
                    return nil;
                }else{
                    result=[NSString stringWithFormat:@"%f",sum];//get Engine fuel rate (L/h)
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
                return nil;
            }
        }
        
    }else{
        NSLog(@"%@ is not supported",pid);
        return nil;
    }
    return result;
}

@end
