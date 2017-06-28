//
//  OtherRequirementsVC.h
//  YQW
//
//  Created by Sunshine on 2017/6/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"

typedef void (^callBackBlock)(NSString *distriText);

@interface OtherRequirementsVC : BaseVC

@property (nonatomic, copy) NSString* distriText;
@property (nonatomic, strong) UITextView *textViewLength;
@property (nonatomic, strong) UILabel *ploLabel;
@property (nonatomic, strong) UILabel *wordLabelCount;

@property (nonatomic, copy) callBackBlock block;


@end
