//
//  PopUpPickerView.h
//  YQW
//
//  Created by Sunshine on 2017/6/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopUpPickerView;
@protocol PopUpMenuDataSource <NSObject>
- (NSInteger)numberOfComponentsInPickerView:(PopUpPickerView *)popUpMenu;
- (NSInteger)popUpMenu:(PopUpPickerView *)popUpMenu numberOfRowsInComponent:(NSInteger)component;
@end

@protocol PopUpMenuDelegate <NSObject>
- (NSString *)popUpMenu:(PopUpPickerView *)popUpMenu titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)popUpMenu:(PopUpPickerView *)popUpMenu didSelectRowArray:(NSArray *)rowArray;
@end

@interface PopUpPickerView : UIView
@property(nonatomic,retain)NSMutableArray *selectedRowArray;
@property(nonatomic,weak)id<PopUpMenuDataSource>dataSource;
@property(nonatomic,weak)id<PopUpMenuDelegate>delegate;
- (void)reloadData;
- (void)show;

@end
