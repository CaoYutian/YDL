//
//  VersionAlertView.m
//  YQW
//
//  Created by Sunshine on 2017/6/6.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "VersionAlertView.h"
#define AlertW CYTMainScreen_WIDTH - FitwidthRealValue(80)

@interface VersionAlertView ()
@property(nonatomic,strong)UIView *alertView;//弹框视图
@end

@implementation VersionAlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message updateBtn:(NSString *)updateTitle {
    if (self = [super init]) {
        self.backgroundColor = COLOR_BG_COVER;
        self.frame = [UIScreen mainScreen].bounds;
        
        self.alertView = [[UIView alloc]init];
        self.alertView.backgroundColor = whiteColor;
        self.alertView.layer.cornerRadius = FitwidthRealValue(5.0);
        self.alertView.frame = CGRectMake(0, 0, AlertW, FitheightRealValue(300));
        self.alertView.layer.position = self.center;
        
        self.closeButton.frame = CGRectMake(_alertView.frame.size.width-FitwidthRealValue(30), FitheightRealValue(10), FitheightRealValue(20), FitheightRealValue(20));
        [self.alertView addSubview:self.closeButton];
        
        self.versionImage = [[UIImageView alloc] init];
        self.versionImage.image = [UIImage imageNamed:@"ic_update_version"];
        self.versionImage.frame = CGRectMake((self.alertView.width - FitwidthRealValue(100))/2, FitheightRealValue(35), FitwidthRealValue(100), FitwidthRealValue(100));
        [self.alertView addSubview:self.versionImage];
        
        
        self.title = [self getAdaptiveLable:CGRectMake(2*MARGIN_SPACE, CGRectGetMaxY(self.versionImage.frame)+FitheightRealValue(20), AlertW-4*MARGIN_SPACE, FitheightRealValue(20)) contentStr:title isTitle:YES];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.alertView addSubview:self.title];
        CGFloat titleW = self.title.bounds.size.width;
        CGFloat titleH = self.title.bounds.size.height;
        self.title.frame = CGRectMake((AlertW-titleW)/2, CGRectGetMaxY(self.versionImage.frame)+FitheightRealValue(20), titleW, titleH);
        
        
        self.titleLabel = [self getAdaptiveLable:CGRectMake(2*MARGIN_SPACE, CGRectGetMaxY(self.title.frame)+2*MARGIN_SPACE, AlertW-4*MARGIN_SPACE, FitheightRealValue(20)) contentStr:message isTitle:NO];
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.alertView addSubview:self.titleLabel];
        CGFloat msgW = self.titleLabel.bounds.size.width;
        CGFloat msgH = self.titleLabel.bounds.size.height;
        self.titleLabel.frame = self.title?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.title.frame)+2*MARGIN_SPACE, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*MARGIN_SPACE, msgW, msgH);
        
        self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        self.sureBtn.frame = CGRectMake((self.alertView.width - 150)/2, CGRectGetMaxY(self.titleLabel.frame) + FitheightRealValue(20), FitwidthRealValue(150), FitheightRealValue(44));
        [self.sureBtn setTitle:@"立即更新" forState:UIControlStateNormal];
        [self.sureBtn setTitleColor:whiteColor forState:UIControlStateNormal];
        self.sureBtn.tag = 1;
        self.sureBtn.layer.cornerRadius = 2.0f;
        self.sureBtn.layer.masksToBounds = YES;
        self.sureBtn.backgroundColor = NavigationBarBackgroundColor;
        [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertView addSubview:self.sureBtn];
        
        // 计算高度
        CGFloat alertHeight = CGRectGetMaxY(self.sureBtn.frame) + FitheightRealValue(30);
        self.alertView.frame = CGRectMake(0, 0, AlertW, alertHeight);
        self.alertView.layer.position = self.center;
        [self addSubview:self.alertView];
        
    }
    return self;
}

- (UILabel *)getAdaptiveLable:(CGRect)rect contentStr:(NSString *)contentStr isTitle:(BOOL)isTitle {
    UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
    contentLbl.numberOfLines = 0;
    contentLbl.text = contentStr;
    contentLbl.textAlignment = NSTextAlignmentCenter;
    if (isTitle) {
        contentLbl.font = FitFont(18);
    }else{
        contentLbl.font = FitFont(14);
    }
    
    NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
    NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
    mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
    [mParaStyle setLineSpacing:3.0];
    [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
    [contentLbl setAttributedText:mAttrStr];
    [contentLbl sizeToFit];
    
    return contentLbl;
}


- (void)showAlertView {
    [mainWindow() endEditing:YES];
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        
    }];
    
    [CommonUtils setCAKeyframeAnimation:self.alertView];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self];
    if (!CGRectContainsPoint([self.alertView frame], pt)) {
        [self closeAction];
    }
}

- (void)closeAction {
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.backgroundColor = whiteColor;
        _title.textColor = blackColor;
        _title.font = FONT(18);
    }
    return _title;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = whiteColor;
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = FONT(14);
    }
    return _titleLabel;
}

- (void)buttonEvent:(UIButton *)sender {
    if (sender.tag == 1) {
        if (self.resultIndex) {
            self.resultIndex(sender.tag);
        }
    }
    [self removeFromSuperview];
}

@end
