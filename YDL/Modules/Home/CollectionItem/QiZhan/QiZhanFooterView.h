//
//  QiZhanFooterView.h
//  YQW
//
//  Created by Sunshine on 2017/5/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^functionChoose) (NSInteger choose);

@interface QiZhanFooterView : UIView

- (void)functionChooseCallBack:(functionChoose)callBack;

@end
