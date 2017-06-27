//
//  PopupMenu.h
//  YQW
//
//  Created by Sunshine on 2017/6/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^CellSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);

@interface PopupMenu : UIView
@property(nonatomic,copy)NSArray *dataArray;
@property(nonatomic,assign)NSInteger maxRowCount;
@property(nonatomic, copy)CellSelectBlock cellSelectBlock;
-(void)show;

@end
