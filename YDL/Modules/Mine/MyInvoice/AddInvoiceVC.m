//
//  AddInvoiceVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AddInvoiceVC.h"
#import "XLYBankCardMessage.h"

@interface AddInvoiceVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (nonatomic, strong) UITableView *TableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *placeholderArr;


@end

@implementation AddInvoiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加发票";

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.TableView];
    [self.TableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    UIButton *saveBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0 , 0, CYTMainScreen_WIDTH, FitheightRealValue(40)) LabelText:@"保存" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor orangeColor] highLightBgColor:[UIColor orangeColor] tag:500 SuperView:self.view buttonTarget:self Action:@selector(saveAction:)];
    self.TableView.tableFooterView = saveBtn;
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
    
    UITextField *inputContentTF = [CYTUtiltyHelper createTextFieldFrame:CGRectMake(FitwidthRealValue(80), 0, CYTMainScreen_WIDTH - FitwidthRealValue(93), FitheightRealValue(44)) font:FitFont(14) placeholder:self.placeholderArr[indexPath.row] TextfiledTag:indexPath.row + 1000 SuperView:cell.contentView];
    inputContentTF.textAlignment = NSTextAlignmentRight;
    inputContentTF.delegate = self;
    inputContentTF.borderStyle = UITextBorderStyleNone;
    if (indexPath.row == 3 || indexPath.row == 4) {
        inputContentTF.keyboardType = UIKeyboardTypeNumberPad;
    }else {
        inputContentTF.keyboardType = UIKeyboardTypeDefault;
    }
    
    switch (indexPath.row) {
        case 0:
            self.companyName = inputContentTF;
            break;
            
        case 1:
            self.taxpayersCode = inputContentTF;
            break;
            
        case 2:
            self.regAddredd = inputContentTF;
            break;
            
        case 3:
            self.regPhoneNum = inputContentTF;
            break;
            
        case 4:
            self.bankCardNum = inputContentTF;
        [self.bankCardNum addTarget:self action:@selector(BankNumChange:) forControlEvents:UIControlEventEditingChanged];
            
            break;
            
        case 5:
            self.depositBank = inputContentTF;
            break;
    }
    
    return cell;
}

#pragma mark textFeild Delegate
- (void)BankNumChange:(UITextField *)tf {
    self.depositBank.text = [[XLYBankCardMessage shareInstance] xlyBankCardMessageWithBankCardNumber:tf.text returnBankCardMessageType:1];

}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(44)   ;
}

#pragma mark -- 保存
- (void)saveAction:(UIButton *)Btn {
    
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
        _titleArr = @[@"单位名称", @"纳税人识别码", @"注册地址",@"注册电话"
                      ,@"银行账户", @"开户银行"];
    }
    return _titleArr;
}

- (NSArray *)placeholderArr {
    if (!_placeholderArr) {
        _placeholderArr = @[@"请输入单位名称", @"请输入纳税人识别码", @"请输入注册地址",@"请输入注册电话"
                            ,@"请输入银行账户", @"请输入开户银行"];
    }
    return _placeholderArr;
}

@end
