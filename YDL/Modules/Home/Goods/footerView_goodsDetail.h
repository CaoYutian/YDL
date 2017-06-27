//
//  footerView_goodsDetail.h
//  YQW
//
//  Created by Sunshine on 2017/5/18.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ChooseOperation) (NSInteger Choose);
@interface footerView_goodsDetail : UIView

- (void)ChooseOperationCallBack:(ChooseOperation)callBack;

@end
