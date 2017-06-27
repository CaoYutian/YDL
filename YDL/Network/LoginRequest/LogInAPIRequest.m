//
//  LogInAPIRequest.m
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "LogInAPIRequest.h"

@interface LogInAPIRequest ()

@property (nonatomic, copy) void (^loginSuccessBlock) ();
@property (nonatomic, copy) void (^loginFailureBlock)();;

@end

@implementation LogInAPIRequest

- (NSString *)requestPath {
    return nil;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypePost;
}

- (Class)responseClass {
    return [LoginResponse class];
}

+ (void)autoReloginSuccess:(void (^)())success failure:(void (^)())failure {
    NSLog(@"%@----%@",userManager.userData.phone,userManager.password);
    LogInAPIRequest *loginRequest = [[LogInAPIRequest alloc] init];
    loginRequest.paramSource = (id)loginRequest;
    loginRequest.delegate = (id)loginRequest;
    
    if (userManager.userData.phone.length && userManager.password.length) {
        loginRequest.loginSuccessBlock = ^ {
            [UserManager saveLocalUserLoginInfo];
            success();
        };
        loginRequest.loginFailureBlock = ^ {
            failure();
        };
        [loginRequest loadDataWithHUDOnView:nil];
    } else {
        failure();
    }
    
}


#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
    if (request==self) {
        if (self.loginSuccessBlock) {
            self.loginSuccessBlock();
        }
    }
}

- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
    if (request==self) {
        if (self.loginFailureBlock) {
            self.loginFailureBlock();
        }
        return;
    }
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request {
    if (request==self) {
        return @{@"phone":userManager.userData.phone,
                 @"password":userManager.password,
                 @"device_token":@"-1",
                 @"account_type":@"2"};
    }
    return nil;
}

@end

@implementation LoginResponse

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"UserInfo":@"data"};
}

@end
