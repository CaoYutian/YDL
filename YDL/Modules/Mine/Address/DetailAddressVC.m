//
//  DetailAddressVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "DetailAddressVC.h"
#import "BaseTableViewCell.h"
#import "ActionSheetCustomPicker.h"
#import "AddressMapViewController.h"

@interface DetailAddressVC ()<ActionSheetCustomPickerDelegate>

@property(nonatomic,strong)BaseTableView *tableView;
@property(nonatomic,copy)NSArray *titleArray;
@property(nonatomic,strong)UITextField *addressField;
@property(nonatomic,strong)UITextField *addreddDetailField;
@property(nonatomic,strong)NSIndexPath *currentIndexPath;

@property(nonatomic,strong)NSArray *addressArr; // 解析出来的最外层数组
@property(nonatomic,strong)NSArray *provinceArr; // 省
@property(nonatomic,strong)NSArray *countryArr; // 市
@property(nonatomic,strong)NSArray *districtArr; // 区
@property(nonatomic,strong)NSArray *provinceCodeArr; // 省code
@property(nonatomic,strong)NSArray *countryCodeArr; // 市code
@property(nonatomic,strong)NSArray *districtCodeArr; // 区code
@property(nonatomic,assign)NSInteger index1; // 省下标
@property(nonatomic,assign)NSInteger index2; // 市下标
@property(nonatomic,assign)NSInteger index3; // 区下标
@property(nonatomic,strong)ActionSheetCustomPicker *picker; // 选择器
@property(nonatomic,assign)SelectAddressType selectAddressType;

@end

@implementation DetailAddressVC

- (instancetype)initWithSelectAddressType:(SelectAddressType)selectAddressType {
    if (self = [super init]) {
        _selectAddressType = selectAddressType;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详细地址";
    [self.view addSubview:self.tableView];
    WS(weakSelf);
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf.view).insets(UIEdgeInsetsMake(64, 0, 50, 0));
    }];
    
    UIView *footerView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, 100)];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:whiteColor forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = FONT_NORMAL;
    [confirmBtn setBackgroundImage:[UIImage createImageWithColor:NavigationBarBackgroundColor] forState:UIControlStateNormal];
    confirmBtn.layer.cornerRadius = 5;
    confirmBtn.clipsToBounds = YES;
    [confirmBtn addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:confirmBtn];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_SPACE);
        make.right.equalTo(footerView).offset(-MARGIN_SPACE);
        make.bottom.equalTo(footerView).offset(-20);
        make.height.mas_equalTo(44);
    }];
    self.tableView.tableFooterView = footerView;
    
    if (self.selections.count) {
        self.index1 = [self.selections[0] integerValue];
        self.index2 = [self.selections[1] integerValue];
        self.index3 = [self.selections[2] integerValue];
    }
    // 先加载出这三个数组，不然蹦
    [self calculateFirstData];
    
}

- (void)loadData {
    self.titleArray = @[@"选择地区",@"详细地址"];
    self.tableView.dataArray = [self.titleArray mutableCopy];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"geo" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:path usedEncoding:nil error:nil];
    self.addressArr = [jsonStr mj_JSONObject];
    
    NSMutableArray *firstName = [[NSMutableArray alloc] init];
    NSMutableArray *firstCode = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in self.addressArr) {
        NSString *provinceName = [dict objectForKey:@"province_name"];
        NSString *provinceCode = [dict objectForKey:@"province_code"];
        [firstName addObject:provinceName];
        [firstCode addObject:provinceCode];
    }
    // 第一层是省份 分解出整个省份数组
    self.provinceArr = firstName;
    self.provinceCodeArr = firstCode;
}

// 根据传进来的下标数组计算对应的三个数组
- (void)calculateFirstData {
    // 拿出省的数组
    [self loadData];
    
    NSMutableArray *cityNameArr = [[NSMutableArray alloc] init];
    NSMutableArray *cityCodeArr = [[NSMutableArray alloc] init];
    // 根据省的index1，默认是0，拿出对应省下面的市
    for (NSDictionary *cityName in [self.addressArr[self.index1] objectForKey:@"city"]) {
        
        NSString *cityName1 = [cityName objectForKey:@"city_name"];
        NSString *cityCode1 = [cityName objectForKey:@"city_code"];
        [cityNameArr addObject:cityName1];
        [cityCodeArr addObject:cityCode1];
    }
    // 组装对应省下面的市
    self.countryArr = cityNameArr;
    self.countryCodeArr = cityCodeArr;
    
    NSMutableArray *areaNameArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *areaCodeArr = [NSMutableArray arrayWithCapacity:0];
    for (NSDictionary *areaName in [[self.addressArr[self.index1] objectForKey:@"city"][self.index2] objectForKey:@"area"] ){
        
        NSString *areaName1 = [areaName objectForKey:@"area_name"];
        NSString *areaCode1 = [areaName objectForKey:@"area_code"];
        [areaNameArr addObject:areaName1];
        [areaCodeArr addObject:areaCode1];
    }
    
    //index1对应省的字典  市的数组 index2市的字典   对应市的数组
    //市下面的地区数组
    self.districtArr = areaNameArr;
    self.districtCodeArr = areaCodeArr;
}

#pragma mark - UIPickerViewDataSource Implementation
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    // Returns
    switch (component)
    {
        case 0: return self.provinceArr.count;
        case 1: return self.countryArr.count;
        case 2:return self.districtArr.count;
        default:break;
    }
    return 0;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component)
    {
        case 0: return self.provinceArr[row];break;
        case 1: return self.countryArr[row];break;
        case 2:return self.districtArr[row];break;
        default:break;
    }
    return nil;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    
    UILabel *label = (UILabel*)view;
    if (!label) {
        label = [[UILabel alloc] init];
        [label setFont:[UIFont systemFontOfSize:14]];
    }
    
    NSString *title = @"";
    switch (component)
    {
        case 0: title =   self.provinceArr[row];break;
        case 1: title =   self.countryArr[row];break;
        case 2: title =   self.districtArr[row];break;
        default:break;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (component)
    {
        case 0:
        {
            self.index1 = row;
            self.index2 = 0;
            self.index3 = 0;
            // 滚动的时候都要进行一次数组的刷新
            [self calculateFirstData];
            [pickerView reloadComponent:1];
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
            break;
            
        case 1:
        {
            self.index2 = row;
            self.index3 = 0;
            [self calculateFirstData];
            [pickerView selectRow:0 inComponent:2 animated:YES];
            [pickerView reloadComponent:2];
        }
            break;
        case 2:
            self.index3 = row;
            break;
        default:break;
    }
}

- (void)configurePickerView:(UIPickerView *)pickerView {
    pickerView.showsSelectionIndicator = NO;
}

// 点击确定的时候回调
- (void)actionSheetPickerDidSucceed:(ActionSheetCustomPicker *)actionSheetPicker origin:(id)origin {
    
    if (self.index1 < self.provinceArr.count) {
        
        GeoModel *provinceInfo = [[GeoModel alloc] init];
        provinceInfo.geoName = self.provinceArr[self.index1];
        provinceInfo.geoId = self.provinceCodeArr[self.index1];
        self.addressData.provinceInfo = provinceInfo;
        
    }
    if (self.index2 < self.countryArr.count) {
        
        GeoModel *cityInfo = [[GeoModel alloc] init];
        cityInfo.geoName = self.countryArr[self.index2];
        cityInfo.geoId = self.countryCodeArr[self.index2];
        self.addressData.cityInfo = cityInfo;
        
    }
    if (self.index3 < self.districtArr.count) {
        
        GeoModel *countyInfo = [[GeoModel alloc] init];
        countyInfo.geoName = self.districtArr[self.index3];
        countyInfo.geoId = self.districtCodeArr[self.index3];
        self.addressData.countyInfo = countyInfo;
        
    }
    
    // 界面显示省市区
    self.addressField.text = [NSString stringWithFormat:@"%@ %@ %@", self.addressData.provinceInfo.geoName, self.addressData.cityInfo.geoName, self.addressData.countyInfo.geoName];
}


#pragma mark - actions
- (void)confirmAction {
    
    if (!self.addressField.text.length) {
        [MBProgressHUD showMsgHUD:@"请选择地区"];
        return;
    }
    if (!self.addreddDetailField.text.length) {
        [MBProgressHUD showMsgHUD:@"请输入详细地址"];
        return;
    }
    
    self.addressData.detailAddress = self.addreddDetailField.text;
    
    if (self.selectAddressBlock) {
        self.selectAddressBlock(self.addressData);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)locationAction {
    AddressMapViewController *addressMapVC = [[AddressMapViewController alloc] init];
    addressMapVC.addressData = self.addressData;
    addressMapVC.selectAddressBlock = ^ (AddressPickerModel *addressPickerData) {
        NSString *provinceName = addressPickerData.provinceInfo.geoName;
        if ([self.provinceArr containsObject:provinceName]) {
            self.index1 = [self.provinceArr indexOfObject:provinceName];
            addressPickerData.provinceInfo.geoId = self.provinceCodeArr[self.index1];
            [self calculateFirstData];
            NSString *cityName = addressPickerData.cityInfo.geoName;
            if ([self.countryArr containsObject:cityName]) {
                self.index2 = [self.countryArr indexOfObject:cityName];
                addressPickerData.cityInfo.geoId = self.countryCodeArr[self.index2];
            }
            [self calculateFirstData];
            NSString *countyName = addressPickerData.countyInfo.geoName;
            if ([self.districtArr containsObject:countyName]) {
                self.index3 = [self.districtArr indexOfObject:countyName];
                addressPickerData.countyInfo.geoId = self.districtCodeArr[self.index3];
            }
        }
        self.addressData = addressPickerData;
        [self.tableView reloadData];
    };
    [self pushVc:addressMapVC];
}

- (BaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[BaseTableView alloc] init];
        _tableView.backgroundColor = MainBackgroundColor;
        _tableView.tableViewCellClass = [BaseTableViewCell class];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.clearSeperatorInset = YES;
        WS(weakSelf);
        _tableView.cellConfigureBlock = ^ (UITableViewCell *cell, id data, NSIndexPath *indexPath) {
            [cell.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.bottom.equalTo(cell);
                make.width.mas_equalTo(100);
            }];
            cell.textLabel.font = FONT_NORMAL;
            cell.textLabel.text = weakSelf.titleArray[indexPath.row];
            switch (indexPath.row) {
                    
                case 0: //所在区域
                {
                    if (!weakSelf.addressField) {
                        weakSelf.addressField = [[UITextField alloc] init];
                        weakSelf.addressField.font = FONT_NORMAL;
                        weakSelf.addressField.enabled = NO;
                        [cell.contentView addSubview:weakSelf.addressField];
                        [weakSelf.addressField mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(cell.textLabel.mas_right).offset(5);
                            make.top.bottom.equalTo(cell.contentView);
                            make.right.equalTo(cell).offset(-30);
                        }];
                        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    }
                    // 界面显示省市区
                    weakSelf.addressField.text = weakSelf.addressData.provinceInfo.geoName.length?[NSString stringWithFormat:@"%@ %@ %@", weakSelf.addressData.provinceInfo.geoName, weakSelf.addressData.cityInfo.geoName, weakSelf.addressData.countyInfo.geoName]:@"";
                    UIButton *addressBtn = [cell.contentView viewWithTag:100];
                    if (!addressBtn) {
                        addressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                        [addressBtn setImage:[UIImage imageNamed:@"location_gray"] forState:UIControlStateNormal];
                        [addressBtn addTarget:weakSelf action:@selector(locationAction) forControlEvents:UIControlEventTouchUpInside];
                        addressBtn.tag = 100;
                        [cell.contentView addSubview:addressBtn];
                        [addressBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.right.top.bottom.equalTo(cell.contentView);
                            make.width.mas_equalTo(44);
                        }];
                    }
                    break;
                }
                case 1: //详细地址
                {
                    if (!weakSelf.addreddDetailField) {
                        weakSelf.addreddDetailField = [[UITextField alloc] init];
                        weakSelf.addreddDetailField.font = FONT_NORMAL;
                        weakSelf.addreddDetailField.clearButtonMode = UITextFieldViewModeWhileEditing;
                        weakSelf.addreddDetailField.placeholder = @"请输入详细地址";
                        [cell.contentView addSubview:weakSelf.addreddDetailField];
                        [weakSelf.addreddDetailField mas_makeConstraints:^(MASConstraintMaker *make) {
                            make.left.mas_equalTo(cell.textLabel.mas_right).offset(5);
                            make.top.bottom.equalTo(cell.contentView);
                            make.right.equalTo(cell).offset(-30);
                        }];
                    }
                    weakSelf.addreddDetailField.text = weakSelf.addressData.detailAddress.length?safeString(weakSelf.addressData.detailAddress):@"";
                    break;
                }
                    
                default:
                    break;
            }
        };
        _tableView.cellHeightBlock = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            return (CGFloat)44.0;
        };
        _tableView.cellSelectBlock = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            if (indexPath.row == 0) {
                weakSelf.currentIndexPath = indexPath;
                [weakSelf.view endEditing:YES];
                
                // 点击的时候传三个index进去
                weakSelf.picker = [[ActionSheetCustomPicker alloc]initWithTitle:@"选择地区" delegate:weakSelf showCancelButton:YES origin:weakSelf.view initialSelections:@[@(weakSelf.index1),@(weakSelf.index2),@(weakSelf.index3)]];
                weakSelf.picker.tapDismissAction = TapActionCancel;
                
                // 左边和右边的按钮
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button.frame = CGRectMake(0, 0, 44, 44);
                [button setTitle:@"取消" forState:UIControlStateNormal];
                
                UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
                [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                button1.frame = CGRectMake(0, 0, 44, 44);
                [button1 setTitle:@"确定" forState:UIControlStateNormal];
                [weakSelf.picker setCancelButton:[[UIBarButtonItem alloc] initWithCustomView:button]];
                [weakSelf.picker setDoneButton:[[UIBarButtonItem alloc] initWithCustomView:button1]];
                
                [weakSelf.picker showActionSheetPicker];
            }
        };
    }
    return _tableView;
}


- (AddressPickerModel *)addressData {
    if (!_addressData) {
        _addressData = [[AddressPickerModel alloc] init];
    }
    return _addressData;
}

- (NSArray *)provinceArr {
    if (!_provinceArr) {
        _provinceArr = [[NSArray alloc] init];
    }
    return _provinceArr;
}
- (NSArray *)provinceCodeArr {
    if (!_provinceCodeArr) {
        _provinceCodeArr = [[NSArray alloc] init];
    }
    return _provinceCodeArr;
}

- (NSArray *)countryArr {
    if(!_countryArr) {
        _countryArr = [[NSArray alloc] init];
    }
    return _countryArr;
}
- (NSArray *)countryCodeArr {
    if(!_countryCodeArr) {
        _countryCodeArr = [[NSArray alloc] init];
    }
    return _countryCodeArr;
}
- (NSArray *)districtArr {
    if (!_districtArr) {
        _districtArr = [[NSArray alloc] init];
    }
    return _districtArr;
}
- (NSArray *)districtCodeArr {
    if (!_districtCodeArr) {
        _districtCodeArr = [[NSArray alloc] init];
    }
    return _districtCodeArr;
}
- (NSArray *)addressArr {
    if (!_addressArr) {
        _addressArr = [[NSArray alloc] init];
    }
    return _addressArr;
}
@end
