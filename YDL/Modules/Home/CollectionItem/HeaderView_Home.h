//
//  HeaderView_Home.h
//  YQW
//
//  Created by Sunshine on 2017/5/10.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShufflingFigureView.h"

typedef void(^functionChoose) (NSInteger choose);
@interface HeaderView_Home : UIView

@property (nonatomic, strong) ShufflingFigureView *ShufflingFigure;

- (instancetype)initWithFrame:(CGRect)frame ShufflingFigureData:(NSArray *)ShufflingFigureData;

- (void)functionChooseCallBack:(functionChoose)callBack;
@end
