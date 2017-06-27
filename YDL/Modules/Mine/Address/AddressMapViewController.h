//
//  AddressMapViewController.h
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"
#import "AddressPickerModel.h"

typedef void (^IdBlock)(id object);

@interface AddressMapViewController : BaseVC

@property(nonatomic,copy)IdBlock selectAddressBlock;
@property (nonatomic,strong) AddressPickerModel *addressData;

@end
