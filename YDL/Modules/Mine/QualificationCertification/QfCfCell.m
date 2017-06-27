//
//  QfCfCell.m
//  YQW
//
//  Created by Sunshine on 2017/6/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QfCfCell.h"

@implementation QfCfCell{
    void (^_blcok)(BOOL isSelected);
}

- (void)awakeFromNib {
    [super awakeFromNib];

    self.operationBtn.backgroundColor = RGBA(98, 199, 155, 1.0);
    self.operationBtn.layer.cornerRadius = 5;
    self.operationBtn.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)ChooseOpration:(ChooseOpration)callBack {
    _blcok = callBack;
}

- (IBAction)operationOfFile:(id)sender {
    if (_blcok) {
        _blcok(YES);
    }
}

@end
