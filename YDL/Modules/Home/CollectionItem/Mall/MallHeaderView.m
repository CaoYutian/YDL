//
//  MallHeaderView.m
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MallHeaderView.h"

@implementation MallHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI:frame];
    }
    return self;
}

- (void)SetUpUI:(CGRect)frame {
    
    UIView *HeaderView = [[UIView alloc] initWithFrame:frame];
    [self addSubview:HeaderView];
}

@end
