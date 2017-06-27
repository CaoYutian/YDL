//
//  HomeRequest.h
//  YQW
//
//  Created by Sunshine on 2017/5/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseAPIRequest.h"

@interface HomeRequest : BaseAPIRequest<APIManager>

@end

@interface HomeResponse : BaseResponse
@property (nonatomic, strong) NSArray *picturesList;

@end
