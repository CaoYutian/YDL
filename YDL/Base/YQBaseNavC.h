//
//  YQBaseNavC.h
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YQBaseNavC : UINavigationController

+ (void)initialize;

- (void)addFullScreenPopBlackListItem:(UIViewController *)viewController;
- (void)removeFromFullScreenPopBlackList:(UIViewController *)viewController;

@end
