//
//  AppDelegate+UMeng.m
//  YDL
//
//  Created by Sunshine on 2017/6/30.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppDelegate+UMeng.h"
#import "UMMobClick/MobClick.h"

@implementation AppDelegate (UMeng)

- (void)UMengAnalyticsInit {
    
    UMConfigInstance.appKey = UMENG_APP_KEY;
    UMConfigInstance.channelId = @"App Store";
    [MobClick startWithConfigure:UMConfigInstance];
    
    [MobClick setLogEnabled:YES];
    
}

@end
