//
//  UserInfoVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/22.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "UserInfoVC.h"

@interface UserInfoVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *TableView;
@property (nonatomic, strong) NSArray *perInfotitleArr;
@property (nonatomic, strong) NSArray *enterInfotitleArr;

@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户信息";

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.TableView];
    [self.TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
}

#pragma mark - UITableViewDataSource
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerInSection = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(30))];
    UIImageView *logoPic = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(5), FitwidthRealValue(20), FitwidthRealValue(20)) imageName:@"" SuperView:headerInSection];
    UILabel *logoTitle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(logoPic.right + FitwidthRealValue(10), 0, FitwidthRealValue(80), FitheightRealValue(30)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentLeft SuperView:headerInSection LabelTag:400 LabelText:@""];
    
    if (section) {
        logoPic.image = IMAGENAMED(@"icon_company~iphone");
        logoTitle.text = @"企业信息";
    }else {
        logoPic.image = IMAGENAMED(@"icon_account~iphone");
        logoTitle.text = @"个人信息";
    }
    
    return headerInSection;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.textLabel.font = FitFont(14);
    cell.textLabel.textColor = [UIColor grayColor];
    if (indexPath.section == 0) {
        cell.textLabel.text = self.perInfotitleArr[indexPath.row];
        if (indexPath.row == 0) {
            [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(73), FitheightRealValue(10), FitwidthRealValue(60), FitwidthRealValue(60)) imageName:@"companylogo_big" SuperView:cell.contentView];
        }
    }else {
        cell.textLabel.text = self.enterInfotitleArr[indexPath.row];
        if (indexPath.row == 0) {
            [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(73), FitheightRealValue(10), FitwidthRealValue(60), FitwidthRealValue(60)) imageName:@"companylogo_big" SuperView:cell.contentView];
        }
    }

    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row) {
        return FitheightRealValue(44);
    }
    return FitheightRealValue(80);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.perInfotitleArr.count;
    }
    return self.enterInfotitleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FitheightRealValue(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

- (UITableView *)TableView {
    if (!_TableView) {
        _TableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _TableView.delegate = self;
        _TableView.dataSource = self;
        _TableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _TableView.backgroundColor = [UIColor clearColor];
    }
    return _TableView;
}

- (NSArray *)perInfotitleArr {
    if (!_perInfotitleArr) {
        _perInfotitleArr = @[@"头像", @"用户名", @"手机号码",@"邮箱地址"];
    }
    return _perInfotitleArr;
}

- (NSArray *)enterInfotitleArr {
    if (!_enterInfotitleArr) {
        _enterInfotitleArr = @[@"企业logo",@"企业名称",@"企业性质",@"联系人",@"联系电话",@"传真",@"企业地址",@"企业简介"];
    }
    return _enterInfotitleArr;
}

@end
