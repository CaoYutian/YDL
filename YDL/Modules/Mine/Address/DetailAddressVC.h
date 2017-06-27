//
//  DetailAddressVC.h
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"
#import "AddressPickerModel.h"
typedef NS_ENUM(NSInteger, SelectAddressType) {
    SelectAddressTypeHome         , // 家庭住址
    SelectAddressTypeField          // 田块地址
};

typedef void (^IdBlock)(id object);

@interface DetailAddressVC : BaseVC

@property(nonatomic,strong)NSArray *selections; // 选择的三个下标
@property(nonatomic,copy)IdBlock selectAddressBlock;
@property(nonatomic,strong)AddressPickerModel *addressData;
- (instancetype)initWithSelectAddressType:(SelectAddressType)selectAddressType;

@end
