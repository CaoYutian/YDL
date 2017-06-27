//
//  GuideView.h
//  YQW
//
//  Created by Sunshine on 2017/6/7.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideView : UIView

//点击进入app首页的按钮
@property(nonatomic,strong) UIButton * goInButton;

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray;

@end
