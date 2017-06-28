//
//  CheckOrderInfoVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/23.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "CheckOrderInfoVC.h"
#import "headerVOfCheckOrder.h"
#import "PopUpPickerView.h"

#import "MyInvoiceVC.h"
#import "AddressVC.h"
#import "OtherRequirementsVC.h"
#import "WSDatePickerView.h"


@interface CheckOrderInfoVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,PopUpMenuDelegate,PopUpMenuDataSource,ActionSheetViewDelegate>
@property (nonatomic, strong) PopUpPickerView *DMPickerView;
@property (nonatomic, strong) PopUpPickerView *isHostPickerView;

@end

@implementation CheckOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"核对订单信息";

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.TableView];
    [self.TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, - FitheightRealValue(40), 0));
    }];
    headerVOfCheckOrder *headerV = [[headerVOfCheckOrder alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(90))];
    self.TableView.tableHeaderView = headerV;

    self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, CYTMainScreen_HEIGHT - FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(40))];
    self.footView.backgroundColor = whiteColor;
    [self.view addSubview:self.footView];
    self.totalPrice = [[UILabel alloc] initWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH - FitwidthRealValue(100), FitheightRealValue(40))];
    self.totalPrice.textAlignment = NSTextAlignmentLeft;
    [self.footView addSubview:self.totalPrice];
    NSMutableAttributedString *totalPriceAttri = [CYTUtiltyHelper addAttribute:@"总计：￥0.00" firstColorValue:blackColor secondColorValue:[UIColor orangeColor] firstFont:FitFont(12) secondFont:FitFont(16) firstRange:NSMakeRange(0, 3) secondRange:NSMakeRange(3, 5)];
    self.totalPrice.attributedText = totalPriceAttri;
    
    self.submitOrder = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(100), 0, FitwidthRealValue(100), FitheightRealValue(40)) LabelText:@"提交订单" TextFont:FitFont(16) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor orangeColor] highLightBgColor:[UIColor orangeColor] tag:120 SuperView:self.footView buttonTarget:self Action:@selector(submitOrderClick)];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = self.titleArr[indexPath.row];
    cell.textLabel.font = FitFont(14);
    cell.textLabel.textColor = [UIColor grayColor];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    switch (indexPath.row) {
        case 0:
            self.distributionStyle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:112 LabelText:@"厂家配送"];
            break;
        case 1:
            self.address = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:112 LabelText:@""];

            break;
            
        case 2:
            cell.accessoryType = UITableViewCellAccessoryNone;
            [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(30), 0, FitwidthRealValue(30), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentCenter SuperView:cell.contentView LabelTag:110 LabelText:@"吨"];
            self.quantityTf = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(230), 0, FitwidthRealValue(200), FitheightRealValue(44)) font:FitFont(14) placeholder:@"请输入需求总量" TextfiledTag:111 SuperView:cell.contentView];
            self.quantityTf.textAlignment = NSTextAlignmentRight;
            self.quantityTf.textColor = [UIColor orangeColor];
            self.quantityTf.keyboardType = UIKeyboardTypeNumberPad;
            self.quantityTf.delegate = self;
            self.quantityTf.borderStyle = UITextBorderStyleNone;
            break;
            
        case 3:
            self.time = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:112 LabelText:@""];

            break;
            
        case 4:
            self.invoiceInfo = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:113 LabelText:@""];

            break;
        
        case 5:
            self.isHost = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(200), 0, FitwidthRealValue(170), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:114 LabelText:@""];

            break;
            
        case 6:
            self.message = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(275), 0, FitwidthRealValue(250), FitheightRealValue(44)) LabelFont:FitFont(14) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:cell.contentView LabelTag:115 LabelText:@""];
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(44)   ;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self.DMPickerView show];
            break;
            
        case 1:
            [self pushVc:[AddressVC new]];
            break;
            
        case 3:
            [self selectDate];
            break;
            
        case 4:
            [self pushVc:[MyInvoiceVC new]];
            break;
            
        case 5:
            [self.isHostPickerView show];
            break;
            
        case 6:
            [self leaveAMessage];
            break;
    }
    
}

#pragma mark 选择时间
- (void)selectDate {
    WSDatePickerView *datepicker = [[WSDatePickerView alloc] initWithDateStyle:DateStyleShowMonthDayHourMinute CompleteBlock:^(NSDate *startDate) {
        NSString *date = [startDate stringWithFormat:@"yyyy-MM-dd HH:mm"];
        self.time.text = date;
    }];
    datepicker.doneButtonColor = [UIColor orangeColor];//确定按钮的颜色
    [datepicker show];
}

#pragma mark 留言
- (void)leaveAMessage {
    
    OtherRequirementsVC *OtherRequirements = [[OtherRequirementsVC alloc] init];
    OtherRequirements.title = @"给卖家留言";
    [OtherRequirements setBlock:^(NSString *distriText){
        self.message.text = distriText;
    }];
    OtherRequirements.distriText = self.message.text;
    [self pushVc:OtherRequirements];

}

#pragma mark 提交订单
- (void)submitOrderClick {
    
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
        if (popUpMenu==self.isHostPickerView) {
            return self.isHostArr.count;
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
        if (popUpMenu==self.isHostPickerView) {
            return self.isHostArr[row];
        }

    }
    return @"";
}

- (void)popUpMenu:(PopUpPickerView *)popUpMenu didSelectRowArray:(NSArray *)rowArray {
    if (popUpMenu==self.DMPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.distributionStyle setText:self.DMArr[index]];
    }
    if (popUpMenu==self.isHostPickerView) {
        NSInteger index = [rowArray.firstObject integerValue];
        [self.isHost setText:self.isHostArr[index]];
    }

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

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"配送方式", @"收货地址", @"购买数量",@"要求到岸时间"
                      ,@"发票信息", @"是否托运",@"给卖家留言"];
    }
    return _titleArr;
}

-(PopUpPickerView *)DMPickerView {
    if (!_DMPickerView) {
        _DMPickerView = [[PopUpPickerView alloc] init];
        _DMPickerView.delegate = self;
        _DMPickerView.dataSource = self;
    }
    return _DMPickerView;
}

-(PopUpPickerView *)isHostPickerView {
    if (!_isHostPickerView) {
        _isHostPickerView = [[PopUpPickerView alloc] init];
        _isHostPickerView.delegate = self;
        _isHostPickerView.dataSource = self;
    }
    return _isHostPickerView;
}

- (NSArray *)DMArr {
    if (!_DMArr) {
        _DMArr = [[NSArray alloc] init];
        _DMArr = @[@"厂家配送",@"自提"];
    }
    return _DMArr;
}

- (NSArray *)isHostArr {
    if (!_isHostArr) {
        _isHostArr = [[NSArray alloc] init];
        _isHostArr = @[@"是",@"否"];
    }
    return _isHostArr;
}

@end
