//
//  QiuGouVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QiuGouVC.h"
#import "PopUpPickerView.h"
#import "QIYuanDiOfQiuGouCell.h"
#import "LargeClassMenuView.h"
#import "DeliveryTimeView.h"

#import "OtherRequirementsVC.h"

@interface QiuGouVC ()<UITableViewDelegate,UITableViewDataSource,PopUpMenuDelegate,PopUpMenuDataSource,ActionSheetViewDelegate,UITextFieldDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) PopUpPickerView *DMPickerView;
@property (nonatomic, strong) PopUpPickerView *paymentPickerView;
@property (nonatomic, strong) PopUpPickerView *payPickerView;

@property (nonatomic, strong) NSArray *DMArr;               //配送方式Data
@property (nonatomic, strong) NSArray *paymentArr;          //付款方式Data
@property (nonatomic, strong) NSArray *payArr;              //支付方式Data

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *QiYuanDiArr;
@property (nonatomic, strong) NSMutableArray *XieQiDianArr;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) UILabel *startTime;
@property (nonatomic, strong) UILabel *endTime;
@property (nonatomic, strong) UILabel *distributionStyle;    //配送方式
@property (nonatomic, strong) UITextField *totalDemandTf;    //总需求
@property (nonatomic, strong) UILabel *paymentStyel;         //付款方式
@property (nonatomic, strong) UILabel *payStyle;             //支付方式
@property (nonatomic, strong) UISwitch *isAdjust;            //气源是否调剂
@property (nonatomic, strong) UISwitch *isHosting;           //是否托管

@end

@implementation QiuGouVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"求购发布";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    
    //发布求购
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, CYTMainScreen_HEIGHT - FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelText:@"发布求购" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:NavigationBarBackgroundColor highLightBgColor:NavigationBarBackgroundColor tag:130 SuperView:self.view buttonTarget:self Action:@selector(releaseDemand:)];
    
    LargeClassMenuView *LargeClassView = [[LargeClassMenuView alloc] initWithFrame:CGRectMake(0, 0,80, 44) titles:@[@"大单",@"散单"]];
    LargeClassView.selectedAtIndex = ^(int index) {
        
    };
    self.navigationItem.titleView = LargeClassView;
    
}

- (void)releaseDemand:(UIButton *)Btn {
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.XieQiDianArr.count;
    }if (section == 1) {
        return self.QiYuanDiArr.count;
    }else if (section == 2){
        return 0;
    }
    return self.titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FitheightRealValue(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section < 2) {
        return FitheightRealValue(44);
    }else if (section == 2){
        return FitheightRealValue(60);
    }else {
        return 0.001;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        UIView *headeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(44))];
        headeView.backgroundColor = whiteColor;
        [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH - FitwidthRealValue(100), FitheightRealValue(44)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:headeView LabelTag:101 LabelText:@"卸气点（已选择0个卸气点）"];
        [CYTUtiltyHelper addbuttonWithRect:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(33), FitheightRealValue(11), FitwidthRealValue(20), FitheightRealValue(20)) NormalbgImageStr:@"addrequierment" highLightbgimageStr:@"addrequierment" tag:102 SuperView:headeView buttonTarget:self Action:@selector(addXieQiDianAction:)];
        
        return headeView;
    }else if (section == 1){
        UIView *headeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(44))];
        headeView.backgroundColor = whiteColor;
        [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH - FitwidthRealValue(100), FitheightRealValue(44)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:headeView LabelTag:103 LabelText:@"气源地"];
        [CYTUtiltyHelper addbuttonWithRect:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(33), FitheightRealValue(11), FitwidthRealValue(20), FitheightRealValue(20)) NormalbgImageStr:@"addrequierment" highLightbgimageStr:@"addrequierment" tag:104 SuperView:headeView buttonTarget:self Action:@selector(addQiYuanDiAction:)];
        
        return headeView;
    }else if (section == 2){
        UIView *headeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(60))];
        headeView.backgroundColor = whiteColor;
        [headeView setTapActionWithBlock:^{
            [self deliveryTime];
        }];
        
        UILabel *deliveryTIme = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, FitwidthRealValue(80), FitheightRealValue(60)) LabelFontSize:14 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:headeView LabelTag:104 LabelText:@"交付时间"];
        
        self.startTime = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(deliveryTIme.right + FitwidthRealValue(10), FitheightRealValue(5), CYTMainScreen_WIDTH - FitwidthRealValue(100), FitheightRealValue(25)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentLeft SuperView:headeView LabelTag:105 LabelText:@"开始时间"];
        
        self.endTime = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(deliveryTIme.right + FitwidthRealValue(10), FitheightRealValue(30), CYTMainScreen_WIDTH - FitwidthRealValue(100), FitheightRealValue(25)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentLeft SuperView:headeView LabelTag:106 LabelText:@"结束时间"];

        [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(20), FitheightRealValue(22.5), FitwidthRealValue(15), FitwidthRealValue(15)) imageName:@"main_arrow_right" SuperView:headeView];
        
        return headeView;
    }else {
        return NULL;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0){
        static NSString *cellId = @"QIYuanDiOfQiuGouCell";
        
        QIYuanDiOfQiuGouCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [cell callBack:^(BOOL index) {
            [self deleteXieQiDianIndexPath:indexPath];
        }];
        
        return cell;
    }else if (indexPath.section == 1) {
        QIYuanDiOfQiuGouCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QIYuanDiOfQiuGouCell" forIndexPath:indexPath];
        
        [cell setCellData:nil atIndexPath:indexPath];
        
        [cell callBack:^(BOOL index) {
            if (index) {
                [self deleteQiYuanDiIndexPath:indexPath];
            }
        }];
        
        return cell;
    }else if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.textLabel.text = self.titleArray[indexPath.row];
        cell.textLabel.font = FitFont(14);
        cell.textLabel.textColor = [UIColor grayColor];
        
        switch (indexPath.row) {
            case 0:
                [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(30), 0, FitwidthRealValue(30), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentCenter SuperView:cell.contentView LabelTag:110 LabelText:@"吨"];
                self.totalDemandTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(230), 0, FitwidthRealValue(200), FitheightRealValue(44)) font:FitFont(14) placeholder:@"请输入需求总量" TextfiledTag:111 SuperView:cell.contentView];
                self.totalDemandTf.textAlignment = NSTextAlignmentRight;
                self.totalDemandTf.textColor = [UIColor orangeColor];
                self.totalDemandTf.keyboardType = UIKeyboardTypeNumberPad;
                self.totalDemandTf.delegate = self;
                self.totalDemandTf.borderStyle = UITextBorderStyleNone;
                break;
                
            case 1:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.distributionStyle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:112 LabelText:@"厂家配送"];
                break;
            
            case 2:
                cell.accessoryType = UITableViewCellAccessoryNone;
                [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(113), 0, FitwidthRealValue(100), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:110 LabelText:@"一票制"];
                break;
                
            case 3:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.paymentStyel = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:112 LabelText:@"预付"];
                break;
                
            case 4:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                self.payStyle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:112 LabelText:@"直接支付"];
                break;
                
            case 5:
                self.isAdjust = [[UISwitch alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(60), FitheightRealValue(7), FitwidthRealValue(40), FitheightRealValue(30))];
                [self.isAdjust addTarget:self action:@selector(isAdjust:) forControlEvents:UIControlEventValueChanged];
                [cell.contentView addSubview:self.isAdjust];
                break;
                
            case 6:
                self.isHosting = [[UISwitch alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(60), FitheightRealValue(7), FitwidthRealValue(40), FitheightRealValue(30))];
                [self.isHosting addTarget:self action:@selector(isHosting:) forControlEvents:UIControlEventValueChanged];

                [cell.contentView addSubview:self.isHosting];
                break;
                
            case 7:
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

                break;
        }
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (FitheightRealValue(44));
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        switch (indexPath.row) {
            case 1:
                [self.DMPickerView show];
                break;

            case 3:
                [self.paymentPickerView show];
                break;
                
            case 4:
                [self.payPickerView show];
                break;
                
            case 7:
                [self OtherRequirements];
                break;
        }
    }
}

#pragma mark 其他原因
- (void)OtherRequirements {
    OtherRequirementsVC *OtherRequirements = [[OtherRequirementsVC alloc] init];
    OtherRequirements.title = @"其他需求";
    [self pushVc:OtherRequirements];
}

#pragma mark 点击事件处理
- (void)addXieQiDianAction:(UIButton *)btn {
    //插入数据，刷新界面
    [self.XieQiDianArr addObject:@"卸气点"];
    NSInteger row = self.XieQiDianArr.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //UITableView 滚动到添加的行
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)addQiYuanDiAction:(UIButton *)btn {
    //插入数据，刷新界面
    [self.QiYuanDiArr addObject:@"气源地"];
    NSInteger row = self.QiYuanDiArr.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:1];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    //UITableView 滚动到添加的行
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:1] atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (void)deleteXieQiDianIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [self.XieQiDianArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[deleteIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView reloadData];
}

- (void)deleteQiYuanDiIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *deleteIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:1];
    [self.QiYuanDiArr removeObjectAtIndex:indexPath.row];
    [self.tableView deleteRowsAtIndexPaths:@[deleteIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
    
    [self.tableView reloadData];
}

#pragma mark 选择交付时间
- (void)deliveryTime {
    
    DeliveryTimeView *deliveryTimeView = [[DeliveryTimeView alloc] init];
    [deliveryTimeView showInView:self.view];
    
    [deliveryTimeView getDeliveryTime:^(NSString *startTime, NSString *endTime) {
        NSMutableAttributedString *startTimeAttri = [CYTUtiltyHelper addAttribute:[NSString stringWithFormat:@"%@ 开始",startTime] firstColorValue:blackColor secondColorValue:[UIColor grayColor] firstFont:FitFont(16) secondFont:FitFont(14) firstRange:NSMakeRange(0, 10) secondRange:NSMakeRange(10, 3)];
        
        self.startTime.attributedText = startTimeAttri;
        
        NSMutableAttributedString *endTimeAttri = [CYTUtiltyHelper addAttribute:[NSString stringWithFormat:@"%@ 结束",endTime] firstColorValue:blackColor secondColorValue:[UIColor grayColor] firstFont:FitFont(16) secondFont:FitFont(14) firstRange:NSMakeRange(0, 10) secondRange:NSMakeRange(10, 3)];
            
        self.endTime.attributedText = endTimeAttri;
    }];
    
}

#pragma mark textFeild 的代理
- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.totalDemandTf.text = textField.text;
}

- (void)isAdjust:(UISwitch *)Switch {
    ActionAlertView *alertView = [[ActionAlertView alloc] initWithTitle:@"气源是否调剂" message:@"气源确定要调剂吗?" sureBtn:@"确定" cancleBtn:@"取消"];
    alertView.resultIndex = ^(NSInteger index){
        if (index == 2) {
            [MBProgressHUD showLoadingHUD:@"正在清理..." duration:0.7];
        }
    };
    [alertView showAlertView];
}

- (void)isHosting:(UISwitch *)Hosting {
    ActionAlertView *alertView = [[ActionAlertView alloc] initWithTitle:@"是否委托" message:@"确定要委托吗?" sureBtn:@"确定" cancleBtn:@"取消"];
    alertView.resultIndex = ^(NSInteger index){
        if (index == 2) {
            [MBProgressHUD showLoadingHUD:@"正在清理..." duration:0.7];
        }
    };
    [alertView showAlertView];
}

#pragma mark - QMPopUpMenuDataSource
- (NSInteger)numberOfComponentsInPickerView:(PopUpPickerView *)popUpMenu {
    return 1;
}

- (NSInteger)popUpMenu:(PopUpPickerView *)popUpMenu numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        if (popUpMenu==self.DMPickerView) {
            return self.DMArr.count;
        }
        if (popUpMenu==self.paymentPickerView) {
            return self.paymentArr.count;
        }
        if (popUpMenu==self.payPickerView) {
            return self.payArr.count;
        }
    }
    return 0;
}

#pragma mark - QMPopUpMenuDelegate
- (NSString *)popUpMenu:(PopUpPickerView *)popUpMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component==0) {
        if (popUpMenu==self.DMPickerView) {
            return self.DMArr[row];
        }
        if (popUpMenu==self.paymentPickerView) {
            return self.paymentArr[row];
        }
        if (popUpMenu==self.payPickerView) {
            return self.payArr[row];
        }
    }
    return @"";
}

- (void)popUpMenu:(PopUpPickerView *)popUpMenu didSelectRowArray:(NSArray *)rowArray {
    if (popUpMenu==self.DMPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.distributionStyle setText:self.DMArr[index]];
    }
    if (popUpMenu==self.paymentPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.paymentStyel setText:self.paymentArr[index]];
    }
    if (popUpMenu==self.payPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.payStyle setText:self.payArr[index]];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.backgroundColor = [UIColor clearColor];
        [_tableView registerClass:[QIYuanDiOfQiuGouCell class] forCellReuseIdentifier:@"QIYuanDiOfQiuGouCell"];
    }
    return _tableView;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"需求总量", @"配送方式", @"结算票制",@"付款方式"
                       ,@"支付方式", @"起源是否调剂",@"是否委托",@"其他需求"];
    }
    return _titleArray;
}

- (NSArray *)DMArr {
    if (!_DMArr) {
        _DMArr = [[NSArray alloc] init];
        _DMArr = @[@"厂家配送",@"自提"];
    }
    return _DMArr;
}

- (NSArray *)paymentArr {
    if (!_paymentArr) {
        _paymentArr = [[NSArray alloc] init];
        _paymentArr = @[@"预付",@"后付",@"不限"];
    }
    return _paymentArr;
}

- (NSArray *)payArr {
    if (!_payArr) {
        _payArr = [[NSArray alloc] init];
        _payArr = @[@"直接支付",@"担保支付"];
    }
    return _payArr;
}

-(PopUpPickerView *)DMPickerView {
    if (!_DMPickerView) {
        _DMPickerView = [[PopUpPickerView alloc] init];
        _DMPickerView.delegate = self;
        _DMPickerView.dataSource = self;
    }
    return _DMPickerView;
}

- (PopUpPickerView *)paymentPickerView {
    if (!_paymentPickerView) {
        _paymentPickerView = [[PopUpPickerView alloc] init];
        _paymentPickerView.delegate = self;
        _paymentPickerView.dataSource = self;
    }
    return _paymentPickerView;
}

- (PopUpPickerView *)payPickerView {
    if (!_payPickerView) {
        _payPickerView = [[PopUpPickerView alloc] init];
        _payPickerView.delegate = self;
        _payPickerView.dataSource = self;
    }
    return _payPickerView;
}

- (NSMutableArray *)QiYuanDiArr {
    if (!_QiYuanDiArr) {
        _QiYuanDiArr = [[NSMutableArray alloc] init];
    }
    return _QiYuanDiArr;
}

- (NSMutableArray *)XieQiDianArr {
    if (!_XieQiDianArr) {
        _XieQiDianArr = [[NSMutableArray alloc] init];
    }
    return _XieQiDianArr;
}

@end
