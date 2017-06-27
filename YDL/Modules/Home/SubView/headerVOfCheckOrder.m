//
//  headerVOfCheckOrder.m
//  YQW
//
//  Created by Sunshine on 2017/6/23.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "headerVOfCheckOrder.h"

@interface headerVOfCheckOrder ()

@property (nonatomic, strong) UIImageView *iconCompany;
@property (nonatomic, strong) UILabel *nameCompany;

@property (nonatomic, strong) UIView *goodsBg;
@property (nonatomic, strong) UILabel *goodsName;
@property (nonatomic, strong) UILabel *goodsPrice;

@property (nonatomic, strong) UILabel *paymentStyel;
@property (nonatomic, strong) UILabel *paymentType;

@property (nonatomic, strong) UILabel *payStyel;
@property (nonatomic, strong) UILabel *payType;

@property (nonatomic, strong) UILabel *unit;

@end

@implementation headerVOfCheckOrder

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = whiteColor;
        [self SetUpUI];
    }
    return self;
}

- (void)SetUpUI{
    //公司logo
    self.iconCompany = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(5), FitwidthRealValue(20), FitwidthRealValue(20)) imageName:@"companylogo_big" SuperView:self];
    //公司名称
    self.nameCompany = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(self.iconCompany.right + FitwidthRealValue(5), 0, CYTMainScreen_WIDTH - FitwidthRealValue(40), FitheightRealValue(30)) LabelFont:FitFont(14) LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self LabelTag:100 LabelText:@"山东博陆能源科技有限公司"];
    //商品背景图
    self.goodsBg = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameCompany.bottom, CYTMainScreen_WIDTH, FitheightRealValue(60))];
    self.goodsBg.backgroundColor = MainBackgroundColor;
    [self addSubview:self.goodsBg];
    
    //商品名称
    self.goodsName = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), 0, CYTMainScreen_WIDTH / 2, FitheightRealValue(40)) LabelFont:FitFont(18) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentLeft SuperView:self.goodsBg LabelTag:101 LabelText:@"天津大港"];
    //商品价格
    self.goodsPrice = [[UILabel alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH /2, 0, CYTMainScreen_WIDTH / 2 - FitwidthRealValue(13), FitheightRealValue(40))];
    self.goodsPrice.textAlignment = NSTextAlignmentRight;
    [self.goodsBg addSubview:self.goodsPrice];
    NSMutableAttributedString *goodsPriceAttri = [CYTUtiltyHelper addAttribute:@"￥3200.00" firstColorValue:[UIColor orangeColor] secondColorValue:[UIColor orangeColor] firstFont:FitFont(12) secondFont:FitFont(20) firstRange:NSMakeRange(0, 1) secondRange:NSMakeRange(1, 7)];
    self.goodsPrice.attributedText = goodsPriceAttri;
    
    //付款方式
    self.paymentStyel = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(13), self.goodsPrice.bottom - FitheightRealValue(5), CYTMainScreen_WIDTH / 3, FitheightRealValue(20)) LabelFont:FitFont(12) LabelTextColor:NavigationBarBackgroundColor LabelTextAlignment:NSTextAlignmentLeft SuperView:self.goodsBg LabelTag:102 LabelText:@"付款方式"];
//    self.paymentType = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>) LabelFont:<#(UIFont *)#> LabelTextColor:<#(UIColor *)#> LabelTextAlignment:<#(NSTextAlignment)#> SuperView:<#(UIView *)#> LabelTag:<#(NSInteger)#> LabelText:<#(NSString *)#>]
    
    
    //支付方式
        self.payStyel = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH / 3, self.goodsPrice.bottom - FitheightRealValue(5), CYTMainScreen_WIDTH / 3, FitheightRealValue(20)) LabelFont:FitFont(12) LabelTextColor:NavigationBarBackgroundColor LabelTextAlignment:NSTextAlignmentLeft SuperView:self.goodsBg LabelTag:103 LabelText:@"支付方式"];
    
    self.unit = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - 53, self.goodsPrice.bottom - FitheightRealValue(5), FitwidthRealValue(40), FitheightRealValue(20)) LabelFont:FitFont(12) LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentRight SuperView:self.goodsBg LabelTag:104 LabelText:@"元/吨"];
}

@end
