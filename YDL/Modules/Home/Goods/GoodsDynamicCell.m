//
//  GoodsDynamicCell.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "GoodsDynamicCell.h"

@interface GoodsDynamicCell ()

@property (nonatomic, strong) UIImageView *icon_gasPic;
@property (nonatomic, strong) UILabel *buyers;

@property (nonatomic, strong) UIImageView *main_sellerPic;
@property (nonatomic, strong) UILabel *company;

@property (nonatomic, strong) UILabel *unitPrice;
@property (nonatomic, strong) UILabel *unit;

@property (nonatomic, strong) UIView *line;

@end

@implementation GoodsDynamicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}


- (void)buildCellView {
    
    self.contentView.backgroundColor = whiteColor;

    [self.contentView addSubview:self.icon_gasPic];
    [self.icon_gasPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(FitheightRealValue(5));
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(13));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(15), FitheightRealValue(16)));
    }];
    
    [self.contentView addSubview:self.buyers];
    self.buyers.font = FitFont(14);
    [self.buyers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon_gasPic.mas_right).offset(FitwidthRealValue(10));
        make.top.equalTo(self.contentView).offset(FitheightRealValue(5));
        make.height.mas_equalTo(FitheightRealValue(20));
    }];
    
    [self.contentView addSubview:self.main_sellerPic];
    [self.main_sellerPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon_gasPic.mas_bottom).offset(FitheightRealValue(5));
        make.left.equalTo(self.contentView).offset(FitwidthRealValue(13));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(15), FitheightRealValue(16)));
    }];
    
    [self.contentView addSubview:self.company];
    self.company.font = FitFont(12);
    self.company.textColor = [UIColor grayColor];
    [self.company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.main_sellerPic.mas_right).offset(FitwidthRealValue(10));
        make.centerY.mas_equalTo(self.main_sellerPic.mas_centerY);
        make.bottom.equalTo(self.contentView).offset(-FitheightRealValue(10));
    }];
    
    [self.contentView addSubview:self.unitPrice];
    self.unitPrice.font = FitFont(12);
    [self.unitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FitwidthRealValue(-5));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(FitheightRealValue(20));
    }];
    
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = MainBackgroundColor;
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(FitheightRealValue(1));
        make.bottom.equalTo(self.contentView).offset(-FitheightRealValue(0));
    }];
    
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    
    GoodsModel *goodsData = (GoodsModel *)item;
    
    self.icon_gasPic.image = IMAGENAMED(@"icon_gas");;
//    self.buyers.text = @"内蒙古乌审旗管道气";
    self.buyers.text = goodsData.goods_title;
    self.main_sellerPic.image = IMAGENAMED(@"main_seller_name");
//    self.company.text = @"鄂尔多斯市星星能源有限公司";
    self.company.text = goodsData.goods_details;
    
    NSMutableAttributedString *unitPriceAttri = [CYTUtiltyHelper addAttribute:[NSString stringWithFormat:@"%@元/吨", goodsData.goods_count] firstColorValue:[UIColor orangeColor] secondColorValue:[UIColor orangeColor] firstFont:FitFont(18) secondFont:FitFont(12) firstRange:NSMakeRange(0, goodsData.goods_count.length) secondRange:NSMakeRange(goodsData.goods_count.length, 3)];
    
    self.unitPrice.attributedText = unitPriceAttri;

}

- (UIImageView *)icon_gasPic {
    if (!_icon_gasPic) {
        _icon_gasPic = [[UIImageView alloc] init];
    }
    return _icon_gasPic;
}

- (UILabel *)buyers {
    if (!_buyers) {
        _buyers = [[UILabel alloc] init];
    }
    return _buyers;
}

- (UIImageView *)main_sellerPic {
    if (!_main_sellerPic) {
        _main_sellerPic = [[UIImageView alloc] init];
    }
    return _main_sellerPic;
}

- (UILabel *)company {
    if (!_company) {
        _company = [[UILabel alloc] init];
    }
    return _company;
}

- (UILabel *)unitPrice {
    if (!_unitPrice) {
        _unitPrice = [[UILabel alloc] init];
    }
    return _unitPrice;
}

@end
