//
//  SetVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "SetVC.h"
#import "ChangePasswordVC.h"
#import "CacheManager.h"
#import "LogoutRequest.h"
#import "LogInVC.h"

@interface SetVC ()
@property(nonatomic,strong)BaseTableView *settingsTableView;
@property(nonatomic,copy)NSArray *iconArray;
@property(nonatomic,copy)NSArray *titleArray;

//退出登录请求
@property(nonatomic,strong)LogoutRequest *logoutRequest;

@end

@implementation SetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;

    WS(weakSelf);
    [weakSelf.view addSubview:weakSelf.settingsTableView];
    [self.settingsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, 250)];
    UIImageView *logoImageView = [[UIImageView alloc] init];
    logoImageView.image = [UIImage imageNamed:@"companylogo_big"];
    [headerView addSubview:logoImageView];
    __weak typeof(headerView)weakHeaderView = headerView;
    [logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakHeaderView);
        make.width.height.mas_equalTo(130);
    }];
    UILabel *versionLabel = [[UILabel alloc] init];
    versionLabel.font = FONT_SMALL;
    versionLabel.textColor = [UIColor lightGrayColor];
    versionLabel.text = [NSString stringWithFormat:@"版本号%@",[CommonUtils getVersionCode]];
    [headerView addSubview:versionLabel];
    [versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.mas_equalTo(logoImageView.mas_bottom).offset(5);
    }];
    
    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.font = FONT_NORMAL;
    companyLabel.textColor = [UIColor lightGrayColor];
    companyLabel.textAlignment = NSTextAlignmentCenter;
    companyLabel.text = @"北京中旖能源科技有限公司";
    [headerView addSubview:companyLabel];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(headerView);
        make.top.mas_equalTo(versionLabel.mas_bottom).offset(10);
    }];
    
    self.settingsTableView.tableHeaderView = headerView;
    
}

-(void)loadData {
    self.iconArray = @[@"ic_settings_clean",@"ic_settings_logout"];
    self.titleArray = @[@"清理缓存",@"退出",];
    self.settingsTableView.dataArray = [self.iconArray mutableCopy];
    [self.settingsTableView reloadData];
}

#pragma mark - APIManagerParamSourceDelegate
//- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request {
//{
//    return nil;
//}

//#pragma mark - APIManagerApiCallBackDelegate
//- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
//    
//}
//
//- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
//    
//}

#pragma mark - getters
-(BaseTableView *)settingsTableView {
    if (!_settingsTableView) {
        _settingsTableView = [[BaseTableView alloc] initWithFrame:CGRectMake(0, 64, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT-64) style:UITableViewStyleGrouped];
        _settingsTableView.backgroundColor = MainBackgroundColor;
        _settingsTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _settingsTableView.clearSeperatorInset = YES;
        _settingsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        WS(weakSelf);
        _settingsTableView.cellConfigureBlock = ^ (UITableViewCell *cell, id data, NSIndexPath *indexPath) {
            if (indexPath.row == 0) {
                cell.textLabel.font = FONT(15);
                cell.imageView.image = [UIImage imageNamed:weakSelf.iconArray[indexPath.row]];
                cell.textLabel.text = weakSelf.titleArray[indexPath.row];
            }else if (indexPath.row == 1) {
                cell.textLabel.font = FONT(15);
                cell.imageView.image = [UIImage imageNamed:weakSelf.iconArray[indexPath.row]];
                cell.textLabel.text = weakSelf.titleArray[indexPath.row];
            }
            
        };
        _settingsTableView.cellSelectBlock = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            if (indexPath.row == 0) {
                
                ActionAlertView *alertView = [[ActionAlertView alloc] initWithTitle:@"清理缓存" message:[NSString stringWithFormat:@"缓存大小为%.2fMB, 确定要清理吗?", [[CacheManager sharedCacheManager] cacheFileSize]] sureBtn:@"确定" cancleBtn:@"取消"];
                alertView.resultIndex = ^(NSInteger index){
                    if (index == 2) {
                        [MBProgressHUD showLoadingHUD:@"正在清理..." duration:0.7];
                        [weakSelf performBlock:^{
                            [[CacheManager sharedCacheManager] clearCache];
                        } afterDelay:1.0];
                    }
                };
                [alertView showAlertView];
                
            }
            if (indexPath.row==1) {
                
                ActionAlertView *alertView = [[ActionAlertView alloc] initWithTitle:@"退出当前账号？" message:nil sureBtn:@"是" cancleBtn:@"否"];
                alertView.resultIndex = ^(NSInteger index){
                    if (index == 2) {
//                        [weakSelf.logoutRequest loadDataWithHUDOnView:nil];
//                        [UserManager removeLocalUserLoginInfo];
//                        [kAppDelegate loadLoginVC];
                    }
                };
                [alertView showAlertView];
            }
        };
    }
    return _settingsTableView;
}

-(LogoutRequest *)logoutRequest {
    if (!_logoutRequest) {
        _logoutRequest = [[LogoutRequest alloc] initWithDelegate:self paramSource:self];
    }
    return _logoutRequest;
}
    
@end
