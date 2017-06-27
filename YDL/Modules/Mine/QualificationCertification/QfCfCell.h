//
//  QfCfCell.h
//  YQW
//
//  Created by Sunshine on 2017/6/21.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ChooseOpration) (BOOL isSelected);
@interface QfCfCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *titleIconPic;
@property (strong, nonatomic) IBOutlet UILabel *titleName;
@property (strong, nonatomic) IBOutlet UILabel *titleDetail;
@property (strong, nonatomic) IBOutlet UIButton *operationBtn;

- (void)ChooseOpration:(ChooseOpration)callBack;

@end
