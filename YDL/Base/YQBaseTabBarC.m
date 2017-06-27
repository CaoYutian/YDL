//
//  YQBaseTabBarC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "YQBaseTabBarC.h"
#import "YQBaseNavC.h"

#import "HomeVC.h"
#import "LargeBuyVC.h"
#import "OrderVC.h"
#import "MineVC.h"

@interface YQBaseTabBarC ()

@property (nonatomic ,assign) NSInteger indexFlag;
@property (nonatomic ,assign) NSInteger index;

@end

@implementation YQBaseTabBarC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initChildController];
    
    //修改选中颜色
    UITabBarItem *appearance = [UITabBarItem appearance];
    [appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:NavigationBarBackgroundColor} forState:UIControlStateSelected];
    
    [self.tabBar setBackgroundImage:[CYTUtiltyHelper imageWithColor:whiteColor]];
    [self.tabBar setTintColor:NavigationBarBackgroundColor];
    self.tabBar.alpha = 1.0;
    
}

- (void)initChildController{
    
    NSArray *VCs = @[[HomeVC class],  [LargeBuyVC class], [OrderVC class], [MineVC class]];
    NSArray *Images = @[@"home_index", @"home_dadan", @"home_order", @"home_mine"];
    NSArray *titles = @[@"首页", @"我的求购", @"订单", @"个人中心"];
    
    for (int i = 0; i < VCs.count; i ++) {
        
        [self setupController:[[VCs[i] alloc] init] image:Images[i] selectedImage:[NSString stringWithFormat:@"%@_s",Images[i]] title:titles[i]];
        
    }
    
}

//设置控制器
-(void)setupController:(UIViewController *)childVc image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title {
    
    UIViewController *viewVc = childVc;
    viewVc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [viewVc.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    viewVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewVc.title = title;
    YQBaseNavC *navi = [[YQBaseNavC alloc] initWithRootViewController:viewVc];
    [self addChildViewController:navi];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    self.index = [self.tabBar.items indexOfObject:item];
    if (self.indexFlag != self.index) {
        [self animationWithIndex:self.index];
    }
    
}

- (void)animationWithIndex:(NSInteger) index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    
    CABasicAnimation*pulse = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulse.timingFunction= [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulse.duration = 0.1;
    pulse.repeatCount= 1;
    pulse.autoreverses= YES;
    pulse.fromValue= [NSNumber numberWithFloat:0.7];
    pulse.toValue= [NSNumber numberWithFloat:1.3];
    [[tabbarbuttonArray[index] layer] addAnimation:pulse forKey:nil];
    
    self.indexFlag = index;
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
