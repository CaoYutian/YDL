//
//  BaseTableViewCell.h
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/21.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableViewDataSource.h"

#define TableViewCellDefaultHeight 44.0

@interface BaseTableViewCell : UITableViewCell

//子类覆盖get方法设置是否自动计算高度
@property(nonatomic, assign) BOOL           isAutoHeight;
@property(nonatomic, strong) id             item;
@property(nonatomic, strong) NSIndexPath    *indexPath;
@property(nonatomic, copy  ) CellConfigureBlock cellConfigureBlock;

- (void)buildCellView;
- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellHeight:(id)item atIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)cellAutoHeight:(id)item atIndexPath:(NSIndexPath *)indexPath;

@end
