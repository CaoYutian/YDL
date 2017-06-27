//
//  HeaderOfmine.m
//  YQW
//
//  Created by Sunshine on 2017/5/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "HeaderOfmine.h"

@implementation HeaderOfmine {
    void (^_block) (BOOL isClick);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self SetUpUI];
    }
    return self;
}

- (void)SetUpUI {
    
    UIImageView *HeadPortraitPic = [[UIImageView alloc] initWithFrame:CGRectMake(FitheightRealValue(13), FitwidthRealValue(40), FitwidthRealValue(70), FitwidthRealValue(70))];
    HeadPortraitPic.image = IMAGENAMED(@"AppIcon");
    HeadPortraitPic.backgroundColor = [UIColor redColor];
    HeadPortraitPic.layer.cornerRadius = FitwidthRealValue(35);
    HeadPortraitPic.layer.masksToBounds = YES;
    HeadPortraitPic.userInteractionEnabled = YES;
    UITapGestureRecognizer *Recoog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headPortraitClick:)];
    [HeadPortraitPic addGestureRecognizer:Recoog];
    [self addSubview:HeadPortraitPic];
    
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(HeadPortraitPic.right + FitwidthRealValue(10) , HeadPortraitPic.top + FitheightRealValue(5), CYTMainScreen_WIDTH / 2, FitheightRealValue(30)) LabelFontSize:14 LabelTextColor:whiteColor LabelTextAlignment:NSTextAlignmentLeft SuperView:self LabelTag:100 LabelText:@"北京市源动力能源有限公司"];
    
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(HeadPortraitPic.right + FitwidthRealValue(10), HeadPortraitPic.top + FitheightRealValue(35), CYTMainScreen_WIDTH / 2, FitheightRealValue(30)) LabelFontSize:14 LabelTextColor:whiteColor LabelTextAlignment:NSTextAlignmentLeft SuperView:self LabelTag:101 LabelText:@"xxxxxxx"];
    
}

- (void)callBack:(isClickHeadePortrait)callBack {
    _block = callBack;
}

- (void)headPortraitClick:(UITapGestureRecognizer *)Recog {
    if (_block) {
        _block(YES);
    }
}

@end
