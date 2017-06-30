//
//  BaseVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"
#import "MessageManageVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIView setAnimationsEnabled:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 在自定义leftBarButtonItem后添加下面代码就可以完美解决返回手势无效的情况
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    NSArray *gestureArray = self.navigationController.view.gestureRecognizers;
    //当是侧滑手势的时候设置scrollview需要此手势失效才生效即可
    for (UIGestureRecognizer *gesture in gestureArray) {
        if ([gesture isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
            
            for (UIView *sub in self.view.subviews) {
                if ([sub isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *sc = (UIScrollView *)sub;
                    [sc.panGestureRecognizer requireGestureRecognizerToFail:gesture];
                }
            }
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = MainBackgroundColor;
    self.navBarTintColor = NavigationBarBackgroundColor;
    
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH * 0.7, 44)];
    self.searchBar.backgroundImage = [[UIImage alloc] init];
    self.searchBar.delegate = self;
    self.searchBar.placeholder = SearchBarPlaceholder;
    
    self.messageBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, 0, 44, 44) NormalbgImageStr:@"common_msg" highLightbgimageStr:@"common_msg" tag:100 SuperView:self.view buttonTarget:self Action:@selector(messageAction)];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.messageBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    self.messageBtn.hidden = YES;
    
    [self SetUpUI];
    [self loadData];
}

#pragma mark 创建UI
- (void)SetUpUI {
    [self.view addSubview:self.contentView];
    [self layoutNavigationBar];
}

#pragma mark 加载数据
-(void)loadData {
    
}

#pragma mark 消息
- (void)messageAction {
    [self pushVc:[MessageManageVC new]];
}

- (void)layoutNavigationBar {
    
    WS(weakSelf);
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];

}

- (void)pop {
    if (self.navigationController == nil) return ;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popToRootVc {
    if (self.navigationController == nil) return ;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)popToVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    [self.navigationController popToViewController:vc animated:YES];
}

- (void)dismiss {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissWithCompletion:(void(^)())completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)presentVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentVc:vc completion:nil];
}

- (void)presentVc:(UIViewController *)vc completion:(void (^)(void))completion {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    [self presentViewController:vc animated:YES completion:completion];
}

- (void)pushVc:(UIViewController *)vc {
    if ([vc isKindOfClass:[UIViewController class]] == NO) return ;
    if (self.navigationController == nil) return ;
    if (vc.hidesBottomBarWhenPushed == NO) {
        vc.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)removeChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc.view removeFromSuperview];
    [childVc willMoveToParentViewController:nil];
    [childVc removeFromParentViewController];
}

- (void)addChildVc:(UIViewController *)childVc {
    if ([childVc isKindOfClass:[UIViewController class]] == NO) {
        return ;
    }
    [childVc willMoveToParentViewController:self];
    [self addChildViewController:childVc];
    [self.view addSubview:childVc.view];
    childVc.view.frame = self.view.bounds;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.scrollEnabled = NO;
        _contentView.backgroundColor = whiteColor;
        _contentView.scrollsToTop = NO;
    }
    return _contentView;
}

- (MJRefreshNormalHeader *)comHeader {
    if (!_comHeader) {
        __weak typeof(self) weakSelf = self;
        _comHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
        [_comHeader setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [_comHeader setTitle:@"释放更新" forState:MJRefreshStatePulling];
        [_comHeader setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        _comHeader.stateLabel.font = FONT_NORMAL;
        _comHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    return _comHeader;
}

- (MJRefreshAutoNormalFooter *)comFooter {
    if (!_comFooter) {
        __weak typeof(self) weakSelf = self;
        _comFooter = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [weakSelf.pageRequest loadDataWithHUDOnView:nil];
        }];
        [_comFooter setTitle:@"点击或上拉刷新" forState:MJRefreshStateIdle];
        [_comFooter setTitle:@"加载中，请稍后..." forState:MJRefreshStateRefreshing];
        [_comFooter setTitle:@"没有数据了" forState:MJRefreshStateNoMoreData];
        _comFooter.stateLabel.font = FONT_NORMAL;
    }
    return _comFooter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
