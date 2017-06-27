//
//  LogoutRequest.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "LogoutRequest.h"

@implementation LogoutRequest

- (NSString *)requestPath
{
    return Logout_Url;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypePost;
}

- (Class)responseClass
{
    return [BaseResponse class];
}

@end
