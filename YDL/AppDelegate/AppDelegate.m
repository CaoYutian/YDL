//
//  AppDelegate.m
//  YQW
//
//  Created by Sunshine on 2017/5/8.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppDelegate.h"
#import "YQBaseTabBarC.h"

#import "VersionManager.h"
#import "GuideView.h"

#import "AppDelegate+ThreeDTouch.h"
#import "AppDelegate+IM.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@interface AppDelegate (){
    BMKMapManager *_mapManager;
}

@property (nonatomic, strong) YQBaseTabBarC *tabBar;

@property (nonatomic, strong) VersionManager *versionManager;  //版本提示
@property (nonatomic, strong) GuideView *guide;                //引导页

@end

@implementation AppDelegate

- (void)showMainView{
    self.tabBar = [[YQBaseTabBarC alloc]init];
    self.window.rootViewController = self.tabBar;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    self.window = [[UIWindow alloc] initWithFrame:CYTMainScreen];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = MainBackgroundColor;
    [self showMainView];
    
//-----------------引导页-----------------
    [self loadGuideView];
    
//-----------------3DTouch-----------------
    if (CYT_SYSTEM_VERSION >= 9.0) {
        [self touch3d:application];
    }
    
//-----------------版本检查-----------------
//    self.versionManager = [[VersionManager alloc] init];
//    [self.versionManager checkVersionUpdate];
    
//-----------------百度地图-----------------
    _mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:BAIDU_MAP_KEY  generalDelegate:nil];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
//-----------------环信-----------------
    [self IMinit];
    
    return YES;
}

#pragma mark - 加载引导页
- (void)loadGuideView {
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"isRan"] boolValue]) {
        NSArray *arrayImage = @[@"loading1.jpg",@"loading2.jpg",@"loading3.jpg",@"loading4.jpg"];
        self.guide = [[GuideView alloc]initWithFrame:self.window.bounds imageArray:arrayImage];
        [self.window addSubview:self.guide];
        [[NSUserDefaults standardUserDefaults] setObject:@YES forKey:@"isRan"];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"程序暂停");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"程序进入后台");
    [self IMapplicationDidEnterBackground:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"程序回到前台");
    [self IMapplicationWillEnterForeground:application];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"程序激活");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"意外暂停");
}


@end
