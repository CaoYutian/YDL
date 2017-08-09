//
//  LargeTitleScrollView.m
//  YQW
//
//  Created by Sunshine on 2017/5/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "LargeTitleScrollView.h"
#import "Masonry.h"

#define BTNWIDTH FitwidthRealValue(80.0)

@interface LargeTitleScrollView()<UIScrollViewDelegate>{
    int _currentIndex;
}
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) NSArray *headArray;

@end

@implementation LargeTitleScrollView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles{
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.headArray = titles;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.backgroundColor = whiteColor;
    self.contentSize = CGSizeMake(BTNWIDTH * self.headArray.count, 0);
    self.bounces = NO;
    
    for (int i = 0; i < [self.headArray count]; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        button.titleLabel.font = FitFont(14);
        button.frame = CGRectMake(0 + BTNWIDTH*i, 0, BTNWIDTH, FitheightRealValue(40));
        button.titleLabel.font = FitFont(14);
        [button setTitle:[self.headArray objectAtIndex:i] forState:UIControlStateNormal];
        [button setTitleColor:blackColor forState:UIControlStateNormal];
        if (i == 0) {
            [button setTitleColor:NavigationBarBackgroundColor forState:UIControlStateNormal];
        }
        button.tag = i;
        [button addTarget:self action:@selector(didClickHeaderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
    }
    UIView *lineView = [[UIView alloc] init];
    self.lineView = lineView;
    lineView.backgroundColor = NavigationBarBackgroundColor;
    lineView.frame = CGRectMake(FitwidthRealValue(10.0f), FitheightRealValue(38), FitwidthRealValue(60.0f), FitheightRealValue(2));
    [self addSubview:lineView];
    
}

- (void)didClickHeaderButtonAction:(UIButton *)btn{
    
    _currentIndex = (int)btn.tag;
    [self changeBtnTitleColorWith:_currentIndex];
    
    if ([self.seletedDelegate respondsToSelector:@selector(seletedLargeDelegatWith:)]) {
        [self.seletedDelegate seletedLargeDelegatWith:btn];
    }
    if (self.selectedAtIndex){
        self.selectedAtIndex((int)_currentIndex);
    }
}

-(void)changeBtnTitleColorWith:(int)tag{
    [self.subviews enumerateObjectsUsingBlock:^(__kindof UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIButton class]]) {
            if (obj.tag == tag) {
                [obj setTitleColor:NavigationBarBackgroundColor forState:UIControlStateNormal];
                if (obj.frame.origin.x >= CYTMainScreen_WIDTH / 2 && obj.frame.origin.x <= self.contentSize.width - CYTMainScreen_WIDTH / 2) {
                    [UIView animateWithDuration:.25 animations:^{
                        self.contentOffset = CGPointMake(obj.frame.origin.x - CYTMainScreen_WIDTH / 2 + FitheightRealValue(40), 0);
                        obj.titleLabel.font = FitFont(14);
                        self.lineView.centerX = obj.centerX;
                    }];
                }
                if (obj.frame.origin.x < CYTMainScreen_WIDTH / 2) {
                    [UIView animateWithDuration:.25 animations:^{
                        self.contentOffset = CGPointMake(0, 0);
                        obj.titleLabel.font = FitFont(14);
                        self.lineView.centerX = obj.centerX;
                    }];
                }
                if (obj.frame.origin.x >= self.contentSize.width - CYTMainScreen_WIDTH / 2) {
                    [UIView animateWithDuration:.25 animations:^{
                        obj.titleLabel.font = FitFont(14);
                        self.lineView.centerX = obj.centerX;
                    }];
                }
                
            }else{
                [obj setTitleColor:blackColor forState:UIControlStateNormal];
                obj.titleLabel.font = FitFont(14);
            }
        }
        
    }];
}


@end
