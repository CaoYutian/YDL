//
//  GoodsCell_Mall.m
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "GoodsCell_Mall.h"

@interface GoodsCell_Mall ()

@property (nonatomic, strong) UIImageView *timePic;
@property (nonatomic, strong) UILabel *timeInterval;
@property (nonatomic, strong) UILabel *gainStyle;
@property (nonatomic, strong) UILabel *payStyle;


@property (nonatomic, strong) UIImageView *icon_gasPic;
@property (nonatomic, strong) UILabel *buyers;

@property (nonatomic, strong) UIImageView *main_sellerPic;
@property (nonatomic, strong) UILabel *company;
@property (nonatomic, strong) UIImageView *contentPic;
@property (nonatomic, strong) UILabel *content;

@property (nonatomic, strong) UILabel *unitPrice;
@property (nonatomic, strong) UILabel *unit;

@property (nonatomic, strong) UIView *line;

@end

@implementation GoodsCell_Mall

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView {
    
    self.contentView.backgroundColor = whiteColor;
    
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = MainBackgroundColor;
    [self.contentView addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(FitheightRealValue(10));
        make.top.equalTo(self.contentView);
    }];
    
    //第一行公司 及 图片
    [self.contentView addSubview:self.icon_gasPic];
    [self.icon_gasPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.line.mas_bottom).offset(FitheightRealValue(5));
        make.left.equalTo(self.contentView.mas_left).offset(FitwidthRealValue(13));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(15), FitheightRealValue(16)));
    }];
    
    [self.contentView addSubview:self.buyers];
    self.buyers.font = FitFont(14);
    [self.buyers mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon_gasPic.mas_right).offset(FitwidthRealValue(10));
        make.top.equalTo(self.line.mas_bottom).offset(FitheightRealValue(5));
        make.height.mas_equalTo(FitheightRealValue(20));
    }];
    
    [self.contentView addSubview:self.gainStyle];
    [self.gainStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.buyers.mas_right).offset(FitwidthRealValue(20));
        make.centerY.mas_equalTo(self.buyers.mas_centerY);
    }];
    
    [self.contentView addSubview:self.payStyle];
    [self.payStyle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.gainStyle.mas_right).offset(FitwidthRealValue(5));
        make.centerY.mas_equalTo(self.buyers.mas_centerY);
    }];

    
    //第二行时间区间 及图片
    [self.contentView addSubview:self.timePic];
    [self.timePic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.icon_gasPic.mas_bottom).offset(FitheightRealValue(5));
        make.left.equalTo(self.contentView).offset(FitwidthRealValue(13));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(15), FitheightRealValue(15)));
        
    }];
    
    [self.contentView addSubview:self.timeInterval];
    self.timeInterval.font = FitFont(12);
    self.timeInterval.textColor = [UIColor grayColor];
    [self.timeInterval mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timePic.mas_right).offset(FitwidthRealValue(10));
        make.centerY.mas_equalTo(self.timePic.mas_centerY);
    }];
    
    //第三行商品信息 及图片
    [self.contentView addSubview:self.main_sellerPic];
    [self.main_sellerPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timePic.mas_bottom).offset(FitheightRealValue(5));
        make.left.equalTo(self.contentView).offset(FitwidthRealValue(13));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(15), FitheightRealValue(16)));
    }];
    
    [self.contentView addSubview:self.contentPic];
    [self.contentPic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.main_sellerPic.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-FitwidthRealValue(80));
        make.size.mas_equalTo(CGSizeMake(FitwidthRealValue(15), FitheightRealValue(16)));
    }];
    
    [self.contentView addSubview:self.content];
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.main_sellerPic.mas_centerY);
        make.right.equalTo(self.contentView.mas_right).offset(-FitwidthRealValue(13));
    }];
    
    [self.contentView addSubview:self.company];
    self.company.font = FitFont(12);
    self.company.textColor = [UIColor grayColor];
    [self.company mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.main_sellerPic.mas_right).offset(FitwidthRealValue(10));
        make.right.equalTo(self.contentPic.mas_left).offset(-FitwidthRealValue(5));
        make.centerY.mas_equalTo(self.main_sellerPic.mas_centerY);
        make.bottom.equalTo(self.contentView).offset(-FitheightRealValue(10));
    }];
    
    
    [self.contentView addSubview:self.unitPrice];
    self.unitPrice.font = FitFont(12);
    self.unitPrice.textColor = [UIColor redColor];
    [self.unitPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(FitwidthRealValue(-13));
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_equalTo(FitheightRealValue(20));
    }];
    
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    
    GoodsModel *goodsData = (GoodsModel *)item;
    
    self.icon_gasPic.image = IMAGENAMED(@"icon_gas");
    self.buyers.text = goodsData.goods_title;
    self.gainStyle.text = @" 自提 ";
    self.payStyle.text = @" 预付 ";
    
    self.timePic.image = IMAGENAMED(@"icon_open_time");
    self.timeInterval.text = @"2017-05-11 ~ 2017-05-31";
    
    self.main_sellerPic.image = IMAGENAMED(@"main_seller_name");
    self.company.text = goodsData.goods_details;
    self.contentPic.image = IMAGENAMED(@"main_seller_name");
    self.content.text = @"10000吨";
    
    self.unitPrice.text = [NSString stringWithFormat:@"%@元/吨", goodsData.goods_count];
    
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

- (UILabel *)gainStyle {
    if (!_gainStyle) {
        _gainStyle = [[UILabel alloc] init];
        _gainStyle.textColor = NavigationBarBackgroundColor;
        _gainStyle.font = FitFont(10);
        _gainStyle.layer.borderColor = NavigationBarBackgroundColor.CGColor;
        _gainStyle.layer.borderWidth = 0.5f;
    }
    return _gainStyle;
}

- (UILabel *)payStyle {
    if (!_payStyle) {
        _payStyle = [[UILabel alloc] init];
        _payStyle.textColor = [UIColor greenColor];
        _payStyle.font = FitFont(10);
        _payStyle.layer.borderColor = [UIColor greenColor].CGColor;
        _payStyle.layer.borderWidth = 0.5f;
    }
    return _payStyle;
}

- (UIImageView *)timePic {
    if (!_timePic) {
        _timePic = [[UIImageView alloc] init];
    }
    return _timePic;
}

- (UILabel *)timeInterval {
    if (!_timeInterval) {
        _timeInterval = [[UILabel alloc] init];
    }
    return _timeInterval;
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

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.textAlignment = NSTextAlignmentRight;
        _content.font = FitFont(12);
        _content.textColor = [UIColor grayColor];
    }
    return _content;
}

- (UIImageView *)contentPic {
    if (!_contentPic) {
        _contentPic = [[UIImageView alloc] init];
    }
    return _contentPic;
}

- (UILabel *)unitPrice {
    if (!_unitPrice) {
        _unitPrice = [[UILabel alloc] init];
    }
    return _unitPrice;
}

@end
