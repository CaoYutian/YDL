//
//  LoginTranslation.h
//  YQW
//
//  Created by Sunshine on 2017/6/7.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface LoginTranslation : NSObject<UIViewControllerAnimatedTransitioning>

@property (assign, nonatomic) BOOL reverse;

- (instancetype)initWithView:(UIView*)btnView;
- (void)stopAnimation;

@end
