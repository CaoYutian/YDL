//
//  HeaderOfmine.h
//  YQW
//
//  Created by Sunshine on 2017/5/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^isClickHeadePortrait) (BOOL isClick);
@interface HeaderOfmine : UIView

- (void)callBack:(isClickHeadePortrait)callBack;

@end
