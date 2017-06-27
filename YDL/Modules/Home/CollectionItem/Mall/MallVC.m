//
//  MallVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/12.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MallVC.h"
#import "GoodsCell_Mall.h"
#import "MallRequest.h"
#import "GoodsModel.h"
#import "GoodsDetailVC.h"

#import "MMComboBox.h"

@interface MallVC ()<UITableViewDelegate,UITableViewDataSource,MMComBoBoxViewDataSource, MMComBoBoxViewDelegate>

@property (nonatomic, strong) UITableView *MalltableView;
@property (nonatomic, strong) MMComBoBoxView *comBoBoxView;

@property (nonatomic, strong) MallRequest *mallRequest;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)GoodsModel *goodsData;
@property (nonatomic, strong) NSArray *mutableArray;

@end

@implementation MallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商城";
    
    self.mallRequest = [[MallRequest alloc] initWithDelegate:self paramSource:self];
    [self.mallRequest loadDataWithHUDOnView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.comBoBoxView dimissPopView];
}

- (void)SetUpUI {
    self.navigationItem.titleView = self.searchBar;
    self.messageBtn.hidden = NO;
    
    [self.view addSubview:self.MalltableView];
    [self.MalltableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(40, 0, 0, 0));
    }];
    
    self.comBoBoxView = [[MMComBoBoxView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, 40)];
    self.comBoBoxView.backgroundColor = whiteColor;
    self.isMultiSelection = NO;
    self.comBoBoxView.dataSource = self;
    self.comBoBoxView.delegate = self;
    [self.view addSubview:self.comBoBoxView];
    [self.comBoBoxView reload];

    
}

#pragma mark - APIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(BaseAPIRequest *)request{
    if (request == self.mallRequest) {
        return @{@"account_type":@"2"};
    }
    return nil;
}

#pragma mark - APIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(BaseAPIRequest *)request{
    
}

- (void)managerCallAPIDidFailed:(BaseAPIRequest *)request {
    NSLog(@"失败了");
    if (request == self.mallRequest) {
        NSMutableArray *dataArr = [[NSMutableArray alloc] init];
        dataArr = [[request.responseData valueForKey:@"picturesList"] mutableCopy];
        
        GoodsModel *goodsData = [[GoodsModel alloc] init];
        goodsData.goods_title = @"内蒙古乌审旗管道气";
        goodsData.goods_details = @"鄂尔多斯市星星能源有限公司";
        goodsData.goods_count = @"2950.00";
        
        self.dataArray = [NSMutableArray arrayWithObjects:goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData,goodsData, nil];
        
        [self.MalltableView reloadData];
        
        return;
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsCell_Mall *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[GoodsCell_Mall alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [((GoodsCell_Mall *)cell) setCellData:self.dataArray[indexPath.row] atIndexPath:indexPath];

    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(80);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushVc:[GoodsDetailVC new]];
}

#pragma mark - MMComBoBoxViewDataSource
- (NSUInteger)numberOfColumnsIncomBoBoxView :(MMComBoBoxView *)comBoBoxView {
    return self.mutableArray.count;
}

- (MMItem *)comBoBoxView:(MMComBoBoxView *)comBoBoxView infomationForColumn:(NSUInteger)column {
    return self.mutableArray[column];
}

#pragma mark - MMComBoBoxViewDelegate
- (void)comBoBoxView:(MMComBoBoxView *)comBoBoxViewd didSelectedItemsPackagingInArray:(NSArray *)array atIndex:(NSUInteger)index {
    MMItem *rootItem = self.mutableArray[index];
    switch (rootItem.displayType) {
        case MMPopupViewDisplayTypeNormal:
        case MMPopupViewDisplayTypeMultilayer:{
            //拼接选择项
            NSMutableString *title = [NSMutableString string];
            __block NSInteger firstPath;
            [array enumerateObjectsUsingBlock:^(MMSelectedPath * path, NSUInteger idx, BOOL * _Nonnull stop) {
                [title appendString:idx?[NSString stringWithFormat:@";%@",[rootItem findTitleBySelectedPath:path]]:[rootItem findTitleBySelectedPath:path]];
                if (idx == 0) {
                    firstPath = path.firstPath;
                }
            }];
            NSLog(@"当title为%@时，所选字段为 %@",rootItem.title ,title);
            break;}
        case MMPopupViewDisplayTypeFilters:{
            MMCombinationItem * combineItem = (MMCombinationItem *)rootItem;
            [array enumerateObjectsUsingBlock:^(NSMutableArray*  _Nonnull subArray, NSUInteger idx, BOOL * _Nonnull stop) {
                if (combineItem.isHasSwitch && idx == 0) {
                    for (MMSelectedPath *path in subArray) {
                        MMAlternativeItem *alternativeItem = combineItem.alternativeArray[path.firstPath];
                        NSLog(@"当title为: %@ 时，选中状态为: %d",alternativeItem.title,alternativeItem.isSelected);
                    }
                    return;
                }
                
                NSString *title;
                NSMutableString *subtitles = [NSMutableString string];
                for (MMSelectedPath *path in subArray) {
                    MMItem *firstItem = combineItem.childrenNodes[path.firstPath];
                    MMItem *secondItem = combineItem.childrenNodes[path.firstPath].childrenNodes[path.secondPath];
                    title = firstItem.title;
                    [subtitles appendString:[NSString stringWithFormat:@"  %@",secondItem.title]];
                }
                NSLog(@"当title为%@时，所选字段为 %@",title,subtitles);
            }];
            
            break;}
        default:
            break;
    }
}

#pragma mark - Getter
- (NSArray *)mutableArray {
    if (_mutableArray == nil) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
//价格
        MMSingleItem *rootItem1 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"综合"];
        
        if (self.isMultiSelection)
            rootItem1.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem1  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"综合" subtitleName:nil code:nil]];
        [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"价格从低到高"]]];
        [rootItem1 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"价格从高到低"]]];

//供货日期
        MMMultiItem *rootItem2 = [MMMultiItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"供货日期"];
        if (self.isMultiSelection)
        rootItem2.displayType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem2  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"顺序" subtitleName:nil code:nil]];
        [rootItem2 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"倒序"]]];
        
//配送方式
        MMSingleItem *rootItem3 = [MMSingleItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:@"配送方式"];
        
        if (self.isMultiSelection)
            rootItem3.selectedType = MMPopupViewMultilSeMultiSelection;
        
        [rootItem3  addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected isSelected:YES titleName:@"自提" subtitleName:nil code:nil]];
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"厂家配送"]]];
        [rootItem3 addNode:[MMItem itemWithItemType:MMPopupViewDisplayTypeSelected titleName:[NSString stringWithFormat:@"全部"]]];
        
//筛选
        MMCombinationItem *rootItem4 = [MMCombinationItem itemWithItemType:MMPopupViewDisplayTypeUnselected isSelected:YES titleName:@"筛选" subtitleName:nil];
        rootItem4.displayType = MMPopupViewDisplayTypeFilters;
        
        if (self.isMultiSelection)
            rootItem4.selectedType = MMPopupViewMultilSeMultiSelection;
        
//        MMAlternativeItem *alternativeItem1 = [MMAlternativeItem itemWithTitle:@"只看免预约" isSelected:NO];
//        MMAlternativeItem *alternativeItem2 = [MMAlternativeItem itemWithTitle:@"节假日可用" isSelected:YES];
//        [rootItem4 addAlternativeItem:alternativeItem1];
//        [rootItem4 addAlternativeItem:alternativeItem2];
        
        NSArray *arr = @[@{@"气源类型":@[@"煤层气",@"焦炉煤气",@"页岩气",@"进口气",@"管道气",@"其他"]},
                         @{@"气源类型":@[@"煤层气",@"焦炉煤气",@"页岩气",@"进口气",@"管道气",@"其他"]},
                         @{@"气源类型":@[@"煤层气",@"焦炉煤气",@"页岩气",@"进口气",@"管道气",@"其他"]} ];
        
        for (NSDictionary *itemDic in arr) {
            MMItem *item4_A = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:[itemDic.allKeys lastObject]];
            [rootItem4 addNode:item4_A];
            for (int i = 0; i <  [[itemDic.allValues lastObject] count]; i++) {
                NSString *title = [itemDic.allValues lastObject][i];
                MMItem *item4_B = [MMItem itemWithItemType:MMPopupViewDisplayTypeUnselected titleName:title];
                if (i == 0) {
                    item4_B.isSelected = YES;
                }
                [item4_A addNode:item4_B];
            }
        }
        
        [mutableArray addObject:rootItem1];
        [mutableArray addObject:rootItem2];
        [mutableArray addObject:rootItem3];
        [mutableArray addObject:rootItem4];
        _mutableArray  = [mutableArray copy];
    }
    return _mutableArray;
}

- (UITableView *)MalltableView {
    if (!_MalltableView) {
        _MalltableView = [[UITableView alloc] init];
        _MalltableView.delegate = self;
        _MalltableView.dataSource = self;
        self.MalltableView.backgroundColor = [UIColor clearColor];
        _MalltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _MalltableView;
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


@end
