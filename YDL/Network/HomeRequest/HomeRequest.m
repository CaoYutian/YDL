//
//  HomeRequest.m
//  YQW
//
//  Created by Sunshine on 2017/5/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "HomeRequest.h"
#import "GoodsDynamicModel.h"

@implementation HomeRequest

- (NSString *)requestPath {
    return CYT_flash_advertisement;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypeGet;
}

- (Class)responseClass {
    return [HomeResponse class];
}

@end

@implementation HomeResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"picturesList" : [GoodsDynamicModel class]};
}

@end
