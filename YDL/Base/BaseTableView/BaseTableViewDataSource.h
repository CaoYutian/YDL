//
//  BaseTableViewDataSource.h
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/21.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^CellConfigureBlock)(UITableViewCell *cell, id data, NSIndexPath *indexPath);
typedef NSInteger (^CellCountBlock)(UITableView *tableView, NSInteger section);

@interface BaseTableViewDataSource : NSObject<UITableViewDataSource>

@property (nonatomic, strong) NSArray *items;

@property(nonatomic, copy)CellCountBlock cellCountBlock;

- (instancetype)initWithItems:(NSArray *)items cellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

- (instancetype)initWithCellIdentifier:(NSString *)cellIdentifier cellConfigureBlock:(CellConfigureBlock)cellConfigureBlock;

@end
