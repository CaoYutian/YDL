//
//  QIYuanDiOfQiuGouCell.m
//  YQW
//
//  Created by Sunshine on 2017/6/13.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QIYuanDiOfQiuGouCell.h"

@implementation QIYuanDiOfQiuGouCell{
    void (^_block) (BOOL index);
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self buildCellView];
    }
    return self;
}

- (void)buildCellView{
    
   self.lngTitle = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH - FitwidthRealValue(100), FitheightRealValue(44)) SuperView:self.contentView LabelTag:200 LabelText:@"" Font:FitFont(14)];
    
    self.deleteBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(33), FitheightRealValue(12), FitwidthRealValue(20), FitheightRealValue(20)) NormalbgImageStr:@"deleteGasAdrr" highLightbgimageStr:@"deleteGasAdrr" tag:201 SuperView:self.contentView buttonTarget:self Action:@selector(deleteAction)];
    
}

- (void)setCellData:(id)item atIndexPath:(NSIndexPath *)indexPath {
    self.lngTitle.text = @"测试";
    [self.deleteBtn setImage:IMAGENAMED(@"deleteGasAdrr") forState:UIControlStateNormal];

}

- (void)callBack:(isSelected)callBack {
    _block = callBack;
}

- (void)deleteAction {
    if (_block) {
        _block(YES);
    }
}

@end
