//
//  RegisterVC.m
//  YDL
//
//  Created by Sunshine on 2017/6/29.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "RegisterVC.h"

@interface RegisterVC ()

@property (nonatomic ,strong) UITextField *userTf;
@property (nonatomic ,strong) UITextField *pwdTf;
@property (nonatomic ,strong) UITextField *SecurityTf;
@property (nonatomic ,strong) UILabel *userLb;
@property (nonatomic ,strong) UILabel *pwdLb;
@property (nonatomic ,strong) UILabel *SecurityLb;
@property (nonatomic ,strong) UILabel *InvitationLb;
@property (nonatomic ,strong) UITextField *InvitationTf;//邀请码
@property (nonatomic ,retain) UIButton *validationbtn;  //验证按钮
@property (nonatomic ,strong) UIButton *RegistBtn;      //注册按钮

@property (nonatomic ,strong) UIButton *selectBtn;

@property(nonatomic ,copy) NSString * name;    //用户名 即手机号
@property(nonatomic ,copy) NSString * password;//密码

@end

@implementation RegisterVC{
    UIView *bgView;//textFeild下边的背景
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)SetUpUI {
    [CYTUtiltyHelper createImageViewWithFrame:self.view.bounds imageName:@"background~iphone" SuperView:self.view];
    
    //    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(80, 20, CYTMainScreen_WIDTH - 160, 44) LabelFont:FitFont(18) LabelTextColor:whiteColor LabelTextAlignment:NSTextAlignmentCenter SuperView:self.view LabelTag:100 LabelText:@"找回密码"];
    
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), FitheightRealValue(18), 44, 44) NormalbgImageStr:@"icon_back" highLightbgimageStr:@"icon_back" tag:500 SuperView:self.view buttonTarget:self Action:@selector(backClick) ImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 0)];
    
    bgView = [[UIView alloc] initWithFrame:CGRectMake(15, 74, CYTMainScreen_WIDTH - 30, 184)];
    bgView.layer.cornerRadius = 3.0;
    bgView.backgroundColor = whiteColor;
    [self.view addSubview:bgView];
    
    _userLb = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 0, 80, 46) SuperView:bgView LabelTag:130 LabelText:@"手机号："];
    _userTf = [self createTextFieldFrame:CGRectMake(80, 0, CYTMainScreen_WIDTH - 80 - 30 - 110, 46) font:[UIFont systemFontOfSize:14] placeholder:@"请输入手机号"];
    
    _SecurityTf.keyboardType = UIKeyboardTypePhonePad;
    _pwdLb = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 46, 80, 46) SuperView:bgView LabelTag:132   LabelText:@"密  码："];
    _pwdTf.secureTextEntry = YES;
    _pwdTf = [self createTextFieldFrame:CGRectMake(80, 46, CYTMainScreen_WIDTH - 80 - 30, 46) font:[UIFont systemFontOfSize:14] placeholder:@"请输入6位以上且必须含有数字和字母"];
    
    _SecurityLb = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 92, 80, 46) SuperView:bgView LabelTag:131 LabelText:@"验证码："];
    _SecurityTf = [self createTextFieldFrame:CGRectMake(80, 92, CYTMainScreen_WIDTH - 80 - 30, 46) font:[UIFont systemFontOfSize:14] placeholder:@"请输入验证码"];
    
    _userTf.keyboardType = UIKeyboardTypeNumberPad;
    _validationbtn =[UIButton buttonWithType:UIButtonTypeCustom];
    _validationbtn.frame =CGRectMake(CYTMainScreen_WIDTH - 130 , 82, 100 , 30);
    [_validationbtn setTintColor:RGBA(71, 204, 93, 1.0)];
    _validationbtn.backgroundColor = NavigationBarBackgroundColor;
    _validationbtn.layer.masksToBounds = YES;
    _validationbtn.layer.cornerRadius = 4;
    _validationbtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
    [_validationbtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    _InvitationLb = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(15, 138, 80, 46) SuperView:bgView LabelTag:133 LabelText:@"邀请码："];
    _InvitationTf = [self createTextFieldFrame:CGRectMake(80, 138, CYTMainScreen_WIDTH - 80 - 30, 46) font:[UIFont systemFontOfSize:14] placeholder:@"请输入邀请码（可不填）"];
    
    [_validationbtn addTarget:self action:@selector(validationbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_validationbtn];
    
    [bgView addSubview:_userTf];
    [bgView addSubview:_SecurityTf];
    [bgView addSubview:_pwdTf];
    [bgView addSubview:_InvitationTf];
    
    //选中的Btn
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(20, bgView.origin.y + bgView.frame.size.height + 30, 30, 30);
    [_selectBtn setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
    [_selectBtn setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
    _selectBtn.selected = YES;
    [_selectBtn addTarget:self action:@selector(ButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_selectBtn];
    
    //我已阅读并同意
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(50, bgView.origin.y + bgView.frame.size.height + 10, 90, 30) LabelFont:[UIFont systemFontOfSize:12] LabelTextColor:RGBA(120, 120, 120, 1.0) LabelTextAlignment:NSTextAlignmentCenter SuperView:self.view LabelTag:150 LabelText:@"我已阅读并同意"];
    UILabel *ProtocolLb = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(140, bgView.origin.y + bgView.frame.size.height + 10, 80, 30) LabelFont:[UIFont systemFontOfSize:12] LabelTextColor:MainRedColor LabelTextAlignment:NSTextAlignmentCenter SuperView:self.view LabelTag:151 LabelText:@"《注册协议》"];
    ProtocolLb.userInteractionEnabled = YES;
    UITapGestureRecognizer *ProtocolGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ProtocolClick:)];
    [ProtocolLb addGestureRecognizer:ProtocolGesture];
    
    _RegistBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(20, bgView.origin.y + bgView.frame.size.height + 50, CYTMainScreen_WIDTH - FitwidthRealValue(40), 40) tag:140 SuperView:self.view buttonTarget:self Action:@selector(RegistClick:)];
    [_RegistBtn setTitle:@"注册" forState:UIControlStateNormal];
    _RegistBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [_RegistBtn setTitleColor:whiteColor forState:UIControlStateNormal];
    _RegistBtn.layer.cornerRadius = 5;
    _RegistBtn.layer.masksToBounds = YES;
    _RegistBtn.backgroundColor = NavigationBarBackgroundColor;
}

#pragma mark 注册协议
-(void)ProtocolClick:(UITapGestureRecognizer *)tap{

}

- (void)ButtonClick:(UIButton *)button {
    button.selected = !button.selected;
    if ([button isSelected]) {
        _RegistBtn.backgroundColor = NavigationBarBackgroundColor;
    }else{
        _RegistBtn.backgroundColor = [UIColor lightGrayColor];
    }
}

-(void)RegistClick:(UIButton *)btn{
    
    if( !_selectBtn.isSelected){
        _RegistBtn.userInteractionEnabled = NO;
        [CustomHUD createShowContent:@"您未同意注册协议哦！" hiddenTime:1.5];
    }
    
    if (_userTf.text.length == 0) {
        [CustomHUD createShowContent:@"手机号不能为空" hiddenTime:1.5];
    }else{
        //判断是否是手机号
        if ([_userTf.text isValidateMobile]) {
            //判断密码
            [self checkPassWord];
        }else{
            [CustomHUD createShowContent:@"请输入正确手机号" hiddenTime:1.5];
        }
    }
    _RegistBtn.userInteractionEnabled = YES;
}

- (void)checkPassWord{
    if ([_pwdTf.text judgePassWordLegal:_pwdTf.text]) {
        self.password = _pwdTf.text;
        //判断验证码
        [self SendRegist];
    }else{
        [CustomHUD createShowContent:@"密码长度为6到15位且必须含有字母和数字" hiddenTime:1.5];
    }
}

- (void)validationbtnClick:(UIButton *)button{
    if ([_userTf.text isValidateMobile]) {
        
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
        
    }else {
        [CustomHUD createShowContent:@"请输入手机号" hiddenTime:1.0];
    }
    
}

#pragma mark 验证码
- (void)SendVerification{
    
}

#pragma mark 获取语音验证码
- (void)GetVoiceClick{
    
    if ([_userTf.text isValidateMobile]) {
        
    }else {
        [CustomHUD createShowContent:@"请输入手机号" hiddenTime:1.0];
    }
    
}

#pragma mark 注册
- (void)SendRegist{

}

#pragma mark 返回
- (void)backClick {
    [self dismiss];
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

-(UIButton *)createButtonFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)color font:(UIFont *)font target:(id)target action:(SEL)action{
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=frame;
    
    if (font){
        btn.titleLabel.font=font;
    }
    
    if (title){
        [btn setTitle:title forState:UIControlStateNormal];
    }
    if (color){
        [btn setTitleColor:color forState:UIControlStateNormal];
    }
    if (target&&action){
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    return btn;
}

@end
