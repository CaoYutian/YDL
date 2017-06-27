
//
//  LargeBuyVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "LargeBuyVC.h"
#import "LargeTitleScrollView.h"

@interface LargeBuyVC ()

@property (nonatomic, strong) LargeTitleScrollView *headerView;   //头部大类View

@end

@implementation LargeBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;

    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titles = @[@"全部",@"报价中",@"议价中",@"部分成交",@"已完成",@"已取消"];
    self.headerView= [[LargeTitleScrollView alloc] initWithFrame:CGRectMake(0, 64, CYTMainScreen_WIDTH, FitheightRealValue(40)) titles:titles];
    __weak typeof(LargeBuyVC *) weakSelf = self;
    weakSelf.headerView.selectedAtIndex = ^(int index){
        //切换大类

    };
    [self.view addSubview:self.headerView];
    
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
