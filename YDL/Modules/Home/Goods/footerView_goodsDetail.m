//
//  footerView_goodsDetail.m
//  YQW
//
//  Created by Sunshine on 2017/5/18.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "footerView_goodsDetail.h"

@implementation footerView_goodsDetail{
    void (^_blcok) (NSInteger Choose);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI];
    }
    return self;
}

- (void)SetUpUI {
    
    UIView * viewFollowSV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(40))];
    viewFollowSV.backgroundColor = whiteColor;
    
    NSArray * imgNameArr = @[@"contactMerchant_msg",@"contactMerchant_phone"];
    NSArray * titleArr = @[@"联系商家",@"拨打电话"];
    CGFloat width = CYTMainScreen_WIDTH / imgNameArr.count / 2;
    for (int i = 0; i < titleArr.count; i++) {
        
        UIView * cellView = [[UIView alloc]initWithFrame:CGRectMake(i*width, 0, width, FitheightRealValue(40))];
        if (i == 0) {
            [cellView setTapActionWithBlock:^{
                [self ContactTheMerchant];
            }];
        }else {
            [cellView setTapActionWithBlock:^{
                [self callUp];
            }];
        }
        
        // 服务选择区
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, FitheightRealValue(2.5), FitwidthRealValue(20), FitwidthRealValue(20))];
        imgview.center = CGPointMake(width/2, FitheightRealValue(12.5));
        imgview.image = IMAGENAMED(imgNameArr[i]);
        imgview.userInteractionEnabled = YES;
        [cellView addSubview:imgview];
        
        // title
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, FitheightRealValue(25), width, FitheightRealValue(15))];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleArr[i];
        titleLabel.font = FitFont(10);
        titleLabel.userInteractionEnabled = YES;
        
        [cellView addSubview:titleLabel];
        [viewFollowSV addSubview:cellView];
    }
    
    [CYTUtiltyHelper addbuttonWithRect:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(100), 0, FitwidthRealValue(100), FitheightRealValue(40)) LabelText:@"立即购买" TextFont:FitFont(14) NormalTextColor:whiteColor highLightTextColor:whiteColor NormalBgColor:[UIColor orangeColor] highLightBgColor:[UIColor orangeColor] tag:111 SuperView:viewFollowSV buttonTarget:self Action:@selector(buyNow:)];
    
    [self addSubview:viewFollowSV];
    
}

- (void)ChooseOperationCallBack:(ChooseOperation)callBack {
    _blcok = callBack;
}

#pragma mark 联系商家
- (void)ContactTheMerchant {
    if (_blcok) {
        _blcok(1);
    }
}

- (void)callUp {
    if (_blcok) {
        _blcok(2);
    }
}

- (void)buyNow:(UIButton *)btn {
    if (_blcok) {
        _blcok(3);
    }
}

@end
