//
//  CYTWebProgressLayer.h
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface CYTWebProgressLayer : CAShapeLayer

- (void)finishedLoad;
- (void)startLoad;

- (void)closeTimer;

@end
