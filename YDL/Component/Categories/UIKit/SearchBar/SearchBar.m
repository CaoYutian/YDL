//
//  SearchBar.m
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "SearchBar.h"

@implementation SearchBar

-(void)layoutSubviews
{
    [super layoutSubviews];
    UIView *backgroundView = [((UIView *)[self.subviews objectAtIndex:0]).subviews firstObject];
    backgroundView.hidden=YES;
}

@end
