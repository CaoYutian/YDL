//
//  BaseTableViewDelegate.h
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/21.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^CellSelectBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef CGFloat (^CellHeightBlock)(UITableView *tableView, NSIndexPath *indexPath);
typedef NSArray * (^EditActionsForRowAtIndexPath)(UITableView *tableView, NSIndexPath *indexPath);

@interface BaseTableViewDelegate : NSObject<UITableViewDelegate>

@property(nonatomic, copy  ) CellHeightBlock cellHeightBlock;
@property(nonatomic, copy  ) CellSelectBlock cellSelectBlock;
@property(nonatomic, copy  ) EditActionsForRowAtIndexPath editActionsForRowAtIndexPath;

@property(nonatomic, assign) BOOL clearSeperatorInset;

@end
