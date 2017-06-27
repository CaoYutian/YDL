//
//  LogInVC.m
//  ACP
//
//  Created by 。。。 on 2017/3/30.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "LogInVC.h"
#import "LoginTranslation.h"
#import "HomeVC.h"

@interface LogInVC ()<UIViewControllerTransitioningDelegate>
@property (nonatomic, strong) UIButton *logInBtn;
@property (nonatomic, strong) LoginTranslation *login;


@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)SetUpUI {
    
    [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT) imageName:@"background.jpg" SuperView:self.view];
    
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), FitheightRealValue(18), 44, 44) NormalbgImageStr:@"icon_back" highLightbgimageStr:@"icon_back" tag:500 SuperView:self.view buttonTarget:self Action:@selector(back:) ImageEdgeInsets:UIEdgeInsetsMake(0, -18, 0, 0)];

    self.logInBtn = [[UIButton alloc] initWithFrame:CGRectMake(FitwidthRealValue(80), CYTMainScreen_HEIGHT - FitheightRealValue(120), CYTMainScreen_WIDTH - FitwidthRealValue(160), FitheightRealValue(40))];
    [self.logInBtn setTitle:@"Sign In" forState:UIControlStateNormal];
    [self.logInBtn setTitleColor:whiteColor forState:UIControlStateNormal];
    self.logInBtn.backgroundColor = NavigationBarBackgroundColor;
    self.logInBtn.layer.cornerRadius = FitheightRealValue(20);
    self.logInBtn.layer.masksToBounds = YES;
    [self.logInBtn addTarget:self action:@selector(logInAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.logInBtn];
    
}

- (void)logInAction:(UIButton *)Btn {
    
    HomeVC *homeVc = [[HomeVC alloc] initWithNibName:nil bundle:nil];
    homeVc.transitioningDelegate = self;
    [self presentVc:homeVc];
    
    [self performSelector:@selector(finishTransition) withObject:nil afterDelay:1.5];
}

- (void)finishTransition {
    [self.login stopAnimation];
}

- (void)back:(UIButton *)btn {
    
    [self dismiss];
    
}

#pragma mark UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.login.reverse = YES;
    return self.login;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.login.reverse = NO;
    return self.login;
}

- (LoginTranslation *)login{
    if (!_login) {
        _login = [[LoginTranslation alloc] initWithView:self.logInBtn];
    }
    return _login;
}

@end
