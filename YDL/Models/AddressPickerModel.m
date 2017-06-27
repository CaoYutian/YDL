//
//  AddressPickerModel.m
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AddressPickerModel.h"

@implementation AddressPickerModel
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}

- (NSString *)fullAddress
{
    NSMutableArray *addressArray = [[NSMutableArray alloc] init];
    if (self.provinceInfo.geoName.length) {
        [addressArray addObject:self.provinceInfo.geoName];
    }
    if (self.cityInfo.geoName.length) {
        [addressArray addObject:self.cityInfo.geoName];
    }
    if (self.countyInfo.geoName.length) {
        [addressArray addObject:self.countyInfo.geoName];
    }
    if (self.townInfo.geoName.length) {
        [addressArray addObject:self.townInfo.geoName];
    }
    if (self.detailAddress.length) {
        [addressArray addObject:self.detailAddress];
    }
    return [addressArray componentsJoinedByString:@" "];
}

- (NSString *)region
{
    NSMutableArray *addressArray = [[NSMutableArray alloc] init];
    if (self.provinceInfo.geoName.length) {
        [addressArray addObject:self.provinceInfo.geoName];
    }
    if (self.cityInfo.geoName.length) {
        [addressArray addObject:self.cityInfo.geoName];
    }
    if (self.countyInfo.geoName.length) {
        [addressArray addObject:self.countyInfo.geoName];
    }
    if (self.townInfo.geoName.length) {
        [addressArray addObject:self.townInfo.geoName];
    }
    return [addressArray componentsJoinedByString:@" "];
}

@end

@implementation GeoModel
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}
@end

@implementation AddressListModel
- (id)copyWithZone:(NSZone *)zone
{
    return [self yy_modelCopy];
}

@end
