//
//  LogInAPIRequest.h
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "BaseAPIRequest.h"
#import "UserModel.h"

@interface LogInAPIRequest : BaseAPIRequest<APIManager>

+ (void)autoReloginSuccess:(void(^)())success failure:(void(^)())failure;

@end

@interface LoginResponse : BaseResponse
@property (nonatomic, strong) UserModel *UserInfo;
@end
