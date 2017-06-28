//
//  QiZhanVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QiZhanVC.h"
#import "MallVC.h"
#import "QiuGouVC.h"

#import "QiZhanFooterView.h"
@interface QiZhanVC ()<LLNoDataViewTouchDelegate>

@property (nonatomic, strong) UISegmentedControl *segmentController;

@end

@implementation QiZhanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的气站";
}

- (void)SetUpUI {
    self.segmentController = [[UISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, FitwidthRealValue(60), FitheightRealValue(30))];
    [self.segmentController insertSegmentWithTitle:@"  气罐状态" atIndex:0 animated:YES];
    [self.segmentController insertSegmentWithTitle:@"订单分析  " atIndex:1 animated:YES];
    self.segmentController.tintColor = whiteColor;
    self.segmentController.selectedSegmentIndex = 0;
    self.segmentController.layer.cornerRadius = self.segmentController.frame.size.height/2;
    self.segmentController.layer.masksToBounds = YES;
    self.segmentController.layer.borderWidth = 1.0;
    self.segmentController.layer.borderColor = [whiteColor CGColor];
    
    [self.segmentController addTarget:self action:@selector(segmentValuechanged:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segmentController;
    [self segmentValuechanged:self.segmentController];

    //可视重新加载按钮
    LLNoDataView *dataView = [[LLNoDataView alloc] initReloadBtnWithFrame:self.view.bounds LLNoDataViewType:LLNoInternet description:@"" reloadBtnTitle:@"重新加载"];
    dataView.delegate = self;
    
    //实例一次，再次修改提示文本信息
    dataView.tipLabel.text = @"抱歉，该用户暂无数据！";
    [self.view addSubview:dataView];
    
    QiZhanFooterView *footView = [[QiZhanFooterView alloc] initWithFrame:CGRectMake(0, CYTMainScreen_HEIGHT - 49, CYTMainScreen_WIDTH, 49)];
    [self.view addSubview:footView];
    [footView functionChooseCallBack:^(NSInteger choose) {
        switch (choose) {
            case 0:
                [self buyNowAction];
                break;
                
            case 1:
                [self separateBuyAction];
                break;
                
            case 2:
                [self largeBuyAction];
                break;
        }
    }];
}

#pragma mark 切换分段选择器
- (void)segmentValuechanged:(UISegmentedControl *)segment {
    
}

#pragma mark 立即采购
- (void)buyNowAction {
    [self pushVc:[MallVC new]];
}

#pragma mark 散单求购
- (void)separateBuyAction {
    QiuGouVC *QiuGou = [[QiuGouVC alloc] init];
    QiuGou.BuyType = separateBuy;
    [self pushVc:QiuGou];
}

#pragma mark 大单求购
- (void)largeBuyAction {
    QiuGouVC *QiuGou = [[QiuGouVC alloc] init];
    QiuGou.BuyType = largeBuy;
    [self pushVc:QiuGou];
}

@end
