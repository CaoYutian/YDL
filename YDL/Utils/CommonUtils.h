//
//  CommonUtils.h
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUtils : NSObject

/**
 *  获取文件路径
 *
 *  @param fileName                 文件名
 *  @param shouldCreateWhenNotExist 当文件不存在时是否创建
 *
 *  @return 文件路径
 */
+ (NSString *)filePathWithFileName:(NSString *)fileName shouldCreateWhenNotExist:(BOOL)shouldCreateWhenNotExist;

/**
 *  忽略文件备份
 *
 *  @param URL 文件路径
 *
 *  @return 是否成功
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

/**
 *  sha512加密
 *
 *  @param string 原始数据
 *
 *  @return 加密数据
 */
+(NSString *)sha512Encode:(NSString *)string;

/**
 *  sha1加密
 *
 *  @param string 原始数据
 *
 *  @return 加密数据
 */
+(NSString *)sha1Encode:(NSString *)string;

/**
 *  MD5加密
 *
 *  @param str 原始数据
 *
 *  @return 加密数据
 */
+(NSString *)MD5:(NSString *)str;

/**
 *  将二进制数据转换成十六进制字符串
 *
 *  @param data 二进制数据
 *
 *  @return 十六进制字符串
 */
+ (NSString *)data2Hex:(NSData *)data;

/**
 *  拨打电话
 *
 *  @param phoneNumber 电话号码
 *
 */
+(BOOL)call:(NSString *)phoneNumber;

/**
 *  获取版本号
 *
 *  @return 版本号
 */
+(NSString *)getVersionCode;


/**
 *  加载弹框视图的动画
 *
 */
+ (void)setCAKeyframeAnimation:(UIView *)view;

/**
 *  校验数组
 *
 *  @param array 校验对象
 *
 *  @return 数组
 */
+(NSArray*)checkArray:(NSArray*)array;

@end
