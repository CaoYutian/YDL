//
//  AddressVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AddressVC.h"
#import "ApplyAddressVC.h"

@interface AddressVC ()

@end

@implementation AddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的卸气点";

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;

    //发布求购
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, CYTMainScreen_HEIGHT - FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelText:@"添加卸气点" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:130 SuperView:self.view buttonTarget:self Action:@selector(addAddressAction:)];
}

- (void)addAddressAction:(UIButton *)btn {
    [self pushVc:[ApplyAddressVC new]];
}

@end
