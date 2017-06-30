//
//  AppDelegate+UMeng.h
//  YDL
//
//  Created by Sunshine on 2017/6/30.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppDelegate.h"
#import "UMMobClick/MobClick.h"
#import "UMessage.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (UMeng)<UNUserNotificationCenterDelegate>

- (void)UMengAnalyticsInit;

- (void)UMengPushdidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
