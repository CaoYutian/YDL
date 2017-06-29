//
//  logInView.h
//  YDL
//
//  Created by Sunshine on 2017/6/29.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface logInView : UIView
typedef void(^selectedRegOrForgotPw) (NSInteger index);
- (void)callBack:(selectedRegOrForgotPw)callBack;


typedef void (^ClicksAlertBlock)(NSString *accountText, NSString *passwordText);
@property (nonatomic, copy, readonly) ClicksAlertBlock clickBlock;
- (void)setClickBlock:(ClicksAlertBlock)clickBlock;

/**
 用户头像
 */
@property (nonatomic, strong) UIImageView *userIcon;
/**
 账号
 */
@property (nonatomic, strong) UITextField *accountTf;
/**
 密码
 */
@property (nonatomic, strong) UITextField *passwordTf;
/**
 登陆
 */
@property (nonatomic, strong) UIButton *logInBtn;
/**
 注册
 */
@property (nonatomic, strong) UIButton *registeredBtn;
/**
 忘记密码
 */
@property (nonatomic, strong) UIButton *forgotPwBtn;


@end
