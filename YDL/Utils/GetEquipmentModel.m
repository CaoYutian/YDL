//
//  GetEquipmentModel.m
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/20.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "GetEquipmentModel.h"
#import "sys/utsname.h"

@implementation GetEquipmentModel

+ (NSString *)EquipmentModel {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone5s";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone6";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone6Plus";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone6sPlus";
    
    if ([platform isEqualToString:@"iPhone8,3"]) return @"iPhoneSE";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhoneSE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone7Plus";
    
    return platform;
}

@end
