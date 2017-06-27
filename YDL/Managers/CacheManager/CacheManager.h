//
//  CacheManager.h
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject

//缓存大小
@property (nonatomic) NSCache *cache;

//缓存大小
@property (nonatomic) CGFloat cacheFileSize;
/**
 *  清除缓存单例
 */
+ (CacheManager *)sharedCacheManager;
/**
 *  清除缓存
 */
- (void)clearCache;

@end
