//
//  LargeClassMenuView.h
//  AICAIPU
//
//  Created by 。。。 on 16/8/18.
//  Copyright © 2016年 北京一速互联信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeClassMenuView : UIView

@property (nonatomic, assign) CGFloat width;

// cell color default [UIColor colorWithRed:0.296 green:0.613 blue:1.000 alpha:1.000]
@property (nonatomic, strong) UIColor *cellColor;

// cell seprator color default whiteColor
@property (nonatomic, strong) UIColor *cellSeparatorColor;

// cell accessory check mark color default whiteColor
@property (nonatomic, strong) UIColor *cellAccessoryCheckmarkColor;

// cell height default 44
@property (nonatomic, assign) CGFloat cellHeight;

// animation duration default 0.4
@property (nonatomic, assign) CGFloat animationDuration;

// text color default whiteColor
@property (nonatomic, strong) UIColor *textColor;

// text font default system 17
@property (nonatomic, strong) UIFont *textFont;

// background opacity default 0.3
@property (nonatomic, assign) CGFloat backgroundAlpha;

// callback block
@property (nonatomic, copy) void (^selectedAtIndex)(int index);

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles;

@property (nonatomic, assign) BOOL isMenuShow;

@property (nonatomic, strong) UIButton *BottomBtn;

@property (nonatomic, assign) NSUInteger selectedIndex;

@end
