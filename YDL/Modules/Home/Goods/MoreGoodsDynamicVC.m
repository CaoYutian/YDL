//
//  MoreGoodsDynamicVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MoreGoodsDynamicVC.h"

@interface MoreGoodsDynamicVC ()

@end

@implementation MoreGoodsDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)SetUpUI {
    self.navigationItem.titleView = self.searchBar;
    self.messageBtn.hidden = NO;
    
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
