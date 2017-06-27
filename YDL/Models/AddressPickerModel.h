//
//  AddressPickerModel.h
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GeoModel;
/**
 *  选择地址Model
 */
@interface AddressPickerModel : NSObject
//省
@property(nonatomic,copy)GeoModel *provinceInfo;
//城市
@property(nonatomic,copy)GeoModel *cityInfo;
//区县
@property(nonatomic,copy)GeoModel *countyInfo;
//镇
@property(nonatomic,copy)GeoModel *townInfo;
//详细地址
@property(nonatomic,copy)NSString *detailAddress;
//周边检索地址
@property(nonatomic,copy)NSString *poiAddress;
//周边检索名称
@property(nonatomic,copy)NSString *poiName;
//纬度
@property(nonatomic,copy)NSNumber *latitude;
//经度
@property(nonatomic,copy)NSNumber *longitude;
//获取完整地址
@property(nonatomic,copy)NSString *fullAddress;
//地区
@property(nonatomic,copy)NSString *region;
@end

/**
 *  地理位置Model
 */
@interface GeoModel : NSObject
@property(nonatomic,copy)NSString *geoId;
@property(nonatomic,copy)NSString *geoName;
@property(nonatomic,copy)NSArray *subGeoList;
@end

@interface AddressListModel : NSObject

/** id */
@property(nonatomic, copy) NSString *user_id;
/** 地址ID */
@property (nonatomic,copy) NSString *receiver_address_id;
/** 姓名 */
@property (nonatomic,copy) NSString *receiver_name;
/** 详细地址 */
@property (nonatomic,copy) NSString *address_detail;
/** 经度 */
@property (nonatomic,copy) NSString *longitude;
/** 纬度 */
@property (nonatomic,copy) NSString *latitude;
/** 手机号 */
@property (nonatomic,copy) NSString *receiver_phone;
/** 默认 */
@property(nonatomic, assign) BOOL is_default;
/** 手机号 */
@property (nonatomic,copy) AddressPickerModel *pickerAddress;

@end
