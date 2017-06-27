//
//  ApplyAddressVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "ApplyAddressVC.h"
#import "DetailAddressVC.h"
#import "PopUpPickerView.h"
#import "OtherRequirementsVC.h"

@interface ApplyAddressVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PopUpMenuDelegate,PopUpMenuDataSource,ActionSheetViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISwitch *isHaveLdm;
@property (nonatomic, strong) UITextField *abilityTf;    //总需求
@property (nonatomic, strong) UILabel *gasDischargeType; //卸气点分类
@property (nonatomic, strong) UITextField *contactTf;    //联系人
@property (nonatomic, strong) UITextField *phoneNumTf;   //联系电话


@property (nonatomic, strong) PopUpPickerView *GDPickerView;

@property (nonatomic, strong) NSArray *GDArr;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation ApplyAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请卸气点";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;

    //发布求购
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, CYTMainScreen_HEIGHT - FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelText:@"提交" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:130 SuperView:self.view buttonTarget:self Action:@selector(SubmitApplication:)];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 9;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FitheightRealValue(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.titleArray[indexPath.section];
    cell.textLabel.font = FitFont(14);
    cell.textLabel.textColor = [UIColor grayColor];
    
    switch (indexPath.section) {
        case 0:
            self.unloadQiZhanTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(313), 0, FitwidthRealValue(300), FitheightRealValue(44)) font:FitFont(14) placeholder:@"请输入卸气点名称" TextfiledTag:400 SuperView:cell.contentView];
            self.unloadQiZhanTf.textAlignment = NSTextAlignmentRight;
            self.unloadQiZhanTf.delegate = self;
            self.unloadQiZhanTf.borderStyle = UITextBorderStyleNone;

            break;
            
        case 1:
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            break;
        
        case 2:
            [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(30), 0, FitwidthRealValue(30), FitheightRealValue(44)) LabelFont:FitFont(15) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentLeft SuperView:cell.contentView LabelTag:110 LabelText:@"立方"];
            self.abilityTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(235), 0, FitwidthRealValue(200), FitheightRealValue(44)) font:FitFont(14) placeholder:@"请输入" TextfiledTag:401 SuperView:cell.contentView];
            self.abilityTf.textAlignment = NSTextAlignmentRight;
            self.abilityTf.textColor = [UIColor orangeColor];
            self.abilityTf.keyboardType = UIKeyboardTypeNumberPad;
            self.abilityTf.delegate = self;
            self.abilityTf.borderStyle = UITextBorderStyleNone;
            
            break;
            
        case 3:
            self.isHaveLdm = [[UISwitch alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(60), FitheightRealValue(7), FitwidthRealValue(40), FitheightRealValue(30))];
            [self.isHaveLdm addTarget:self action:@selector(isHaveLdm:) forControlEvents:UIControlEventValueChanged];
            
            [cell.contentView addSubview:self.isHaveLdm];
            
            break;
            
        case 4:
            
            break;
            
        case 5:
            self.gasDischargeType = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(300), 0, FitwidthRealValue(287), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:402 LabelText:@"城市燃气"];

            break;
            
        case 6:
            self.contactTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(300), 0, FitwidthRealValue(287), FitheightRealValue(44)) font:FitFont(14) placeholder:@"请输入联系人" TextfiledTag:403 SuperView:cell.contentView];
            self.contactTf.textAlignment = NSTextAlignmentRight;
            self.contactTf.keyboardType = UIKeyboardTypeDefault;
            self.contactTf.delegate = self;
            self.contactTf.borderStyle = UITextBorderStyleNone;
            break;
            
        case 7:
            self.phoneNumTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(300), 0, FitwidthRealValue(287), FitheightRealValue(44)) font:FitFont(14) placeholder:@"请输入联系电话" TextfiledTag:404 SuperView:cell.contentView];
            self.phoneNumTf.textAlignment = NSTextAlignmentRight;
            self.phoneNumTf.keyboardType = UIKeyboardTypeNumberPad;
            self.phoneNumTf.delegate = self;
            self.phoneNumTf.borderStyle = UITextBorderStyleNone;
            break;
            
        case 8:

            break;

    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (FitheightRealValue(44));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.section) {
        case 1:
            [self pushVc:[DetailAddressVC new]];
            break;
            
        case 5:
            [self.GDPickerView show];
            break;
            
        case 8:
            [self applayReason];
            break;
    }
    
}

#pragma MARK 是否有地磅
- (void)isHaveLdm:(UISwitch *)HaveLdm {
    
}

#pragma mark -- 提交申请
- (void)SubmitApplication:(UIButton *)btn {
    
    
}

#pragma mark 申请原因
- (void)applayReason {
    OtherRequirementsVC *OtherRequirements = [[OtherRequirementsVC alloc] init];
    OtherRequirements.title = @"申请原因";
    [self pushVc:OtherRequirements];
}

#pragma mark - QMPopUpMenuDataSource
- (NSInteger)numberOfComponentsInPickerView:(PopUpPickerView *)popUpMenu {
    return 1;
}

- (NSInteger)popUpMenu:(PopUpPickerView *)popUpMenu numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        if (popUpMenu==self.GDPickerView) {
            return self.GDArr.count;
        }

    }
    return 0;
}

#pragma mark - QMPopUpMenuDelegate
- (NSString *)popUpMenu:(PopUpPickerView *)popUpMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==0) {
        if (popUpMenu==self.GDPickerView) {
            return self.GDArr[row];
        }
    }
    return @"";
}

- (void)popUpMenu:(PopUpPickerView *)popUpMenu didSelectRowArray:(NSArray *)rowArray {
    if (popUpMenu==self.GDPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.gasDischargeType setText:self.GDArr[index]];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"卸气点名称", @"卸气点地址", @"储存能力",@"是否有地磅"
                        ,@"营业时间", @"卸气点分类",@"联系人",@"联系电话",@"申请原因"];
    }
    return _titleArray;
}

- (NSArray *)GDArr {
    if (!_GDArr) {
        _GDArr = [[NSArray alloc] init];
        _GDArr = @[@"城市燃气",@"交通能源（车船用）",@"工厂",@"电厂"];
    }
    return _GDArr;
}

-(PopUpPickerView *)GDPickerView {
    if (!_GDPickerView) {
        _GDPickerView = [[PopUpPickerView alloc] init];
        _GDPickerView.delegate = self;
        _GDPickerView.dataSource = self;
    }
    return _GDPickerView;
}

@end
