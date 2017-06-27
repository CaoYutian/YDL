//
//  MenuControl.m
//  YQW
//
//  Created by Sunshine on 2017/5/11.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MenuControl.h"

@interface MenuControl ()
@property(nonatomic,strong)UIView *seperatorLine;
@end

@implementation MenuControl

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.indicatorColor = NavigationBarBackgroundColor;
        self.selectedTextColor = blackColor;
        self.textColor = [UIColor lightGrayColor];
        self.font = FONT_NORMAL;
    }
    return self;
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.indicatorColor = NavigationBarBackgroundColor;
        self.selectedTextColor = blackColor;
        self.textColor = [UIColor lightGrayColor];
        self.font = FONT_NORMAL;
    }
    return self;
}

#pragma mark - actions
-(void)menuBtnClick:(UIButton *)sender
{
    NSInteger selectedIndex = sender.tag-1000;
    if (self.selectedIndex!=selectedIndex) {
        self.selectedIndex = selectedIndex;
        if ([self.delegate respondsToSelector:@selector(menuCtrl:didSelectIndex:)]) {
            [self.delegate menuCtrl:self didSelectIndex:selectedIndex];
        }
    }
}

#pragma mark - getters and setters
-(void)setTitles:(NSArray *)titles
{
    _titles = [titles copy];
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    for (int i=0; i<_titles.count; i++) {
        UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        menuBtn.tag = 1000+i;
        [menuBtn setTitle:_titles[i] forState:UIControlStateNormal];
        [menuBtn setTitleColor:self.textColor forState:UIControlStateNormal];
        [menuBtn setTitleColor:self.selectedTextColor forState:UIControlStateSelected];
        menuBtn.titleLabel.font = self.font;
        [self addSubview:menuBtn];
        WS(weakSelf);
        if (i==0) {
            menuBtn.selected = YES;
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(weakSelf).dividedBy(_titles.count);
                make.top.height.equalTo(weakSelf);
                make.left.mas_equalTo(0);
            }];
            if (!self.indicatorLine.superview) {
                self.indicatorLine.backgroundColor = self.indicatorColor;
                [self addSubview:self.indicatorLine];
                __weak typeof(menuBtn)weakMenuBtn = menuBtn;
                [self.indicatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(weakMenuBtn);
                    make.left.equalTo(weakMenuBtn).offset(weakSelf.indicatorInset);
                    make.right.equalTo(weakMenuBtn).offset(-weakSelf.indicatorInset);
                    make.height.mas_equalTo(2);
                }];
            }
        } else {
            UIButton *formerBtn = [self viewWithTag:1000+i-1];
            __weak typeof(formerBtn)weakBtn = formerBtn;
            [menuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(weakSelf).dividedBy(weakSelf.titles.count);
                make.top.height.equalTo(weakSelf);
                make.left.mas_equalTo(weakBtn.mas_right);
            }];
        }
        [menuBtn addTarget:self action:@selector(menuBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (!self.seperatorLine.superview) {
        [self addSubview:self.seperatorLine];
        WS(weakSelf);
        [self.seperatorLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(weakSelf);
            make.height.mas_equalTo(0.5);
        }];
    }
}

-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    if (!self.titles.count) {
        return;
    }
    for (int i=0; i<self.titles.count; i++) {
        UIButton *menuBtn = (UIButton *)[self viewWithTag:1000+i];
        menuBtn.selected = (i==selectedIndex);
    }
    CGFloat width = self.width/self.titles.count;
    self.animating = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.indicatorLine.left = width*selectedIndex+self.indicatorInset;
    } completion:^(BOOL finished) {
        self.animating = NO;
    }];
}

-(UIView *)indicatorLine
{
    if (!_indicatorLine) {
        _indicatorLine = [[UIView alloc] init];
    }
    return _indicatorLine;
}

-(UIView *)seperatorLine
{
    if (!_seperatorLine) {
        _seperatorLine = [[UIView alloc] init];
        _seperatorLine.backgroundColor = MainBackgroundColor;
    }
    return _seperatorLine;
}

@end

@interface MenuContainer () <UITableViewDelegate,UITableViewDataSource,MenuControlDelegate>
@property(nonatomic,strong)UITableView *containerTableView;
@end

@implementation MenuContainer

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = MainBackgroundColor;
        self.scrollAnimated = YES;
        [self addSubview:self.menuCtrl];
        [self addSubview:self.containerTableView];
        [self layoutConstraints];
    }
    return self;
}

-(void)layoutConstraints
{
    WS(weakSelf);
    [self.menuCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(weakSelf);
        make.height.mas_equalTo(44);
    }];
    
    [self.containerTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.centerY.equalTo(weakSelf).offset(22);
        make.height.mas_equalTo(weakSelf.mas_width);
        make.width.mas_equalTo(weakSelf.mas_height).offset(-44);
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return MAX(self.childViewControlllers.count, self.childViews.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"childVCCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.contentView.transform = CGAffineTransformMakeRotation(M_PI / 2);
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    UIView *view = nil;
    if (self.childViewControlllers.count) {
        UIViewController *vc = self.childViewControlllers[indexPath.row];
        view = vc.view;
    } else if (self.childViews.count) {
        view = self.childViews[indexPath.row];
    }
    __weak typeof(cell)weakCell = cell;
    [cell.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakCell.contentView);
    }];
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.width;
}

#pragma mark - MenuControlDelegate
-(void)menuCtrl:(MenuControl *)menuCtrl didSelectIndex:(NSInteger)index
{
    _selectedIndex = index;
    if (index<self.childViewControlllers.count) {
        [self.containerTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:self.scrollAnimated];
        return;
    }
    if (index<self.childViews.count) {
        [self.containerTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:self.scrollAnimated];
    }
    if (self.indexChangeBlock) {
        self.indexChangeBlock();
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.menuCtrl.animating || !MAX(self.childViewControlllers.count, self.childViews.count)) {
        return;
    }
    self.menuCtrl.indicatorLine.left = scrollView.contentOffset.y/self.menuCtrl.titles.count+self.menuCtrl.indicatorInset;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (!MAX(self.childViewControlllers.count, self.childViews.count)) {
        return;
    }
    _selectedIndex = scrollView.contentOffset.y/scrollView.width;
    self.menuCtrl.selectedIndex = _selectedIndex;
    if (self.indexChangeBlock) {
        self.indexChangeBlock();
    }
}

#pragma mark - getters and setters
-(void)setSelectedIndex:(NSInteger)selectedIndex
{
    _selectedIndex = selectedIndex;
    [self performBlock:^{
        self.menuCtrl.selectedIndex = selectedIndex;
        [self.containerTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:self.scrollAnimated];
    } afterDelay:0.1];
}

-(void)setChildViewControlllers:(NSArray *)childViewControlllers
{
    _childViewControlllers = childViewControlllers;
    [self.containerTableView reloadData];
}

-(void)setChildViews:(NSArray *)childViews
{
    _childViews = childViews;
    [self.containerTableView reloadData];
}

-(void)setScrollAnimated:(BOOL)scrollAnimated
{
    _scrollAnimated = scrollAnimated;
    self.containerTableView.scrollEnabled = scrollAnimated;
}

-(MenuControl *)menuCtrl
{
    if (!_menuCtrl) {
        _menuCtrl = [[MenuControl alloc] init];
        _menuCtrl.backgroundColor = whiteColor;
        _menuCtrl.font = FONT_NORMAL;
        _menuCtrl.delegate = self;
    }
    return _menuCtrl;
}

-(UITableView *)containerTableView
{
    if (!_containerTableView) {
        _containerTableView = [[UITableView alloc] init];
        _containerTableView.backgroundColor = whiteColor;
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
        _containerTableView.showsHorizontalScrollIndicator = NO;
        _containerTableView.showsVerticalScrollIndicator = NO;
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.pagingEnabled = YES;
    }
    return _containerTableView;
}

@end
