//
//  CheckOrderInfoVC.h
//  YQW
//
//  Created by Sunshine on 2017/6/23.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"

@interface CheckOrderInfoVC : BaseVC

@property (nonatomic, strong) UITableView *TableView;
@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UILabel *distributionStyle;    //配送方式
@property (nonatomic, strong) UILabel *address;
@property (nonatomic, strong) UITextField *quantityTf;
@property (nonatomic, strong) UILabel *time;
@property (nonatomic, strong) UILabel *invoiceInfo;
@property (nonatomic, strong) UILabel *isHost;
@property (nonatomic, strong) UILabel *message;


@property (nonatomic, strong) UIView *footView;
@property (nonatomic, strong) UILabel *totalPrice;
@property (nonatomic, strong) UIButton *submitOrder;

@property (nonatomic, strong) NSArray *DMArr;               //配送方式Data
@property (nonatomic, strong) NSArray *isHostArr;          //付款方式Data

@end
