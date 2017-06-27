//
//  ChangePasswordVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ChangePasswordVC.h"

@interface ChangePasswordVC ()

//原密码
@property(nonatomic,strong)UITextField *originalpasswordField;
//新密码
@property(nonatomic,strong)UITextField *newpasswordField;
//重复密码
@property(nonatomic,strong)UITextField *repeatPasswordField;

@end

@implementation ChangePasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)SetUpUI {
    self.title = @"修改密码";
    
    WS(weakSelf);
    UIView *topLine = [[UIView alloc] init];
    topLine.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.equalTo(weakSelf.view);
        make.height.mas_equalTo(15);
    }];
    
    [self.contentView addSubview:self.originalpasswordField];
    [self.contentView addSubview:self.newpasswordField];
    [self.contentView addSubview:self.repeatPasswordField];
    
    [self.originalpasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.equalTo(weakSelf.view).offset(-12);
        make.top.mas_equalTo(topLine.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.newpasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.equalTo(weakSelf.view).offset(-12);
        make.top.mas_equalTo(weakSelf.originalpasswordField.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [self.repeatPasswordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.equalTo(weakSelf.view).offset(-12);
        make.top.mas_equalTo(weakSelf.newpasswordField.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    //确定按钮
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.clipsToBounds = YES;
    confirmBtn.layer.cornerRadius = 3;
    [confirmBtn setBackgroundImage:[UIImage createImageWithColor:MainBackgroundColor] forState:UIControlStateNormal];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:whiteColor forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = FONT_NORMAL;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.equalTo(weakSelf.view).offset(-20);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(weakSelf.repeatPasswordField.mas_bottom).offset(10);
    }];
}

#pragma mark - actions
-(void)confirmAction
{
//    if (![CheckUtils checkPassword:self.originalpasswordField.text]) {
//        [MBProgressHUD showMsgHUD:@"请输入6-18位的原密码"];
//        return;
//    }
//    if (![CheckUtils checkPassword:self.newpasswordField.text]) {
//        [MBProgressHUD showMsgHUD:@"请输入6-18位的新密码"];
//        return;
//    }
//    if (![self.newpasswordField.text isEqualToString:self.repeatPasswordField.text]) {
//        [MBProgressHUD showMsgHUD:@"两次输入的密码不一致"];
//        return;
//    }
//    [MBProgressHUD showMsgHUD:@"密码修改成功" customImage:IMAGE_HUD_SUCCESS];
//    [self performBlock:^{
//        [AppCommon popViewControllerAnimated:YES];
//    } afterDelay:0.7];
}

#pragma mark - getters
-(UITextField *)originalpasswordField
{
//    if (!_originalpasswordField) {
//        _originalpasswordField = [[UITextField alloc] init];
//        [_originalpasswordField setLeftTitle:@"原密码：" font:FONT_NORMAL textColor:COLOR_TEXT_LIGHT];
//        _originalpasswordField.placeholder = @"输入原密码";
//        _originalpasswordField.font = FONT_NORMAL;
//        _originalpasswordField.secureTextEntry = YES;
//        [_originalpasswordField addBottomLine];
//    }
    return _originalpasswordField;
}

-(UITextField *)newpasswordField
{
//    if (!_newpasswordField) {
//        _newpasswordField = [[UITextField alloc] init];
//        [_newpasswordField setLeftTitle:@"新密码：" font:FONT_NORMAL textColor:COLOR_TEXT_LIGHT];
//        _newpasswordField.placeholder = @"输入6-18位的新密码";
//        _newpasswordField.font = FONT_NORMAL;
//        _newpasswordField.secureTextEntry = YES;
//        [_newpasswordField addBottomLine];
//    }
    return _newpasswordField;
}

-(UITextField *)repeatPasswordField
{
//    if (!_repeatPasswordField) {
//        _repeatPasswordField = [[UITextField alloc] init];
//        [_repeatPasswordField setLeftTitle:@"新密码：" font:FONT_NORMAL textColor:COLOR_TEXT_LIGHT];
//        _repeatPasswordField.placeholder = @"请输入重复密码";
//        _repeatPasswordField.font = FONT_NORMAL;
//        _repeatPasswordField.secureTextEntry = YES;
//        [_repeatPasswordField addBottomLine];
//    }
    return _repeatPasswordField;
}
@end
