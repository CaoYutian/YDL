//
//  BaseTableViewCell.m
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/21.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView {
    
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)cellHeight:(id)item atIndexPath:(NSIndexPath *)indexPath {
    if (self.isAutoHeight) {
        return [self cellAutoHeight:item atIndexPath:indexPath];
    }
    else {
        return TableViewCellDefaultHeight;
    }
}

- (CGFloat)cellAutoHeight:(id)item atIndexPath:(NSIndexPath *)indexPath {
    if (_cellConfigureBlock) {
        _cellConfigureBlock(self, item, indexPath);
    }
    [self setCellData:item atIndexPath:indexPath];
    
    [self layoutIfNeeded];
    [self updateConstraintsIfNeeded];
    
    CGFloat height = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height;
}

- (BOOL)isAutoHeight {
    return YES;
}

@end
