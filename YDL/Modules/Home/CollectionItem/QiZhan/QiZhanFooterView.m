//
//  QiZhanFooterView.m
//  YQW
//
//  Created by Sunshine on 2017/5/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QiZhanFooterView.h"

@implementation QiZhanFooterView{
    void(^_block) (NSInteger choose);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI:frame];
    }
    return self;
}

- (void)SetUpUI:(CGRect)frame {
    
    UIView * viewFollowSV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, 49)];
    viewFollowSV.backgroundColor = whiteColor;
    
    NSArray * imgNameArr = @[@"home_buy",@"home_sandan",@"home_dadan"];
    NSArray * titleArr = @[@"立即采购",@"散单求购",@"大单求购"];
    CGFloat width = CYTMainScreen_WIDTH / imgNameArr.count;
    for (int i = 0; i < titleArr.count; i++) {
        
        UIView * cellView = [[UIView alloc]initWithFrame:CGRectMake(i*width, 0, width, 49)];
        cellView.userInteractionEnabled = YES;
        cellView.tag = 100 + i;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapCellView:)];
        [cellView addGestureRecognizer:tap];
        
        // 服务选择区
        UIImageView * imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 28)];
        imgview.center = CGPointMake(width/2, 15);
        imgview.image = IMAGENAMED(imgNameArr[i]);
        imgview.userInteractionEnabled = YES;
        [cellView addSubview:imgview];
        
        // title
        UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, width, 19)];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = titleArr[i];
        titleLabel.font = FitFont(12);
        titleLabel.userInteractionEnabled = YES;
        
        [cellView addSubview:titleLabel];
        [viewFollowSV addSubview:cellView];
    }
    [self addSubview:viewFollowSV];
}

- (void)functionChooseCallBack:(functionChoose)callBack {
    _block = callBack;
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

@end
