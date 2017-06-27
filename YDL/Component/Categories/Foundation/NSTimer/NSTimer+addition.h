//
//  NSTimer+addition.h
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (addition)

- (void)pause;
- (void)resume;
- (void)resumeWithTimeInterval:(NSTimeInterval)time;

@end
