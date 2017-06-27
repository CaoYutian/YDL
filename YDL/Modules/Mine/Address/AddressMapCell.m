//
//  AddressMapCell.m
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AddressMapCell.h"

@interface AddressMapCell ()
@property(nonatomic,strong)UILabel *addressNameLabel;
@property(nonatomic,strong)UILabel *fullAddressLabel;
@end

@implementation AddressMapCell

-(void)buildCellView
{
    [self.contentView addSubview:self.addressNameLabel];
    [self.contentView addSubview:self.fullAddressLabel];
    [self.contentView addSubview:self.selectedIcon];
    [self.addressNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_SPACE);
        make.right.mas_equalTo(self.selectedIcon.mas_left).offset(-5);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(16);
    }];
    [self.fullAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(MARGIN_SPACE);
        make.top.mas_equalTo(self.addressNameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(self.selectedIcon.mas_left).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    [self.selectedIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-MARGIN_SPACE);
        make.width.height.mas_equalTo(20);
    }];
}

-(void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath
{
    AddressPickerModel *addressPickerData = (AddressPickerModel *)self.item;
    self.addressNameLabel.text = addressPickerData.poiName;
    self.fullAddressLabel.text = addressPickerData.fullAddress;
}

#pragma mark - getters and setters
-(UILabel *)addressNameLabel
{
    if (!_addressNameLabel) {
        _addressNameLabel = [[UILabel alloc] init];
        _addressNameLabel.font = [UIFont systemFontOfSize:16];
    }
    return _addressNameLabel;
}

-(UILabel *)fullAddressLabel
{
    if (!_fullAddressLabel) {
        _fullAddressLabel = [[UILabel alloc] init];
        _fullAddressLabel.font = FONT_NORMAL;
    }
    return _fullAddressLabel;
}

-(UIImageView *)selectedIcon
{
    if (!_selectedIcon) {
        _selectedIcon = [[UIImageView alloc] init];
        _selectedIcon.image = [UIImage imageNamed:@"ic_location_selected"];
    }
    return _selectedIcon;
}

@end
