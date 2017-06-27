//
//  SeparateBuyVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "SeparateBuyVC.h"
#import "MenuControl.h"
#import "MallVC.h"

@interface SeparateBuyVC ()

@property(nonatomic,strong)MenuContainer *menuContainer;

@end

@implementation SeparateBuyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    
    [self.view addSubview:self.menuContainer];
    [self.menuContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, -49, 0));
    }];
    
    switch (self.menuContainer.menuCtrl.selectedIndex) {
        case 0:

            break;
        case 1:

            break;
    }
    
}

- (MenuContainer *)menuContainer {
    if (!_menuContainer) {
        _menuContainer = [[MenuContainer alloc] init];
        _menuContainer.menuCtrl.indicatorInset = (CYTMainScreen_WIDTH/2.0-70)/2.0;
        _menuContainer.menuCtrl.indicatorColor = NavigationBarBackgroundColor;
        _menuContainer.menuCtrl.selectedTextColor = NavigationBarBackgroundColor;
        _menuContainer.menuCtrl.titles = @[@"求购中",@"历史求购"];
    }
    return _menuContainer;
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
