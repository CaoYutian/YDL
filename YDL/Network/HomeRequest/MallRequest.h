//
//  MallRequest.h
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface MallRequest : BaseAPIRequest<APIManager>

@end

@interface MallResponse : BaseResponse
@property (nonatomic, strong) NSArray *picturesList;

@end
