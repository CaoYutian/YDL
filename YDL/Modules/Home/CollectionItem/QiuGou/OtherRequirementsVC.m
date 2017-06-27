//
//  OtherRequirementsVC.m
//  YQW
//
//  Created by Sunshine on 2017/6/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "OtherRequirementsVC.h"

@interface OtherRequirementsVC ()

@property (nonatomic, strong) UITextView *textViewLength;
@property (nonatomic, strong) UILabel *ploLabel;
@property (nonatomic, strong) UILabel *wordLabelCount;


@end

@implementation OtherRequirementsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];

}

- (void)SetUpUI {

    self.textViewLength = [[UITextView alloc] initWithFrame:CGRectMake(FitwidthRealValue(10), FitheightRealValue(10) + 64, CYTMainScreen_WIDTH - FitwidthRealValue(20), FitheightRealValue(180))];
    self.textViewLength.layer.borderColor = [UIColor orangeColor].CGColor;
    self.textViewLength.layer.borderWidth = 1.0;
    self.textViewLength.layer.cornerRadius = 5;
    self.textViewLength.layer.masksToBounds = YES;
    self.textViewLength.font = FitFont(14);
    [self.view addSubview:self.textViewLength];
    
    self.ploLabel = [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(15), 0, self.textViewLength.width - FitwidthRealValue(20), self.textViewLength.height) LabelFont:FitFont(14) LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentLeft SuperView:self.view LabelTag:1000 LabelText:@"请输反馈信息"];

    self.wordLabelCount = [[UILabel alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(60), self.textViewLength.bottom - FitheightRealValue(20), FitwidthRealValue(80), FitheightRealValue(20))];
    self.wordLabelCount.textColor = [UIColor orangeColor];
    self.wordLabelCount.text = @"200";
    [self.view addSubview:self.wordLabelCount];
    
}

#pragma mark - 当textField布局发生改变的时候调用

- (void)textViewDidChange:(UITextView *)textView {
//对占位符的显示和隐藏做判断
    if (self.textViewLength.text.length == 0) {
        self.ploLabel.text =  @"请输反馈信息";
    }else {
        self.ploLabel.text = @"";
    }
    
//读出textView字符长度
    self.wordLabelCount.text = [NSString stringWithFormat:@"%lu",200 - self.textViewLength.text.length];
    if (self.textViewLength.text.length > 200) {
        
//对超出的部分进行剪切
        self.textViewLength.text = [self.textViewLength.text substringToIndex:10];
        
        self.wordLabelCount.text = @"0";
        
    }
    
    if (self.textViewLength.text.length > 200) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示!" message:@"亲!最多只能输入200个字!请您合理安排内容!" preferredStyle:UIAlertControllerStyleAlert];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        });
        
    }
    
}

#pragma mark - 移除监听方法
- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}


@end
