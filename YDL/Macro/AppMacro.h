//
//  AppMacro.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h


#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define CYT_SYSTEM_VERSION   [[[UIDevice currentDevice] systemVersion] floatValue] //系统版本号
#define CYTAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self


typedef void (^VoidBlock)();

#define userManager [UserManager sharedInstance]
#define locationManager [LocationManager sharedInstance]


//----------------------------------- sdk配置 ------------------------------------
#define BAIDU_MAP_KEY       @"D3MpXiryyN1wT3UhGDffk8Wcn55ciDkV"
#define HUANXIN_IM_KEY      @"anya18701208276#huanxintongxun"
#define UMENG_APP_KEY       @"5955b5eb7f2c74204c0010ca"
#define UMENG_Push_SECRET   @"xrgm5tuvs1akda3gwvppwstjuoeywbnx"

#endif /* AppMacro_h */
