//
//  VersionRequest.h
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface VersionRequest : BaseAPIRequest <APIManager>

@end

@interface VersionResponse : BaseResponse
@property(nonatomic,copy)NSDictionary *data;
@property(nonatomic,assign)BOOL needUpdate;
@property(nonatomic,copy)NSString *content;

@end
