//
//  ForgotPwVC.m
//  YDL
//
//  Created by Sunshine on 2017/6/29.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ForgotPwVC.h"

@interface ForgotPwVC (){
    UIView *bgView;//textFeild下边的背景
}
@property (nonatomic ,strong) UITextField *userTf;
@property (nonatomic ,strong) UITextField *pwdTf;
@property (nonatomic, strong) UITextField *SecdpwdTf;
@property (nonatomic ,strong) UITextField *SecurityTf;
@property (nonatomic ,retain) UIButton *validationbtn;  //验证按钮

@end

@implementation ForgotPwVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
}

- (void)SetUpUI {
    [CYTUtiltyHelper createImageViewWithFrame:self.view.bounds imageName:@"background~iphone" SuperView:self.view];

//    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(80, 20, CYTMainScreen_WIDTH - 160, 44) LabelFont:FitFont(18) LabelTextColor:whiteColor LabelTextAlignment:NSTextAlignmentCenter SuperView:self.view LabelTag:100 LabelText:@"找回密码"];
    
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), FitheightRealValue(18), 44, 44) NormalbgImageStr:@"icon_back" highLightbgimageStr:@"icon_back" tag:500 SuperView:self.view buttonTarget:self Action:@selector(back:) ImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 0)];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 64, CYTMainScreen_WIDTH - 30, 184)];
    bgView.layer.cornerRadius = 3.0;
    bgView.backgroundColor = whiteColor;
    [self.view addSubview:bgView];
    //手机号
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 0, 80, 46) SuperView:bgView LabelTag:130 LabelText:@"手机号："];
    _userTf = [self createTextFieldFrame:CGRectMake(80, 0, CYTMainScreen_WIDTH - 80 - 30 - 110, 46) font:FitFont(14) placeholder:@"请输入手机号"];

    //验证码
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 46, 80, 46) SuperView:bgView LabelTag:132   LabelText:@"验证码："];
    _SecurityTf.secureTextEntry = YES;
    _SecurityTf = [self createTextFieldFrame:CGRectMake(80, 46, CYTMainScreen_WIDTH - 80 - 30, 46) font:FitFont(14) placeholder:@"请输入验证码"];
    _SecurityTf.keyboardType = UIKeyboardTypePhonePad;
    //新密码
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 92, 80, 46) SuperView:bgView LabelTag:131 LabelText:@"新密码："];
    _pwdTf = [self createTextFieldFrame:CGRectMake(80, 92, CYTMainScreen_WIDTH - 80 - 30, 46) font:FitFont(14) placeholder:@"请输入密码"];
    _pwdTf.secureTextEntry = YES;
    _pwdTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    //再次收入密码
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 138, 90, 46) SuperView:bgView LabelTag:133 LabelText:@"确认密码："];
    _SecdpwdTf = [self createTextFieldFrame:CGRectMake(95, 138, CYTMainScreen_WIDTH - 90 - 30, 46) font:FitFont(14) placeholder:@"请再次输入密码"];
    _SecurityTf.secureTextEntry = YES;
    _SecdpwdTf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    
    _userTf.keyboardType = UIKeyboardTypeNumberPad;
    _validationbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _validationbtn.frame =CGRectMake(CYTMainScreen_WIDTH - 130 , 72, 100 , 30);
    [_validationbtn setTintColor:RGBA(71, 204, 93, 1.0)];
    _validationbtn.backgroundColor = NavigationBarBackgroundColor;
    _validationbtn.layer.masksToBounds = YES;
    _validationbtn.layer.cornerRadius = 4;
    _validationbtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_validationbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    [_validationbtn addTarget:self action:@selector(validationbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_validationbtn];
    
    [bgView addSubview:_userTf];
    [bgView addSubview:_SecurityTf];
    [bgView addSubview:_pwdTf];
    [bgView addSubview:_SecdpwdTf];
    
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(20,bgView.bottom + 20, CYTMainScreen_WIDTH - 40, 40) LabelText:@"提  交" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:135 SuperView:self.view CornerRadius:5 buttonTarget:self Action:@selector(Submit)];

}

#pragma mark 验证码
- (void)validationbtnClick:(UIButton *)btn {
    _validationbtn.backgroundColor = MainBackgroundColor;
    __block int timeout = 60; //倒计时时间
    //发送验证码
    [self SendVerification];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.validationbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self.validationbtn setTitleColor:whiteColor forState:UIControlStateNormal];
                _validationbtn.backgroundColor = NavigationBarBackgroundColor;
                self.validationbtn.userInteractionEnabled = YES;
            });
        }else{
            
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.validationbtn setTitle:[NSString stringWithFormat:@"%@秒后重新发送",strTime] forState:UIControlStateNormal];
                [self.validationbtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

                self.validationbtn.userInteractionEnabled = NO;
                
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);

}

#pragma mark 发送验证码
- (void)SendVerification {
    
}

#pragma mark 返回
- (void)back:(UIButton *)Btn {
    [self dismiss];
}

#pragma mark 提交
- (void)Submit {
    
}

#pragma mark textfeild btn 的封装
- (UITextField *)createTextFieldFrame:(CGRect)frame font:(UIFont *)font placeholder:(NSString *)placeholder{
    
    UITextField *textField = [[UITextField alloc] initWithFrame:frame];
    textField.font = font;
    textField.textColor = [UIColor grayColor];
    textField.borderStyle = UITextBorderStyleNone;
    textField.placeholder = placeholder;
    return textField;
    
}

@end
