//
//  QIYuanDiOfQiuGouCell.h
//  YQW
//
//  Created by Sunshine on 2017/6/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseTableViewCell.h"
typedef void(^isSelected) (BOOL index);

@interface QIYuanDiOfQiuGouCell : BaseTableViewCell

@property (nonatomic, strong) UILabel *lngTitle;
@property (nonatomic, strong) UIButton *deleteBtn;

- (void)callBack:(isSelected)callBack;


@end
