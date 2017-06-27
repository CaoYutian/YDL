//
//  VersionManager.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "VersionManager.h"
#import "VersionRequest.h"
#import "VersionAlertView.h"

@interface VersionManager ()

@property (nonatomic, strong) VersionRequest *versionRequest;

@end

@implementation VersionManager
- (void)checkVersionUpdate {
    
    NSString *updateContent = @"1、增加【圈子】，可以分享天然气信息，提问天然气问题\n2、用户可查询附近的气站，并在线购买\n3、增加【贷款、保险】可在线资讯贷款、保险信息\n4、可以更方便添加天然气记录";
    VersionAlertView *alertView = [[VersionAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本V%@", [CommonUtils getVersionCode]] message:updateContent updateBtn:@"立即更新"];
    alertView.resultIndex = ^(NSInteger index) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id1203569270"]];
    };
    [alertView showAlertView];
    
    [self.versionRequest loadDataWithHUDOnView:nil];
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request {
//    VersionResponse *versionData = (VersionResponse *)request.responseData;
//    if (versionData.needUpdate) {
//        NSString *updateContent = versionData.content.length?versionData.content:@"发现新版本，是否更新？";
//        VersionAlertView *alertView = [[VersionAlertView alloc] initWithTitle:[NSString stringWithFormat:@"发现新版本V%@", [CommonUtils getVersionCode]] message:updateContent updateBtn:@"立即更新"];
//        alertView.resultIndex = ^(NSInteger index) {
//            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://itunes.apple.com/app/id1203569270"]];
//        };
//        [alertView showAlertView];
//    }
}

- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
    
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request
{
    return @{@"type":@4,
             @"version":[CommonUtils getVersionCode]};
}

#pragma mark - getters
-(VersionRequest *)versionRequest
{
    if (!_versionRequest) {
        _versionRequest = [[VersionRequest alloc] initWithDelegate:self paramSource:self];
    }
    return _versionRequest;
}


@end
