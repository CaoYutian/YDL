//
//  QCDetailVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/22.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QCDetailVC.h"

@interface QCDetailVC ()<ActionSheetViewDelegate>

@property (nonatomic, strong) UIImageView *topPic;
@property (nonatomic, strong) UIImageView *bottomPic;
@property (nonatomic, strong) UILabel *photoRequire;
@property (nonatomic, strong) UILabel *requireOne;
@property (nonatomic, strong) UILabel *requireTwo;

@property (nonatomic, strong) UITextField *businessTf;
@property (nonatomic, strong) UILabel *businessDetail;

@property (nonatomic, strong) UILabel *topPicTitle;
@property (nonatomic, strong) UILabel *bottomPicTitle;

@property (nonatomic, strong) UIButton *bottomBtn;

@end

@implementation QCDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)SetUpUI {
    
    if (self.QCFileType == groupCode || self.QCFileType == taxRegCF ||self.QCFileType == openAccountLC ||
        self.QCFileType == lngBusinessLC ||self.QCFileType == safetyProdTLC) {
        [self onePicAndrequire];
    }else if (self.QCFileType == businessLC) {
        [self onePicAndBusiness];
    }else {
        [self twoPic];
    }
    
}

#pragma mark 一张图和照片要求
- (void)onePicAndrequire {
    
    self.topPic = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake((CYTMainScreen_WIDTH - FitwidthRealValue(60)) / 2, FitheightRealValue(40) + 64, FitwidthRealValue(80), FitheightRealValue(80)) imageName:@"photo" SuperView:self.view];
    WS(weakSelf);
    [self.topPic setTapActionWithBlock:^{
        [weakSelf chooseUplodOfPic];
    }];
    
    self.photoRequire = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.topPic.bottom + FitheightRealValue(20), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(30)) LabelFontSize:16 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:410 LabelText:@"照片要求"];
    self.requireOne = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.photoRequire.bottom, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(20)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:411 LabelText:@"1.必须为清晰完整原件照片；"];
    
    self.requireTwo = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.requireOne.bottom, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(20)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:412 LabelText:@"2.支持jpg/bmp/png格式，最大不超过2M；"];
    
    self.bottomBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), self.requireTwo.bottom + FitheightRealValue(40), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelText:@"确认" TextFont:FitFont(16) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:413 SuperView:self.view CornerRadius:3 buttonTarget:self Action:@selector(SureAction)];

}

#pragma mark 一张图和企业名称
- (void)onePicAndBusiness {
    self.topPic = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake((CYTMainScreen_WIDTH - FitwidthRealValue(60)) / 2, FitheightRealValue(40) + 64, FitwidthRealValue(80), FitheightRealValue(80)) imageName:@"photo" SuperView:self.view];
    WS(weakSelf);
    [self.topPic setTapActionWithBlock:^{
        [weakSelf chooseUplodOfPic];
    }];
    
    self.photoRequire = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.topPic.bottom + FitheightRealValue(20), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(30)) LabelFontSize:16 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:414 LabelText:@"企业名称修改申请:"];
    
    self.businessTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(FitwidthRealValue(13), self.photoRequire.bottom + FitheightRealValue(5), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) font:FitFont(14) placeholder:@"企业名称" TextfiledTag:415 Delegate:self CornerRadius:3 SuperView:self.view];
    
    self.businessDetail = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.businessTf.bottom + FitheightRealValue(5), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(20)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:416 LabelText:@"如需修改企业名称，请在此进行操作；"];
    
    self.bottomBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), self.businessDetail.bottom + FitheightRealValue(40), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelText:@"确认" TextFont:FitFont(16) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:417 SuperView:self.view CornerRadius:3 buttonTarget:self Action:@selector(SureAction)];
    
}

#pragma mark 两张图片
- (void)twoPic {
    
    self.topPicTitle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(5), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(20)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:418 LabelText:@"委托书"];
    
    self.topPic = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake((CYTMainScreen_WIDTH - FitwidthRealValue(60)) / 2, FitheightRealValue(40) + 64, FitwidthRealValue(80), FitheightRealValue(80)) imageName:@"photo" SuperView:self.view];
    WS(weakSelf);
    [self.topPic setTapActionWithBlock:^{
        [weakSelf chooseUplodOfPic];
    }];
    
    self.bottomPicTitle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.topPic.bottom + FitheightRealValue(40), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(20)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:419 LabelText:@"委托书"];
    
    self.bottomPic = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake((CYTMainScreen_WIDTH - FitwidthRealValue(60)) / 2, self.bottomPicTitle.bottom + FitheightRealValue(5), FitwidthRealValue(80), FitheightRealValue(80)) imageName:@"photo" SuperView:self.view];
    [self.topPic setTapActionWithBlock:^{
        [weakSelf chooseUplodOfPic];
    }];

    self.bottomBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), self.bottomPic.bottom + FitheightRealValue(40), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelText:@"确认" TextFont:FitFont(16) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:420 SuperView:self.view CornerRadius:3 buttonTarget:self Action:@selector(SureAction)];

    
}

#pragma mark 确认
- (void)SureAction {
    
}

#pragma mark 上传图片
- (void)chooseUplodOfPic {
    ActionSheetView *alertSheetView = [[ActionSheetView alloc] initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"拍照", @"从手机相册选择"] actionSheetBlock:^(NSInteger index) {
        if (index == 0) {

        }else if (index == 1) {

        }
    }];
    
    //弹出视图
    [alertSheetView show];
}

@end
