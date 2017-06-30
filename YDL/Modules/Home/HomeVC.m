//
//  HomeVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "HomeVC.h"
#import "MallVC.h"
#import "PurchaseAgreementVC.h"
#import "QiuGouVC.h"
#import "QiZhanVC.h"
#import "MoreGoodsDynamicVC.h"
#import "GoodsDetailVC.h"
#import "HomeWebView.h"

#import "HomeRequest.h"

#import "GoodsModel.h"

#import "GoodsDynamicCell.h"
#import "HeaderView_Home.h"
@interface HomeVC ()<UITableViewDelegate,UITableViewDataSource>{
    CGFloat Alpha;
}

@property (nonatomic, strong) HomeRequest *homeRequest;

@property (nonatomic, strong) NSMutableArray *dataArr;
@property(nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic, strong) UITableView *GoodsDynamicTableView;

@property(nonatomic,strong)GoodsModel *goodsData;

@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navAlpha = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.homeRequest = [[HomeRequest alloc] initWithDelegate:self paramSource:self];
    [self.homeRequest loadDataWithHUDOnView:self.view];
    
    [self SetUpNavBar];
}

- (void)SetUpUI {
    [self.view addSubview:self.GoodsDynamicTableView];
    self.GoodsDynamicTableView.backgroundColor = [UIColor clearColor];
//    [self.GoodsDynamicTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
}

- (void)SetUpNavBar {
    
    UIButton *ClassBtn = [CYTUtiltyHelper addbuttonWithRect:CGRectMake(0, 0, 44, 44) NormalbgImageStr:@"classification" highLightbgimageStr:@"classification" tag:100 SuperView:self.view buttonTarget:self Action:@selector(List)];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:ClassBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    self.navigationItem.titleView = self.searchBar;
    self.messageBtn.hidden = NO;
}

-(void)loadData {
    [self.homeRequest loadDataWithHUDOnView:nil];
}

#pragma mark 列表
- (void)List {
    [self pushVc:[MoreGoodsDynamicVC new]];
    [CustomHUD createShowContent:@"什么鬼？" hiddenTime:1];
}

#pragma mark 搜索事件
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [self pushVc:[MoreGoodsDynamicVC new]];

    return NO;
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request{
    if (request == self.homeRequest) {
        return @{@"account_type":@"2"};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request{
    [self handleConcurrencyRequest];
    if (request == self.homeRequest) {
        
        return;
    }
    
}


- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
    [self handleConcurrencyRequest];
    if (request == self.homeRequest) {
        //        self.dataArr = [[request.responseData valueForKey:@"picturesList"] mutableCopy];
        self.dataArr = [NSMutableArray arrayWithArray:@[
                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496737322490&di=27716cba2c3271ab8fe771218bdececa&imgtype=0&src=http%3A%2F%2Fimg10.360buyimg.com%2Fn1%2Fjfs%2Ft460%2F73%2F172779934%2F161835%2F72c54212%2F545491caN632aaf77.jpg",
                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496737215445&di=172eae48714dc6f354e668fcb660adb5&imgtype=0&src=http%3A%2F%2Fimg01.taopic.com%2F160327%2F240382-16032FU02137.jpg",
                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496731764023&di=684ffdc28db0d25936334442df2faa17&imgtype=0&src=http%3A%2F%2Fimages.3158.cn%2Fdata%2Fattachment%2Fqiche%2Farticle%2F2016%2F03%2F25%2Fff976d8725d1032de5eacfc62baa8d12.jpg",
                                                        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496745427099&di=bf8969b9528bd4745e0aed50cbb98db7&imgtype=0&src=http%3A%2F%2Fwww.bz55.com%2Fuploads%2Fallimg%2F150701%2F139-150F1103504-50.jpg"]];
        
        HeaderView_Home *hearderView = [[HeaderView_Home alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(288)) ShufflingFigureData:self.dataArr];
        self.GoodsDynamicTableView.tableHeaderView = hearderView;
        
        [hearderView.ShufflingFigure addTapEventForImageWithBlock:^(NSInteger imageIndex) {
            
            //[self pushVc:[HomeWebView new]];
            [self presentVc:[HomeWebView new]];
            NSLog(@"第%ld个-----》",(long)imageIndex);
        }];
        
        [hearderView functionChooseCallBack:^(NSInteger choose) {
            switch (choose) {
                case 0:
                    [self pushVc:[MallVC new]];
                    break;
                    
                case 1:
                    [self pushVc:[QiuGouVC new]];
                    break;
                    
                case 2:
                    [self pushVc:[PurchaseAgreementVC new]];
                    break;
                    
                case 3:
                    [self pushVc:[QiZhanVC new]];
                    break;
            }
        }];
        
        GoodsModel *goodsData = [[GoodsModel alloc] init];
        goodsData.goods_title = @"内蒙古乌审旗管道气";
        goodsData.goods_details = @"鄂尔多斯市星星能源有限公司";
        goodsData.goods_count = @"2950.00";
        
        self.dataArray = [NSMutableArray arrayWithObjects:goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData, nil];
        
        [self.GoodsDynamicTableView reloadData];
        
        return;
    }

}

-(void)handleConcurrencyRequest {
    [self.GoodsDynamicTableView.mj_header endRefreshing];
    [self.GoodsDynamicTableView.mj_footer endRefreshing];
}

#pragma mark - scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y = scrollView.contentOffset.y;
    self.navAlpha = y / 80;
    if (y > 80) {
        self.navTintColor = NavigationBarBackgroundColor;
    } else {
        self.navTintColor = y < 0 ? [UIColor clearColor] : NavigationBarBackgroundColor;
        self.navigationController.navigationBar.hidden = y < -40 ? YES : NO;
    }

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[GoodsDynamicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [((GoodsDynamicCell *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(50);
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(40));
    headerView.backgroundColor = [UIColor lightTextColor];
    [headerView handleClick:^(UIView *view) {
        [self pushVc:[MoreGoodsDynamicVC new]];
    }];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(FitwidthRealValue(13), FitheightRealValue(12.5), FitwidthRealValue(15), FitheightRealValue(15))];
    img.image = IMAGENAMED(@"Goodsdynamic");
    [headerView addSubview:img];

    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(FitwidthRealValue(40), 0, FitwidthRealValue(200), FitheightRealValue(40)) LabelFontSize:14 LabelTextColor:blackColor LabelTextAlignment:NSTextAlignmentLeft SuperView:headerView LabelTag:120 LabelText:@"商品动态"];
    
    UIImageView *rightImgV = [[UIImageView alloc] initWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(20), FitheightRealValue(12.5), FitwidthRealValue(15), FitwidthRealValue(15))];
    rightImgV.image = IMAGENAMED(@"main_arrow_right");
    [headerView addSubview:rightImgV];
    
    [CYTUtiltyHelper addLabelWithFrame:CGRectMake(CYTMainScreen_WIDTH - FitwidthRealValue(60), 0, FitwidthRealValue(40), FitheightRealValue(40)) LabelFontSize:12 LabelTextColor:[UIColor grayColor] LabelTextAlignment:NSTextAlignmentRight SuperView:headerView LabelTag:121 LabelText:@"更多"];
    
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return FitheightRealValue(40);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushVc:[GoodsDetailVC new]];
}

- (UITableView *)GoodsDynamicTableView {
    if (!_GoodsDynamicTableView) {
        _GoodsDynamicTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT)];
        _GoodsDynamicTableView.delegate = self;
        _GoodsDynamicTableView.dataSource = self;
        _GoodsDynamicTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _GoodsDynamicTableView.mj_header = self.comHeader;
        _GoodsDynamicTableView.mj_footer = self.comFooter;
    }
    return _GoodsDynamicTableView;
}

- (GoodsModel *)goodsData {
    if (!_goodsData) {
        _goodsData = [[GoodsModel alloc] init];
    }
    return _goodsData;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc] init];
    }
    return _dataArr;
}

@end
