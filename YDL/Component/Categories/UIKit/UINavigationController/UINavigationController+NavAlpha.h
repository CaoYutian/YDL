//
//  UINavigationController+NavAlpha.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (NavAlpha)

@end

@interface UIViewController (NavAlpha)

/// navAlpha
@property (nonatomic, assign) CGFloat navAlpha;

/// navbackgroundColor
@property (null_resettable, nonatomic, strong) UIColor *navBarTintColor;

/// tintColor
@property (null_resettable, nonatomic, strong) UIColor *navTintColor;

@end
