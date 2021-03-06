//
//  RecvMessageAnalysis.m
//  IM
//
//  Created by Dezheng Wang  on 2/6/17.
//  Copyright © 2017 Dezheng Wang. All rights reserved.
//

#import "RecvMessageAnalysis.h"
#import "SendCommand.h"


@interface RecvMessageAnalysis(){
    NSString *substring;
    NSString *result;
    NSMutableArray *indexArray;
    NSMutableArray *supportedPidIndexArray;
    NSMutableArray *pidArray;
}

@end

@implementation RecvMessageAnalysis
Boolean getPreviousSpeed=NO;

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
//        NSLog(@"%@",substring);
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
    SendCommand *sendcommand=[SendCommand sharedSendCommand];
    
    if([pid isEqualToString:@"0105"]){ //Engine coolant temperature(°C)
        if(code.length==2){
            NSInteger a=[self convertToDecimal:[code substringWithRange:NSMakeRange(0, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(1, 1)]];
            a=a-40;
            if(a<-40||a>215){
                NSLog(@"Engine coolant temperature is out of bounds");
            }else{
                result=[NSString stringWithFormat:@"%ld",(long)a];//get Engine coolant temperature (°C)
                [dictionary setValue:result forKey:@"EngineCoolantTemperature"];
                sendcommand.pid=@"010D";
            }
        }else{
            NSLog(@"Length of %@ is not correct",code);
        }
    }else if([pid isEqualToString:@"010C"]){//get Engine RPM (rmp)
            if(code.length==4){
                NSInteger a=[self convertToDecimal:[code substringWithRange:NSMakeRange(0, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(1, 1)]];
                NSInteger b=[self convertToDecimal:[code substringWithRange:NSMakeRange(2, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(3, 1)]];
                NSInteger sum=(256*a+b)/4;
                if(sum>16383.75||sum<0){
                    NSLog(@"RPM out of bounds");
                }else{
                    result=[NSString stringWithFormat:@"%ld",(long)sum];//get Engine RPM (rmp)
                    [dictionary setValue:result forKey:@"RPM"];
                    sendcommand.pid=@"010D";
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
            }
    }else if([pid isEqualToString:@"010D"]){//get Vehicle speed(m/h)
            if(code.length==2){
                NSInteger a=[self convertToDecimal:[code substringWithRange:NSMakeRange(0, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(1, 1)]];
                a=a/1.6;
                if(a!=0){
                    a=a+1;
                }
                if(a<0||a>255){
                    NSLog(@"Speed out of bounds");
                }else{
                    result=[NSString stringWithFormat:@"%ld",(long)a];//get Vehicle speed (m/h)
                    if(getPreviousSpeed){
                        [dictionary setValue:[dictionary valueForKey:@"Speed"] forKey:@"PreviousSpeed"];
                    }
                    [dictionary setValue:result forKey:@"Speed"];
                    getPreviousSpeed=YES;
                    
                    int drivingTime=[[dictionary valueForKey:@"DrivingTime"] intValue];
                    if(drivingTime%2==0){
                        if(drivingTime%5==0){
                           sendcommand.pid=@"0105"; //sending rate is 1/10
                        }else if(drivingTime%3==0){  //sending rate is about 1.3/10
                            sendcommand.pid=@"0142"; //sending rate is about 2.7/10
                        }else{
                           sendcommand.pid=@"0110";
                        }
                    }else{
                        sendcommand.pid=@"010C"; //sending rate is 1/2
                    }
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
            }
    }else if([pid isEqualToString:@"0110"]){//get MAF air flow rate (grams/sec)
            if(code.length==4){
                NSInteger a=[self convertToDecimal:[code substringWithRange:NSMakeRange(0, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(1, 1)]];
                NSInteger b=[self convertToDecimal:[code substringWithRange:NSMakeRange(2, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(3, 1)]];
                float sum=(a*256+b)/100;
                if(sum<0||sum>655.35){
                    NSLog(@"MAF air flow rate is out of bounds");
                }else{
                    result=[NSString stringWithFormat:@"%.2f",sum];//get MAF air flow rate (grams/sec)
                    [dictionary setValue:result forKey:@"MAF"];
                    sendcommand.pid=@"010D";
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
            }
    }else if([pid isEqualToString:@"0142"]){//get Control module voltage (V)
            if(code.length==4){
                NSInteger a=[self convertToDecimal:[code substringWithRange:NSMakeRange(0, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(1, 1)]];
                NSInteger b=[self convertToDecimal:[code substringWithRange:NSMakeRange(2, 1)]]*16+[self convertToDecimal:[code substringWithRange:NSMakeRange(3, 1)]];
                float sum=(a*256+b)/1000;
                if(sum<0||sum>65.535){
                    NSLog(@"Control module voltage is out of bounds");
                }else{
                    result=[NSString stringWithFormat:@"%.2f",sum];//get Control module voltage (V)
                    [dictionary setValue:result forKey:@"ControlModuleVoltage"];
                    sendcommand.pid=@"010D";
                }
            }else{
                NSLog(@"Length of %@ is not correct",code);
            }
        }
    [sendcommand resumeTimerForUpdate];
    return result;
}

-(float)convertToDecimal: (NSString *) hexadecimalString
{
    float value;
    
    if([hexadecimalString isEqualToString:@"A"]){
        value=10;
    }else if([hexadecimalString isEqualToString:@"B"]){
        value=11;
    }else if([hexadecimalString isEqualToString:@"C"]){
        value=12;
    }else if([hexadecimalString isEqualToString:@"D"]){
        value=13;
    }else if([hexadecimalString isEqualToString:@"E"]){
        value=14;
    }else if([hexadecimalString isEqualToString:@"F"]){
        value=15;
    }else{
        value=[hexadecimalString floatValue];
    }
    return  value;
}

-(void)analysisDiagnosticCode:(NSString *)recvCode{
    //byte to binary
    NSLog(@"%@,%lu",recvCode,recvCode.length);
    for(int i=0;i<recvCode.length/4;i++){
        [self findTroubleCode:[recvCode substringWithRange:NSMakeRange(i*4, 4)]];
    }

    
}

-(void)findTroubleCode:(NSString *)errorCode
{
    NSString *firstBinary=[self convertToBinary:[errorCode substringWithRange:NSMakeRange(0, 1)]];
    NSString *secondBinary=[self convertToBinary:[errorCode substringWithRange:NSMakeRange(1, 1)]];
    NSString *thirdBinary=[self convertToBinary:[errorCode substringWithRange:NSMakeRange(2, 1)]];
    NSString *fourthBinary=[self convertToBinary:[errorCode substringWithRange:NSMakeRange(3, 1)]];
    
    
    //get full binary string
    NSString *binaryCode=[[[firstBinary stringByAppendingString:secondBinary] stringByAppendingString:thirdBinary] stringByAppendingString:fourthBinary];
    
    NSString *firstString=[binaryCode substringWithRange:NSMakeRange(0, 2)];//first two bits
    NSString *secondString=[binaryCode substringWithRange:NSMakeRange(2, 2)]; //following two bits
    NSString *thirdString=[binaryCode substringWithRange:NSMakeRange(4, 4)];  //following four bits
    NSString *fourthString=[binaryCode substringWithRange:NSMakeRange(8, 4)];//following four bits
    NSString *fifthString=[binaryCode substringWithRange:NSMakeRange(12, 4)];//last four bits
    
    //get final trouble code
    NSString *troubleCode=@"";
    if([firstString isEqualToString:@"00"]){
        troubleCode=[troubleCode stringByAppendingString:@"P"];
    }else if([firstString isEqualToString:@"01"]){
        troubleCode=[troubleCode stringByAppendingString:@"C"];
    }else if([firstString isEqualToString:@"10"]){
        troubleCode=[troubleCode stringByAppendingString:@"B"];
    }else if([firstString isEqualToString:@"11"]){
        troubleCode=[troubleCode stringByAppendingString:@"U"];
    }else{
        NSLog(@"Error!!!");
    }
    
    if([secondString isEqualToString:@"00"]){
        troubleCode=[troubleCode stringByAppendingString:@"0"];
    }else if([secondString isEqualToString:@"01"]){
        troubleCode=[troubleCode stringByAppendingString:@"1"];
    }else if([secondString isEqualToString:@"10"]){
        troubleCode=[troubleCode stringByAppendingString:@"2"];
    }else if([secondString isEqualToString:@"11"]){
        troubleCode=[troubleCode stringByAppendingString:@"3"];
    }else{
        NSLog(@"Error!!!");
    }
    
    troubleCode=[troubleCode stringByAppendingString:[self convertToHexadecimal:thirdString]];
    troubleCode=[troubleCode stringByAppendingString:[self convertToHexadecimal:fourthString]];
    troubleCode=[troubleCode stringByAppendingString:[self convertToHexadecimal:fifthString]];
    
    NSLog(@"Trouble code:%@",troubleCode);
    
    NSString *bundlePath = [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:@"Resource.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    NSString *fileContents = [NSString stringWithContentsOfFile:[bundle pathForResource:@"OBDII-Fault code" ofType:@"txt"] encoding:NSUTF8StringEncoding error:NULL];
    for (NSString *line in [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]]) {
        if([[line substringWithRange:NSMakeRange(0, 5)] isEqualToString:troubleCode]){
            NSLog(@"Information:%@",[line substringFromIndex:6]);
            
            NSUserDefaults *dictionary=[NSUserDefaults standardUserDefaults];
            NSMutableDictionary *diagnosticDictionary=[[NSMutableDictionary alloc] init];
            
            if([dictionary valueForKey:@"DiagnosticInformation"]){ //read exist diagnostic information dictionary
                diagnosticDictionary=[dictionary valueForKey:@"DiagnosticInformation"];
                if(![diagnosticDictionary objectForKey:[line substringWithRange:NSMakeRange(0, 5)]]){
                  [diagnosticDictionary setValue:[line substringFromIndex:6] forKey:[line substringWithRange:NSMakeRange(0, 5)]];
                }


            }else{//doesn't exist and create diagnostic information dictionary
                [diagnosticDictionary setValue:[line substringFromIndex:6] forKey:[line substringWithRange:NSMakeRange(0, 5)]];
            }
            [dictionary setValue:diagnosticDictionary forKey:@"DiagnosticInformation"];
            return;
        }
    }

}

-(NSString *)convertToBinary:(NSString *) halfByte{
    NSString *value;
    if([halfByte isEqualToString:@"0"]){
        value=@"0000";
    }else if([halfByte isEqualToString:@"1"]){
        value=@"0001";
    }else if([halfByte isEqualToString:@"2"]){
        value=@"0010";
    }else if([halfByte isEqualToString:@"3"]){
        value=@"0011";
    }else if([halfByte isEqualToString:@"4"]){
        value=@"0100";
    }else if([halfByte isEqualToString:@"5"]){
        value=@"0101";
    }else if([halfByte isEqualToString:@"6"]){
        value=@"0110";
    }else if([halfByte isEqualToString:@"7"]){
        value=@"0111";
    }else if([halfByte isEqualToString:@"8"]){
        value=@"1000";
    }else if([halfByte isEqualToString:@"9"]){
        value=@"1001";
    }else if([halfByte isEqualToString:@"A"]){
        value=@"1010";
    }else if([halfByte isEqualToString:@"B"]){
        value=@"1011";
    }else if([halfByte isEqualToString:@"C"]){
        value=@"1100";
    }else if([halfByte isEqualToString:@"D"]){
        value=@"1101";
    }else if([halfByte isEqualToString:@"E"]){
        value=@"1110";
    }else if([halfByte isEqualToString:@"F"]){
        value=@"1111";
    }else{
        NSLog(@"Error!!!");
    }
    return  value;
}

-(NSString *)convertToHexadecimal:(NSString *) binaryString{
    NSString *value;
    if([binaryString isEqualToString:@"0000"]){
        value=@"0";
    }else if([binaryString isEqualToString:@"0001"]){
        value=@"1";
    }else if([binaryString isEqualToString:@"0010"]){
        value=@"2";
    }else if([binaryString isEqualToString:@"0011"]){
        value=@"3";
    }else if([binaryString isEqualToString:@"0100"]){
        value=@"4";
    }else if([binaryString isEqualToString:@"0101"]){
        value=@"5";
    }else if([binaryString isEqualToString:@"0110"]){
        value=@"6";
    }else if([binaryString isEqualToString:@"0111"]){
        value=@"7";
    }else if([binaryString isEqualToString:@"1000"]){
        value=@"8";
    }else if([binaryString isEqualToString:@"1001"]){
        value=@"9";
    }else if([binaryString isEqualToString:@"1010"]){
        value=@"A";
    }else if([binaryString isEqualToString:@"1011"]){
        value=@"B";
    }else if([binaryString isEqualToString:@"1100"]){
        value=@"C";
    }else if([binaryString isEqualToString:@"1101"]){
        value=@"D";
    }else if([binaryString isEqualToString:@"1110"]){
        value=@"E";
    }else if([binaryString isEqualToString:@"1111"]){
        value=@"F";
    }else{
        NSLog(@"Error!!!");
    }
    return  value;
}

@end
