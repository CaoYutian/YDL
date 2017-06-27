//
//  MineVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/9. //  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "MineVC.h"
#import "QualificationCertificationVC.h"
#import "ChooseIdentityVC.h"

#import "AddressVC.h"
#import "SupplierVC.h"
#import "MyInvoiceVC.h"
#import "SetVC.h"
#import "UserInfoVC.h"

#import "HeaderOfmine.h"

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *MineTableView;
@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navTintColor = [UIColor grayColor];
    self.navAlpha = 0;

}

- (void)SetUpUI {
    
    UIView *nilView = [[UIView alloc] init];
    nilView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = nilView;
    UIImageView *backGroundImgV = [[UIImageView alloc] initWithImage:IMAGENAMED(@"backgroundOfmine")];
    backGroundImgV.frame = CGRectMake(0, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT);
    [self.view addSubview:backGroundImgV];
    
    [self.view addSubview:self.MineTableView];
    self.MineTableView.delegate = self;
    self.MineTableView.backgroundColor = [UIColor clearColor];
    [self.MineTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    HeaderOfmine *hearderView = [[HeaderOfmine alloc] initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, FitheightRealValue(130))];
    [hearderView callBack:^(BOOL isClick) {
        if (isClick) {
            [self presentVc:[LogInVC new]];
//            [self pushVc:[UserInfoVC new]];
        }
    }];
    self.MineTableView.tableHeaderView = hearderView;

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.imageView.image = IMAGENAMED(self.imageArray[indexPath.row]);
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.textLabel.font = FitFont(14);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return FitheightRealValue(44);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
            [self pushVc:[ChooseIdentityVC new]];
            break;
            
        case 1:
            [self pushVc:[AddressVC new]];
            break;
            
        case 2:
            [self pushVc:[SupplierVC new]];
            break;
            
        case 3:
            [self pushVc:[MyInvoiceVC new]];
            break;
            
        case 4:
            [self pushVc:[SetVC new]];
            break;
    }
}

- (UITableView *)MineTableView {
    if (!_MineTableView) {
        _MineTableView = [[UITableView alloc] init];
        _MineTableView.delegate = self;
        _MineTableView.dataSource = self;
        _MineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _MineTableView;

}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"icon_sign", @"MarkIcon", @"icon_supplier_detail",@"icon_mybill",@"icon_setting"];
    }
    return _imageArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"资质认证", @"我的卸气点", @"我的供应商",@"我的发票",@"设置"];
    }
    return _titleArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
