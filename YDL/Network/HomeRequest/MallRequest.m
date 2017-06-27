//
//  MallRequest.m
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MallRequest.h"
#import "GoodsDynamicModel.h"

@implementation MallRequest

- (NSString *)requestPath {
    return CYT_flash_advertisement;
}

- (APIManagerRequestType)requestType {
    return APIManagerRequestTypeGet;
}

- (Class)responseClass {
    return [MallResponse class];
}

@end

@implementation MallResponse

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"picturesList" : [GoodsDynamicModel class]};
}

@end
