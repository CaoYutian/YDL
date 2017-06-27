//
//  MyInvoiceVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MyInvoiceVC.h"
#import "AddInvoiceVC.h"

@interface MyInvoiceVC ()

@end

@implementation MyInvoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的发票";

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;

    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, CYTMainScreen_HEIGHT - FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelText:@"添加发票" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor orangeColor] highLightBgColor:[UIColor orangeColor] tag:500 SuperView:self.view buttonTarget:self Action:@selector(addInvoiceAction:)];
    
}

- (void)addInvoiceAction:(UIButton *)Btn {
    ActionAlertView *alertView = [[ActionAlertView alloc] initWithTitle:@"是否要添加发票？" message:nil sureBtn:@"是" cancleBtn:@"否"];
    
    alertView.resultIndex = ^(NSInteger index){
        if (index == 2) {
            [self pushVc:[AddInvoiceVC new]];
        }
    };
    
    [alertView showAlertView];
}

@end
