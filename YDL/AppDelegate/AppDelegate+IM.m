//
//  AppDelegate+IM.m
//  YQW
//
//  Created by Sunshine on 2017/6/20.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppDelegate+IM.h"
#import <HyphenateLite/HyphenateLite.h>
//测试版本！！！
@implementation AppDelegate (IM)

- (void)IMinit {
    EMOptions *options = [EMOptions optionsWithAppkey:HUANXIN_IM_KEY];
    options.apnsCertName = @"istore_dev"; //推送证书名
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    
    
    EMError *error = [[EMClient sharedClient] registerWithUsername:@"13621202803_2" password:@"111111"];
    if (!error) {
        NSLog(@"注册(3)成功");
    }
    
    //登陆
    [[EMClient sharedClient] loginWithUsername:@"13621202803_3"
                                      password:@"111111"
                                    completion:^(NSString *aUsername, EMError *aError) {
                                        if (!aError) {
                                            NSLog(@"登录(aUsername)成功");
                                            
                                        } else {
                                            NSLog(@"登录失败");
                                        }
                                    }];
    BOOL isAutoLogin = [EMClient sharedClient].options.isAutoLogin;
    if (!isAutoLogin) {
        EMError *error = [[EMClient sharedClient] loginWithUsername:@"13621202803_3" password:@"111111"];
    }else{
        
    }
    


}

- (void)IMapplicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)IMapplicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

@end
