//
//  KeyChainManager.h
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString * const kKeyPassword = @"com.beijing.LaundrySheet.password";

@interface KeyChainManager : NSObject

+ (void)save:(NSString *)service data:(id)data;
+ (id)load:(NSString *)service;
+ (void)delete:(NSString *)service;

@end
