//
//  UserModel.h
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/**
 *  账号
 */
@property (nonatomic, strong) NSString *phone;
//余额
@property (nonatomic, strong) NSString *balance;

@property (nonatomic, copy) NSString *total_balance;

/**
 *  用户密码
 */
@property (nonatomic, strong) NSString *passWord;

/**
 *  account_id
 */
@property (nonatomic, strong) NSString *account_id;

/**
 *  account_id
 */
@property (nonatomic, strong) NSString *account_type;

/**
 *  user_token
 */
@property (nonatomic, strong) NSString *user_token;

/**
 *  create_time
 */
@property (nonatomic, strong) NSString *create_time;

@property (nonatomic, strong) NSString *dispatch_set;
@property (nonatomic, strong) NSString *from_ip;
@property (nonatomic, strong) NSString *frozen_sum;
@property (nonatomic, strong) NSString *integral;
@property (nonatomic, strong) NSString *last_device;
@property (nonatomic, strong) NSString *last_os;
@property (nonatomic, strong) NSString *last_time;
@property (nonatomic, strong) NSString *my_invite_code;
@property (nonatomic, strong) NSString *update_time;
@property (nonatomic, strong) NSString *withdraw_money;

/**
 *  user_id
 */
@property (nonatomic, assign) NSInteger user_id;

/**
 *  is_enable
 */
@property (nonatomic, assign) NSInteger is_enable;

/**
 *  device_token
 */
@property (nonatomic, assign) NSInteger device_token;

@end
