//
//  HeaderView_Home.m
//  YQW
//
//  Created by Sunshine on 2017/5/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "HeaderView_Home.h"
#import "GoodsDynamicModel.h"

@implementation HeaderView_Home{
    void(^_block) (NSInteger choose);
}

- (instancetype)initWithFrame:(CGRect)frame ShufflingFigureData:(NSArray *)ShufflingFigureData {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.ShufflingFigure = [ShufflingFigureView zlImageViewDisplayViewWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(193))];
        self.ShufflingFigure.scrollInterval = ShufflingFigureData.count;
        self.ShufflingFigure.animationInterVale = 0.6;
        
//        NSMutableArray *PicList = [NSMutableArray new];
//        for (GoodsDynamicModel *model in ShufflingFigureData) {
//            [PicList addObject:model.goods_picture];
//        }
        
        [self addSubview:self.ShufflingFigure];
        
        self.ShufflingFigure.imageViewArray = ShufflingFigureData;
        
        [self SetUpBannerView];
        
    }
    return self;
}

- (void)SetUpBannerView {
    UIView * viewFollowSV = [[UIView alloc]initWithFrame:CGRectMake(0, self.ShufflingFigure.bottom + FitheightRealValue(8), CYTMainScreen_WIDTH, FitheightRealValue(80))];
    viewFollowSV.backgroundColor = whiteColor;
    
    NSArray * imgNameArr = @[@"mall",@"demand",@"PurchaseAgreement",@"QiZhan"];
    NSArray * titleArr = @[@"进入商城",@"发布需求",@"采购协议",@"我的气站"];
    CGFloat width = CYTMainScreen_WIDTH / imgNameArr.count;
    for (int i = 0; i < titleArr.count; i++) {
        
        UIView * cellView = [[UIView alloc]initWithFrame:CGRectMake(i*width, 0, width, FitheightRealValue(80))];
        cellView.userInteractionEnabled = YES;
        cellView.tag = 100 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCellView:)];
        [cellView addGestureRecognizer:tap];
        
        // 服务选择区
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, FitwidthRealValue(45), FitwidthRealValue(45))];
        imgview.center = CGPointMake(width/2, FitheightRealValue(30));
        imgview.image = IMAGENAMED(imgNameArr[i]);
        imgview.userInteractionEnabled = YES;
        [cellView addSubview:imgview];
        
        // title
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, FitheightRealValue(50), width, FitheightRealValue(30))];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleArr[i];
        titleLabel.font = FitFont(12);
        titleLabel.userInteractionEnabled = YES;
        
        [cellView addSubview:titleLabel];
        [viewFollowSV addSubview:cellView];
    }
    [self addSubview:viewFollowSV];
}

- (void)tapCellView:(UIGestureRecognizer *)tap {
    
    NSInteger index = tap.view.tag - 100;
    switch (index) {
        case 0:
            if (_block) {
                _block(0);
            }
            break;
            
        case 1:
            if (_block) {
                _block(1);
            }
            break;
            
        case 2:
            if (_block) {
                _block(2);
            }
            break;
            
        case 3:
            if (_block) {
                _block(3);
            }
            break;
    }
    
}

- (void)functionChooseCallBack:(functionChoose)callBack {
    _block = callBack;
}

@end
