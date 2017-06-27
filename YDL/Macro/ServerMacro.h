//
//  ServerMacro.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#ifndef ServerMacro_h
#define ServerMacro_h


#if defined APP_DEBUG

//-----------------------------------  测试环境  ------------------------------------
#define Service_Address     @"https://test.isofoo.com/isofoo-api/"

#else

//-----------------------------------  生产环境  ------------------------------------
#define Service_Address     @"https://test.isofoo.com/isofoo-api/"


#endif

#define BaseUrl     Service_Address@""

//--------------------- common---------------------
#define Version_Url                     @"/noa/version"             //版本更新



//--------------------- 首页---------------------
#define CYT_flash_advertisement              @"api/v2.5/comm/self_goods/pictures_list"   //抢单模块闪惠购







//--------------------- 个人中心---------------------
#define Logout_Url                           @""



#endif /* ServerMacro_h */
