//
//  YQBaseNavC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "YQBaseNavC.h"
#import "UIBarButtonItem+Addition.h"
@interface YQBaseNavC ()<UIGestureRecognizerDelegate>
@property(nonatomic, strong) NSMutableArray *blackList;

@end

@implementation YQBaseNavC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  获取事件处理对象.以便自己添加的手势可以把事件处理委托给它.
    id target = self.interactivePopGestureRecognizer.delegate;
    //  获取委托对象里的处理方法.
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    //  获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    //  创建pan手势 作用范围是全屏
    UIPanGestureRecognizer * fullScreenGes = [[UIPanGestureRecognizer alloc]initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    [self.interactivePopGestureRecognizer setEnabled:NO];
}

+ (void)initialize{ //设置导航条
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setTitleTextAttributes:@{NSFontAttributeName : FitFont(18),NSForegroundColorAttributeName:whiteColor}];
}

//拦截push进来的控制器
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = YES;
            
            UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
            [btn setImage:[UIImage imageNamed:@"icon_back"] forState:UIControlStateNormal];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -18, 0, 0);
            btn.tintColor = [UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f];
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
            [btn addTarget:self action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
            viewController.navigationItem.leftBarButtonItem = leftItem;
            
        }else{
            viewController.hidesBottomBarWhenPushed = NO;
            
            viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTitle:@"" tintColor:[UIColor colorWithRed:0.42f green:0.33f blue:0.27f alpha:1.00f] touchBlock:nil];

        }
    }
    //如果在控制器有设置，就可以让后面设置的按钮可以覆盖它
    [super pushViewController:viewController animated:animated];
    
}

-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (BOOL)prefersStatusBarHidden {
    return NO; //返回NO表示要显示，返回YES将hiden
}

#pragma mark - Public
- (void)addFullScreenPopBlackListItem:(UIViewController *)viewController {
    if (!viewController) {
        return ;
    }
    [self.blackList addObject:viewController];
}

- (void)removeFromFullScreenPopBlackList:(UIViewController *)viewController {
    for (UIViewController *vc in self.blackList) {
        if (vc == viewController) {
            [self.blackList removeObject:vc];
        }
    }
}

#pragma mark - UIGestureRecognizerDelegate
//  防止导航控制器只有一个rootViewcontroller时触发手势
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 根据具体控制器对象决定是否开启全屏右滑返回
    for (UIViewController *viewController in self.blackList) {
        if ([self topViewController] == viewController) {
            return NO;
        }
    }
    
    // 解决右滑和UITableView左滑删除的冲突
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    
    return self.childViewControllers.count == 1 ? NO : YES;
}

#pragma mark - Lazy load
- (NSMutableArray *)blackList {
    if (!_blackList) {
        _blackList = [NSMutableArray array];
    }
    return _blackList;
}

@end
