//
//  ComColorManager.h
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/21.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ComColorManager : NSObject

+(instancetype)defaultManager;

/**
 *  通过十六进制格式获取UIColor
 *
 *  @param hexColor 如0xffffff 或  #ffffff
 *
 *  @return UIColor 这个方法不会从内存中读取
 */
+ (UIColor*)colorWithHexString:(NSString *)hexColor;

/**
 *  获取UIColor，优先在内存中获取
 *
 *  @param hex 如0xffffff 或  #ffffff  alpha = 0~1.0
 *
 *  @return UIColor
 */
+ (UIColor*)colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;

@end
