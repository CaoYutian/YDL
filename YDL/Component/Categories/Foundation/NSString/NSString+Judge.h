//
//  NSString+Judge.h
//  YDL
//
//  Created by Sunshine on 2017/6/29.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Judge)
#pragma mark 正则判断是否是邮箱和手机号
//判断是否是邮箱

- (BOOL)isValidateEmail;

//判断是否是手机号
-(BOOL)isValidateMobile;

//判断是否是小数点两位
-(BOOL)isAfterPointTwoNum;

//银行卡校验
- (BOOL) checkCardNo:(NSString*) cardNo;

//校验密码 6 - 15位 含有数字和字母
-(BOOL)judgePassWordLegal:(NSString *)pass;

/**
 * 字母、数字、中文正则判断（包括空格）
 */
- (BOOL)isInputRuleAndBlank:(NSString *)str;
@end
