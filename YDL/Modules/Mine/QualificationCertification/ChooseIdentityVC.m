//
//  ChooseIdentityVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/22.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ChooseIdentityVC.h"
#import "QualificationCertificationVC.h"
#import "PopUpPickerView.h"

@interface ChooseIdentityVC ()<UITextFieldDelegate,PopUpMenuDelegate,PopUpMenuDataSource,ActionSheetViewDelegate>
@property (nonatomic, strong) UITextField *chooseIdentityTf;
@property (nonatomic, strong) PopUpPickerView *ChooseIdPickerView;
@property (nonatomic, strong) NSArray *IdentityArr;


@end

@implementation ChooseIdentityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择身份";
    
}

- (void)SetUpUI {
    
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 64, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelFont:FitFont(14) LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:410 LabelText:@"您当前的身份为：普通会员"];
    
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(40) + 64, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelFont:FitFont(14) LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:411 LabelText:@"请选择你要申请的资质身份"];
    
    self.chooseIdentityTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(90) + 64, CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) font:FitFont(14) placeholder:@"请选择你要申请的资质身份" TextfiledTag:412 SuperView:self.view];
    self.chooseIdentityTf.textAlignment = NSTextAlignmentCenter;
    self.chooseIdentityTf.textColor = blackColor;
    self.chooseIdentityTf.delegate = self;
    self.chooseIdentityTf.borderStyle = UITextBorderStyleRoundedRect;
    
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(FitwidthRealValue(13), self.chooseIdentityTf.bottom + FitheightRealValue(10), CYTMainScreen_WIDTH - FitwidthRealValue(26), FitheightRealValue(40)) LabelText:@"下一步" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:413 SuperView:self.view CornerRadius:3 buttonTarget:self Action:@selector(nextAction)];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self.ChooseIdPickerView show];
    return NO;
}

- (void)nextAction {
    if (self.chooseIdentityTf.text.length) {
        [self pushVc:[QualificationCertificationVC new]];
    }else {
        [CustomHUD createShowContent:@"请选择身份" hiddenTime:2];
    }
}

#pragma mark - QMPopUpMenuDataSource
- (NSInteger)numberOfComponentsInPickerView:(PopUpPickerView *)popUpMenu {
    return 1;
}

- (NSInteger)popUpMenu:(PopUpPickerView *)popUpMenu numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        if (popUpMenu==self.ChooseIdPickerView) {
            return self.IdentityArr.count;
        }
    }
    return 0;
}

#pragma mark - QMPopUpMenuDelegate
- (NSString *)popUpMenu:(PopUpPickerView *)popUpMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==0) {
        if (popUpMenu==self.ChooseIdPickerView) {
            return self.IdentityArr[row];
        }
    }
    return @"";
}

- (void)popUpMenu:(PopUpPickerView *)popUpMenu didSelectRowArray:(NSArray *)rowArray {
    if (popUpMenu==self.ChooseIdPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.chooseIdentityTf setText:self.IdentityArr[index]];
    }
}

- (NSArray *)IdentityArr {
    if (!_IdentityArr) {
        _IdentityArr = @[@"买家",@"卖家",@"买卖家"];
    }
    return _IdentityArr;
}

- (PopUpPickerView *)ChooseIdPickerView {
    if (!_ChooseIdPickerView) {
        _ChooseIdPickerView = [[PopUpPickerView alloc] init];
        _ChooseIdPickerView.delegate = self;
        _ChooseIdPickerView.dataSource = self;
    }
    return _ChooseIdPickerView;
}

@end
