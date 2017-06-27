//
//  UserManager.h
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

@interface UserManager : NSObject

+ (instancetype)sharedInstance;
+ (BOOL)isLogedin;
+ (void)saveLocalUserLoginInfo;
+ (void)removeLocalUserLoginInfo;
+ (void)initWithLocalUserLoginInfo;

- (void)updatePassword:(NSString *)password;

@property(nonatomic, strong) UserModel *userData;
@property(nonatomic, copy) NSString *password;

@end
