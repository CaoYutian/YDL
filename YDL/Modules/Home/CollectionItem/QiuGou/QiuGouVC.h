//
//  QiuGouVC.h
//  YQW
//
//  Created by Sunshine on 2017/5/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"

typedef NS_ENUM(NSInteger, QiuGouType) {
    largeBuy,           //大单
    separateBuy         //散单
};

@interface QiuGouVC : BaseVC

@property (nonatomic, assign) QiuGouType BuyType;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *DMArr;               //配送方式Data
@property (nonatomic, strong) NSArray *paymentArr;          //付款方式Data
@property (nonatomic, strong) NSArray *payArr;              //支付方式Data

@property (nonatomic, strong) NSArray *lgTitleArr;
@property (nonatomic, strong) NSArray *spTitleArr;

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
@property (nonatomic, strong) UILabel *shippingAddress;      //收货地址
@property (nonatomic, strong) UILabel *receivingTime;        //收货时间
@property (nonatomic, strong) UILabel *invoice;              //发票
@property (nonatomic, strong) UILabel *airSource;            //气源
@property (nonatomic, strong) UILabel *otherNeed;            //其他需求


@end
