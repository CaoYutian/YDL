//
//  PurchaseAgreementVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "PurchaseAgreementVC.h"

@interface PurchaseAgreementVC ()<LLNoDataViewTouchDelegate>

@end

@implementation PurchaseAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"采购协议";
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;

    //可视重新加载按钮
    LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:self.view.bounds LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
    dataView.delegate = self;
    
    //实例一次，再次修改提示文本信息
    dataView.tipLabel.text = @"抱歉，该用户暂无数据！";
    [self.view addSubview:dataView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
