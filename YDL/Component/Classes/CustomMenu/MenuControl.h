//
//  MenuControl.h
//  YQW
//
//  Created by Sunshine on 2017/5/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MenuControl;
@protocol MenuControlDelegate <NSObject>
-(void)menuCtrl:(MenuControl *)menuCtrl didSelectIndex:(NSInteger)index;
@end

@interface MenuControl : UIView
@property(nonatomic,copy)UIFont *font;
@property(nonatomic,copy)UIFont *selectedFont;
@property(nonatomic,copy)UIColor *textColor;
@property(nonatomic,copy)UIColor *selectedTextColor;
@property(nonatomic,copy)UIColor *indicatorColor;
@property(nonatomic,copy)NSArray *titles;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,strong)UIView *indicatorLine;
@property(nonatomic,assign)CGFloat indicatorInset;
@property(nonatomic,assign)BOOL animating;
@property(nonatomic,weak)id<MenuControlDelegate>delegate;
@end

@interface MenuContainer : UIView
@property(nonatomic,strong)MenuControl *menuCtrl;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,retain)NSArray *childViewControlllers;
@property(nonatomic,retain)NSArray *childViews;
@property(nonatomic,assign)BOOL scrollAnimated;
@property(nonatomic,copy)VoidBlock indexChangeBlock;
@end

