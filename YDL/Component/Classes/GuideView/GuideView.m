//
//  GuideView.m
//  YQW
//
//  Created by Sunshine on 2017/6/7.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "GuideView.h"

@interface GuideView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>{
    UIScrollView *_scorllView;
    UIPageControl *pageControl;
}

@end

@implementation GuideView

-(id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray {
    if (self = [super initWithFrame:frame ]) {
        _scorllView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _scorllView.pagingEnabled = YES;
        _scorllView.delegate = self;
        
        [self addSubview:_scorllView];
        _scorllView.contentSize = CGSizeMake(self.frame.size.width * imageArray.count, 0);
        
        for (int  i = 0; i < imageArray.count; i++) {
            UIImageView *imageView = [CYTUtiltyHelper createImageViewWithFrame:CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height) imageName:imageArray[i]];
            //开启用户交互模式
            [_scorllView addSubview:imageView];
            _scorllView.showsVerticalScrollIndicator = NO;
            _scorllView.showsHorizontalScrollIndicator = NO;
            
            if (i == imageArray.count -1) {
                imageView.userInteractionEnabled = YES;
                UISwipeGestureRecognizer *SwipeGes = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goApp:)];
                SwipeGes.delegate = self;
                [SwipeGes setDirection:UISwipeGestureRecognizerDirectionLeft];
                [imageView addGestureRecognizer:SwipeGes];
                
                UITapGestureRecognizer *Recog = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goAppClick)];
                [imageView addGestureRecognizer:Recog];
                
            }
        }
        
        pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH / 3, CYTMainScreen_HEIGHT * 7 / 8, CYTMainScreen_WIDTH / 3, CYTMainScreen_HEIGHT / 8)];
        // 设置页数
        pageControl.numberOfPages = imageArray.count;
        // 设置页码的点的颜色
        pageControl.pageIndicatorTintColor = whiteColor;
        // 设置当前页码的点颜色
        pageControl.currentPageIndicatorTintColor = NavigationBarBackgroundColor;
        
        [self addSubview:pageControl];
    }
    return self;
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{    // 计算当前在第几页
    pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x / CYTMainScreen_WIDTH);
}

- (void)goApp:(UISwipeGestureRecognizer *)SwipeGes {
    
    if (SwipeGes.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        [UIView animateWithDuration:0.5f animations:^{
            _scorllView.frame = CGRectMake(-CYTMainScreen_WIDTH, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
        
    }
}

- (void)goAppClick {
    [UIView animateWithDuration:0.5f animations:^{
        _scorllView.frame = CGRectMake(0, CYTMainScreen_HEIGHT, CYTMainScreen_WIDTH, CYTMainScreen_WIDTH);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

//返回YES表示同时支持识别多个手势
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
    
}
@end
