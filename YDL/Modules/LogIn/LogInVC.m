//
//  LogInVC.m
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "LogInVC.h"
#import "logInView.h"

#import "ForgotPwVC.h"
#import "RegisterVC.h"
@interface LogInVC ()


@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [self resignFirstResponder];
}

- (void)SetUpUI {
    
    logInView *logInV = [[logInView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:logInV];
    
    [logInV setClickBlock:^(NSString *accountText, NSString *passwordText) {
        [self logInClickaccount:accountText password:passwordText];
    }];
    
    [logInV callBack:^(NSInteger index) {
        switch (index) {
            case 1:
                [self registerAction];
                break;
                
            case 2:
                [self forgotPwAction];
                break;
                
            case 3:
                [self backClick];
                break;
        }
    }];
}

#pragma mark 登录
- (void)logInClickaccount:(NSString *)account password:(NSString *)password {
    NSLog(@"点击了登录按钮accountText = %@   passwordText = %@",account,password);
}

#pragma mark 注册
- (void)registerAction {
    [self presentVc:[RegisterVC new]];
}

#pragma mark 忘记密码
- (void)forgotPwAction {
    [self presentVc:[ForgotPwVC new]];
}

#pragma mark 返回
- (void)backClick {
    [self dismiss];
}

@end
