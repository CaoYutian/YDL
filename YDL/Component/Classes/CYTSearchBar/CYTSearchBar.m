//
//  CYTSearchBar.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "CYTSearchBar.h"

@implementation CYTSearchBar

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        UIView *searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH * 0.7f, 40)];
        searchView.backgroundColor = [UIColor clearColor];
        searchView.clipsToBounds = YES;
        searchView.layer.cornerRadius = 8;
        UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:searchView.bounds];
        searchBar.backgroundImage = [[UIImage alloc] init];
        [searchView addSubview:searchBar];
    }
    
    return self;
}

@end
