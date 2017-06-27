//
//  AppDelegate+ThreeDTouch.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AppDelegate+ThreeDTouch.h"

@implementation AppDelegate (ThreeDTouch)

- (void)touch3d:(UIApplication *)application {
    //添加图标的类型
    UIApplicationShortcutIcon *icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeSearch];
    //添加主标题,副标题,以及唯一标识
    UIApplicationShortcutItem *item = [[UIApplicationShortcutItem alloc] initWithType:@"first" localizedTitle:@"搜索" localizedSubtitle:@"" icon:icon userInfo:nil];
    
    UIApplicationShortcutIcon* icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"logo~iphone"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"second" localizedTitle:@"推荐" localizedSubtitle:@"" icon:icon2 userInfo:nil];
    
    UIApplicationShortcutIcon* icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"logo~iphone"];
    UIApplicationShortcutItem *item3 = [[UIApplicationShortcutItem alloc] initWithType:@"third" localizedTitle:@"入口" localizedSubtitle:@"" icon:icon3 userInfo:nil];
    
    application.shortcutItems = @[item,item2, item3];
}

#pragma mark  - 3DTouch
//根据item对应的type标识处理对应的点击操作
//事件的唯一标识符,shortcutItemType通过这个辨别对应标识的处理
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    //根据item对应的type标识处理对应的点击操作
    NSString * itemType = shortcutItem.type;
    if ([@"first" isEqualToString:itemType]) {
        [CustomHUD createShowContent:@"3DTouch震撼来袭！！！" hiddenTime:2];
    }else if ([@"second" isEqualToString:itemType]){
        [CustomHUD createShowContent:@"你瞅啥？" hiddenTime:2];

    }else if ([@"third" isEqualToString:itemType]){
        [CustomHUD createShowContent:@"瞅你咋的！！！" hiddenTime:2];

    }
}

@end
