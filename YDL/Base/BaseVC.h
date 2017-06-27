//
//  BaseVC.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableView.h"

@interface BaseVC : UIViewController<UISearchBarDelegate>

@property (nonatomic, strong) UIScrollView *contentView;
@property (nonatomic, strong) UIButton *messageBtn;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) MJRefreshNormalHeader *comHeader;
@property (nonatomic, strong) MJRefreshAutoNormalFooter   *comFooter;
@property (nonatomic, strong) PageAPIRequest              *pageRequest;


//创建loadSubViews
- (void)SetUpUI;
//加载数据
-(void)loadData;
//消息
- (void)messageAction;

- (void)pop;

- (void)popToRootVc;

- (void)popToVc:(UIViewController *)vc;

- (void)dismiss;

- (void)dismissWithCompletion:(void(^)())completion;

- (void)presentVc:(UIViewController *)vc;

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion;

- (void)pushVc:(UIViewController *)vc;

- (void)removeChildVc:(UIViewController *)childVc;

- (void)addChildVc:(UIViewController *)childVc;

@end
