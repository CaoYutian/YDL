//
//  AddressMapViewController.m
//  YQW
//
//  Created by Sunshine on 2017/6/16.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "AddressMapViewController.h"
#import "SearchBar.h"
#import <IQKeyboardManager.h>
#import "LocationManager.h"

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "AddressMapCell.h"

@interface AddressMapViewController ()
@property(nonatomic,strong)UIView *headerView;
//@property(nonatomic,strong)SearchBar *searchBar;
@property(nonatomic,strong)BMKMapView* mapView;
@property(nonatomic,strong)BaseTableView *nearbyTableView;
@property(nonatomic,strong)UIButton *resetLocationBtn;
@property(nonatomic,strong)UIImageView *currentLocationView;
@property(nonatomic,retain)AddressPickerModel *addressInfo;
@property(nonatomic,assign)NSInteger selectedIndex;
@property(nonatomic,assign)BOOL shouldSearchNearby;
@end

@implementation AddressMapViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    self.shouldSearchNearby = YES;
    _mapView.delegate = (id)self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    if (!self.addressData || !(self.addressData.latitude && self.addressData.longitude)) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationUpdated) name:NotificationLocationUpdated object:nil];
    }
    WS(weakSelf);
    [self performBlock:^{
        [weakSelf locationUpdated];
    } afterDelay:0.1];
    if ([locationManager checkLocationAndShowingAlert:YES]) {
        [locationManager startLocation];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    [locationManager removeSearchNearbyDelegate];
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"地址";

    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.mapView];
    [self.headerView addSubview:self.currentLocationView];
    [self.headerView addSubview:self.resetLocationBtn];
    [self.view addSubview:self.nearbyTableView];
    [self layoutConstraints];
}

- (void)layoutConstraints {
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(0);
    }];
    
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.headerView);
        make.height.mas_equalTo(CYTMainScreen_HEIGHT * 2 / 3);
        make.bottom.equalTo(self.headerView);
    }];
    
    [self.resetLocationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mapView).offset(-FitwidthRealValue(10));
        make.bottom.equalTo(self.mapView).offset(-FitwidthRealValue(10));
        make.width.height.mas_equalTo(FitheightRealValue(50));
    }];
    
    [self.currentLocationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mapView);
        make.width.mas_equalTo(FitwidthRealValue(20));
        make.height.mas_equalTo(FitwidthRealValue(30));
    }];
    
    [self.nearbyTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}
- (void)searchNearby:(NSString *)keyword {
    if (keyword.length && self.addressInfo) {
        [locationManager poiSearchNearbyWithDelegate:self coordinate:self.mapView.centerCoordinate keyword:keyword];
    } else {
        [locationManager geoSearchNearbyWithDelegate:self coordinate:self.mapView.centerCoordinate];
    }
}

#pragma mark - BMKMapViewDelegate
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    [self.view endEditing:YES];
    if (self.shouldSearchNearby) {
        [self searchNearby:nil];
    }
    self.shouldSearchNearby = YES;
}

#pragma mark - POI search
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResultList errorCode:(BMKSearchErrorCode)error {
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *poiArray = [[NSMutableArray alloc] initWithCapacity:poiResultList.poiInfoList.count];
        for (BMKPoiInfo *poiInfo in poiResultList.poiInfoList) {
            AddressPickerModel *addressInfo = [[AddressPickerModel alloc] init];
            addressInfo.provinceInfo = self.addressInfo.provinceInfo;
            addressInfo.cityInfo = self.addressInfo.cityInfo;
            addressInfo.countyInfo = self.addressInfo.countyInfo;
            addressInfo.townInfo = self.addressInfo.townInfo;
            addressInfo.poiName = poiInfo.name;
            addressInfo.poiAddress = poiInfo.address;
            addressInfo.detailAddress = [NSString stringWithFormat:@"%@%@",poiInfo.address,poiInfo.name];
            addressInfo.latitude = @(poiInfo.pt.latitude);
            addressInfo.longitude = @(poiInfo.pt.longitude);
            [poiArray addObject:addressInfo];
        }
        self.nearbyTableView.dataArray = poiArray;
        [self.nearbyTableView reloadData];
    }
    else if (error == BMK_SEARCH_AMBIGUOUS_KEYWORD){
        //当在设置城市未找到结果，但在其他城市找到结果时，回调建议检索城市列表
    } else {
        //未找到结果
    }
}

#pragma mark - GEO search
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *poiArray = [[NSMutableArray alloc] initWithCapacity:result.poiList.count];

        if (result.poiList.count) {
            self.addressInfo = nil;
        }
        for (BMKPoiInfo *poiInfo in result.poiList) {
            GeoModel *provinceInfo = [[GeoModel alloc] init];
            provinceInfo.geoId = @"0";
            provinceInfo.geoName = result.addressDetail.province;
            GeoModel *cityInfo = [[GeoModel alloc] init];
            cityInfo.geoId = @"0";
            cityInfo.geoName = result.addressDetail.city;
            GeoModel *countyInfo = [[GeoModel alloc] init];
            countyInfo.geoId = @"0";
            countyInfo.geoName = result.addressDetail.district;
            GeoModel *townInfo = [[GeoModel alloc] init];
            townInfo.geoId = @"0";
            townInfo.geoName = result.addressDetail.streetName;
            AddressPickerModel *addressInfo = [[AddressPickerModel alloc] init];
            addressInfo.provinceInfo = provinceInfo;
            addressInfo.countyInfo = countyInfo;
            addressInfo.cityInfo = cityInfo;
            addressInfo.townInfo = townInfo;
            if (!self.addressInfo) {
                self.addressInfo = addressInfo;
            }
            addressInfo.poiName = poiInfo.name;
            addressInfo.poiAddress = poiInfo.address;
            addressInfo.detailAddress = [NSString stringWithFormat:@"%@%@",poiInfo.address,poiInfo.name];
            addressInfo.latitude = @(poiInfo.pt.latitude);
            addressInfo.longitude = @(poiInfo.pt.longitude);
            [poiArray addObject:addressInfo];
        }
        self.nearbyTableView.dataArray = poiArray;
        [self.nearbyTableView reloadData];
    }
    else {
        NSLog(@"未找到结果");
        //未找到结果
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self searchNearby:searchBar.text];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

- (void)locationUpdated:(CLLocationCoordinate2D)center {
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.003, 0.003);
    BMKCoordinateRegion region = BMKCoordinateRegionMake(center, span);
    [_mapView setRegion:region];
    
    [self searchNearby:nil];
}

#pragma mark - actions
- (void)locationUpdated {
    if (self.addressData && (self.addressData.latitude && self.addressData.longitude)) {
        CLLocationCoordinate2D center = CLLocationCoordinate2DMake([self.addressData.latitude doubleValue], [self.addressData.longitude doubleValue]);
        [self locationUpdated:center];
    } else {
        if (locationManager.userLocation.location) {
            CLLocationCoordinate2D center = locationManager.coordinate;
            [self locationUpdated:center];
        }
    }
}

- (void)rightBtnAction {
    if (self.selectAddressBlock) {
        self.selectAddressBlock(self.addressInfo);
    }
//    [AppCommon popViewControllerAnimated:YES];
}

- (void)resetLocationAction {
    [self locationUpdated];
}

#pragma mark - getters and setters
-(UIView *)headerView
{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
    }
    return _headerView;
}

- (BMKMapView *)mapView
{
    if (!_mapView) {
        _mapView = [[BMKMapView alloc] init];
        _mapView.showsUserLocation = YES;
        _mapView.delegate = (id)self;
    }
    return _mapView;
}

- (BaseTableView *)nearbyTableView
{
    if (!_nearbyTableView) {
        _nearbyTableView = [[BaseTableView alloc] init];
        _nearbyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _nearbyTableView.tableViewCellClass = [AddressMapCell class];
        _nearbyTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _nearbyTableView.separatorColor = MainBackgroundColor;
//        _nearbyTableView.noDataTitle = @"亲，搜索不到任何地址哦~";
        WS(weakSelf);
        _nearbyTableView.cellSelectBlock = ^ (UITableView *tableView, NSIndexPath *indexPath) {
            weakSelf.addressInfo = weakSelf.nearbyTableView.dataArray[indexPath.row];
            weakSelf.selectedIndex = indexPath.row;
            [tableView reloadData];
            weakSelf.shouldSearchNearby = NO;
            CLLocationCoordinate2D center = CLLocationCoordinate2DMake(weakSelf.addressInfo.latitude.doubleValue, weakSelf.addressInfo.longitude.doubleValue);
            BMKCoordinateSpan span = BMKCoordinateSpanMake(0.003, 0.003);
            BMKCoordinateRegion region = BMKCoordinateRegionMake(center, span);
            [weakSelf.mapView setRegion:region];
        };
        _nearbyTableView.cellConfigureBlock = ^ (UITableViewCell *cell, id data, NSIndexPath *indexPath) {
            ((AddressMapCell *)cell).selectedIcon.hidden = (weakSelf.selectedIndex!=indexPath.row);
        };
    }
    return _nearbyTableView;
}

- (UIImageView *)currentLocationView {
    if (!_currentLocationView) {
        _currentLocationView = [[UIImageView alloc] init];
        _currentLocationView.contentMode = UIViewContentModeScaleAspectFit;
        _currentLocationView.image = [UIImage imageNamed:@"ic_location"];
    }
    return _currentLocationView;
}

- (UIButton *)resetLocationBtn {
    if (!_resetLocationBtn) {
        _resetLocationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_resetLocationBtn setImage:[UIImage imageNamed:@"ic_reset_loacation"] forState:UIControlStateNormal];
        [_resetLocationBtn addTarget:self action:@selector(resetLocationAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetLocationBtn;
}


@end
