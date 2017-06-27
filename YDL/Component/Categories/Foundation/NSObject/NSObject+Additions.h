//
//  NSObject+Additions.h
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/20.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>

NSString* safeString(id obj);
NSNumber* safeNumber(id obj);

@interface NSObject (Additions)

- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;

@end
