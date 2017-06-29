//
//  logInView.m
//  YDL
//
//  Created by Sunshine on 2017/6/29.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "logInView.h"

@interface logInView ()<UITextFieldDelegate>

@end

@implementation logInView{
    void (^_block) (NSInteger index);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT) imageName:@"logInBg" SuperView:self];
    
    UIButton *backBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), FitheightRealValue(18), 44, 44) NormalbgImageStr:@"icon_back" highLightbgimageStr:@"icon_back" tag:500 SuperView:self buttonTarget:self Action:@selector(back:) ImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 0)];

    self.userIcon = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake((CYTMainScreen_WIDTH - FitwidthRealValue(80)) / 2, backBtn.bottom, FitwidthRealValue(80), FitwidthRealValue(80)) imageName:@"logInUser" SuperView:self];
    
    UIVisualEffectView *TFBG = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    TFBG.layer.cornerRadius = 5;
    TFBG.layer.masksToBounds = YES;
    TFBG.frame = CGRectMake(FitwidthRealValue(20), self.userIcon.bottom + FitheightRealValue(20), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(89));
    
    [self addSubview:TFBG];
    //账号
    self.accountTf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, TFBG.width, FitheightRealValue(44))];
    self.accountTf.font = FitFont(16);
    self.accountTf.placeholder = @"用户名";
    self.accountTf.delegate = self;
    self.accountTf.textColor = whiteColor;
    self.accountTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.accountTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FitwidthRealValue(50), CGRectGetHeight(self.accountTf.frame))];
    self.accountTf.leftViewMode = UITextFieldViewModeAlways;
    UIImageView *accountImg = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake( FitwidthRealValue(10),FitheightRealValue(12), FitwidthRealValue(20), FitwidthRealValue(20)) imageName:@"logInAccount"];
    UIView *verticalBar = [[UIView alloc] initWithFrame:CGRectMake(accountImg.right + FitwidthRealValue(10), FitheightRealValue(12), FitwidthRealValue(1), FitheightRealValue(20))];
    verticalBar.backgroundColor = whiteColor;
    [self.accountTf.leftView addSubview:accountImg];
    [self.accountTf.leftView addSubview:verticalBar];
    [TFBG addSubview:self.accountTf];
    //线
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(FitwidthRealValue(10), self.accountTf.bottom, TFBG.width - FitwidthRealValue(20), FitheightRealValue(1))];
    line.backgroundColor = whiteColor;
    [TFBG addSubview:line];
    
    //密码
    self.passwordTf = [[UITextField alloc] initWithFrame:CGRectMake(0, line.bottom, TFBG.width, FitheightRealValue(44))];
    self.passwordTf.font = FitFont(16);
    self.passwordTf.placeholder = @"密码";
    self.passwordTf.textColor = whiteColor;
    self.passwordTf.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.passwordTf.delegate = self;
    self.passwordTf.secureTextEntry = YES;
    self.passwordTf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FitwidthRealValue(50), CGRectGetHeight(self.passwordTf.frame))];
    self.passwordTf.leftViewMode = UITextFieldViewModeAlways;

    UIImageView *passwordImg = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(FitwidthRealValue(10), FitwidthRealValue(12), FitwidthRealValue(20), FitwidthRealValue(20)) imageName:@"logInPw"];
    UIView *verticalBar2 = [[UIView alloc] initWithFrame:CGRectMake(passwordImg.right + FitwidthRealValue(10), FitheightRealValue(12), FitwidthRealValue(1), FitheightRealValue(20))];
    verticalBar2.backgroundColor = whiteColor;
    [self.passwordTf.leftView addSubview:passwordImg];
    [self.passwordTf.leftView addSubview:verticalBar2];
    [TFBG addSubview:self.passwordTf];
    
    self.logInBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(20), TFBG.bottom + FitheightRealValue(20), CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(40)) LabelText:@"登  录" TextFont:FitFont(16) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor orangeColor] highLightBgColor:[UIColor orangeColor] tag:1003 SuperView:self CornerRadius:5 buttonTarget:self Action:@selector(logInAction)];
    
    self.registeredBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(20), self.logInBtn.bottom + FitheightRealValue(5), self.logInBtn.width / 2, FitheightRealValue(40)) LabelText:@"快捷注册 >>" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor clearColor] highLightBgColor:[UIColor clearColor] tag:1004 SuperView:self buttonTarget:self Action:@selector(registerAction)];
    
    self.forgotPwBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(self.logInBtn.width / 2, self.logInBtn.bottom + FitheightRealValue(5), self.logInBtn.width / 2, FitheightRealValue(40)) LabelText:@"忘记密码 >>" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor clearColor] highLightBgColor:[UIColor clearColor] tag:1005 SuperView:self buttonTarget:self Action:@selector(forgotPwAction)];

}

#pragma mark 登录
- (void)logInAction {
    [self.accountTf resignFirstResponder];
    [self.passwordTf resignFirstResponder];
    
    if (_clickBlock) {
        _clickBlock(self.accountTf.text, self.passwordTf.text);
    }
}

- (void)setClickBlock:(ClicksAlertBlock)clickBlock{
    _clickBlock = [clickBlock copy];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.accountTf resignFirstResponder];
    [self.passwordTf resignFirstResponder];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.window resignFirstResponder];
}

- (void)callBack:(selectedRegOrForgotPw)callBack {
    _block = callBack;
}

#pragma mark 注册
- (void)registerAction {
    if (_block) {
        _block(1);
    }
}

#pragma mark 忘记密码
- (void)forgotPwAction {
    if (_block) {
        _block(2);
    }
}

#pragma mark 返回
- (void)back:(UIButton *)btn {
    if (_block) {
        _block(3);
    }
}


@end
