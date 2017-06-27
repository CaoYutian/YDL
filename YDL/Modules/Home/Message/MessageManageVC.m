//
//  MessageManageVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MessageManageVC.h"
#import "MenuControl.h"
#import "ChatViewController.h"
@interface MessageManageVC ()
@property(nonatomic,strong)MenuContainer *menuContainer;

@end

@implementation MessageManageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息管理";

    
}

- (void)SetUpUI {
    [self.view addSubview:self.menuContainer];
    [self.menuContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(CYTMainScreen_HEIGHT - 44, 0, -44, 0));
    }];
    
    switch (self.menuContainer.menuCtrl.selectedIndex) {
        case 0:
            
            break;
        case 1:
            
            break;
    }
    ChatViewController *chatVC = [[ChatViewController alloc] init];
    [chatVC showMenuViewController:self.view andIndexPath:NULL messageType:EMMessageBodyTypeImage];
    
    
//    ConversationListController *ConversationList = [[ConversationListController alloc] init];
//    [self.view addSubview:ConversationList];
    
}

- (MenuContainer *)menuContainer {
    if (!_menuContainer) {
        _menuContainer = [[MenuContainer alloc] init];
        _menuContainer.menuCtrl.indicatorInset = (CYTMainScreen_WIDTH/2.0-70)/2.0;
        _menuContainer.menuCtrl.indicatorColor = NavigationBarBackgroundColor;
        _menuContainer.menuCtrl.selectedTextColor = NavigationBarBackgroundColor;
        _menuContainer.menuCtrl.titles = @[@"最近联系人",@"系统消息"];
    }
    return _menuContainer;
}

@end
