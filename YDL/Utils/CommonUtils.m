//
//  CommonUtils.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "CommonUtils.h"
#include <CommonCrypto/CommonDigest.h>

@implementation CommonUtils

+ (NSString *)filePathWithFileName:(NSString *)fileName shouldCreateWhenNotExist:(BOOL)shouldCreateWhenNotExist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *localDirPath = [documentsDirectory stringByAppendingPathComponent:@"anz"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    if (![fileManager fileExistsAtPath:localDirPath isDirectory:&isDir]) {
        [fileManager createDirectoryAtPath:localDirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString *filePath = [localDirPath stringByAppendingPathComponent:fileName];
    if (![fileManager fileExistsAtPath:filePath]) {
        if (shouldCreateWhenNotExist) {
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
            [self addSkipBackupAttributeToItemAtURL:[NSURL URLWithString:filePath]];
        } else {
            filePath = nil;
        }
    }
    return filePath;
}

+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}

+(NSString *)sha512Encode:(NSString *)string
{
    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    uint8_t digest[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString* output = [NSMutableString  stringWithCapacity:CC_SHA512_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA512_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    return output;
}

+(NSString *)sha1Encode:(NSString *)string
{
    //    const char *cstr = [string cStringUsingEncoding:NSUTF8StringEncoding];
    //    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

+(NSString *)MD5:(NSString *)str{
    //32位MD5小写
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (int)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)data2Hex:(NSData *)data {
    if (!data) {
        return nil;
    }
    Byte *bytes = (Byte *)[data bytes];
    NSMutableString *str = [NSMutableString stringWithCapacity:data.length * 2];
    for (int i=0; i < data.length; i++){
        [str appendFormat:@"%0x", bytes[i]];
    }
    return str;
}

+(BOOL)call:(NSString *)phoneNumber
{
    phoneNumber=[phoneNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    return [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
}

+(NSString *)getVersionCode
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (void)setCAKeyframeAnimation:(UIView *)view {
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.30;
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}

+(NSArray*)checkArray:(NSArray*)array
{
    if (array!=nil&&([array isKindOfClass:[NSArray class]]||[array isKindOfClass:[NSMutableArray class]]))
    {
        return array;
    }
    return nil;
}

@end
