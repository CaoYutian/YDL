//
//  VersionAlertView.h
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击按钮回调
typedef void(^AlertResult)(NSInteger index);

@interface VersionAlertView : UIView

@property(nonatomic,strong)UIImageView *versionImage;
@property(nonatomic,strong)UILabel *title;//版本
@property(nonatomic,strong)UILabel *titleLabel;//内容
@property(nonatomic,strong)UIButton *closeButton;//关闭按钮
@property(nonatomic,strong)UIButton *sureBtn;//关闭按钮

@property(nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message updateBtn:(NSString *)updateTitle;
- (void)showAlertView;


@end
