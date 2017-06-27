//
//  LargeTitleScrollView.h
//  YQW
//
//  Created by Sunshine on 2017/5/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol seletedLargeDelegate <NSObject>

- (void)seletedLargeDelegatWith:(UIButton *)btn;

@end

@interface LargeTitleScrollView : UIScrollView

@property (nonatomic, weak) id <seletedLargeDelegate>seletedDelegate;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray*)titles;

- (void)changeBtnTitleColorWith:(int)tag;

//callback block
@property (nonatomic, copy) void (^selectedAtIndex)(int index);

@end
