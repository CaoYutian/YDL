//
//  UserModel.m
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

- (id)copyWithZone:(NSZone *)zone {
    return [self yy_modelCopy];
}

- (instancetype)init {
    if (self = [super init]) {
        _account_id = @"-1";
        _balance = @"";
        _is_enable = 0;
        _phone = @"";
        _user_id = 0;
        _withdraw_money = @"";
        _create_time = @"";
        _user_token = @"-1";
        _dispatch_set = @"";
        _update_time = @"";
        _total_balance = @"";
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"user_id":@"id"};
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [self yy_modelEncodeWithCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        [self yy_modelInitWithCoder:aDecoder];
    }
    return self;
}

@end
