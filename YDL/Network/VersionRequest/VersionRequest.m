//
//  VersionRequest.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "VersionRequest.h"

@implementation VersionRequest

- (NSString *)requestPath
{
    return Version_Url;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypeGet;
}

- (Class)responseClass
{
    return [VersionResponse class];
}

@end

@implementation VersionResponse

-(BOOL)needUpdate
{
    return [self.data[@"version_code"] boolValue];
}

-(NSString *)content
{
    return safeString(self.data[@"content"]);
}

@end
