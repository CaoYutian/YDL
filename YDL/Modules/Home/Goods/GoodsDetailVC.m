//
//  GoodsDetailVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "GoodsDetailVC.h"
#import "LNGQualityReportVC.h"
#import "ChatViewController.h"
#import "CheckOrderInfoVC.h"

#import "footerView_goodsDetail.h"

#import "GoodsCell_Mall.h"
#import "LNGInfoCell.h"
#import "LNGCarInfoCell.h"

@interface GoodsDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *goodDetailTabbleView;

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation GoodsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    
    [self.view addSubview:self.goodDetailTabbleView];
    [self.goodDetailTabbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];
    
    footerView_goodsDetail *footView = [[footerView_goodsDetail alloc] initWithFrame:CGRectMake(0, CYTMainScreen_HEIGHT - FitheightRealValue(40), CYTMainScreen_WIDTH, FitheightRealValue(40))];
    [footView ChooseOperationCallBack:^(NSInteger Choose) {
        switch (Choose) {
            case 1:
                [self ContactTheMerchant];
                break;
                
            case 2:
                [self callUp];
                break;
                
            case 3:
                [self buyNow];
                break;
        }
    }];
    [self.view addSubview:footView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        GoodsModel *goodsData = [[GoodsModel alloc] init];
        goodsData.goods_title = @"内蒙古乌审旗管道气";
        goodsData.goods_details = @"鄂尔多斯市星星能源有限公司";
        goodsData.goods_count = @"2950.00";
        
        GoodsCell_Mall *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[GoodsCell_Mall alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        [((GoodsCell_Mall *)cell) setCellData:goodsData atIndexPath:indexPath];
        
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *cellId = @"LNGInfoCell";
        
        LNGInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (indexPath.section == 2) {
        static NSString *cellId = @"LNGCarInfoCell";
        
        LNGCarInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }else if (indexPath.section == 3){
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGENAMED(@"icon_sign");
        cell.textLabel.text = @"气质报告";
        cell.textLabel.font = FitFont(14);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.imageView.image = IMAGENAMED(@"MarkIcon");
        cell.textLabel.text = @"新奥能源贸易有限公司";
        cell.textLabel.font = FitFont(14);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        return FitheightRealValue(80);
    }else if (indexPath.section == 1){
        return 100;
    }else if (indexPath.section == 2){
        return 185;
    }
    
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 3) {
        [self pushVc:[LNGQualityReportVC new]];
    }
    if (indexPath.section == 4) {
        
    }
}

#pragma mark 联系商家
- (void)ContactTheMerchant {
    ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:@"13621202803_2" conversationType:EMConversationTypeChat];
    chatController.title = @"13621202803_2";
    chatController.navTintColor = NavigationBarBackgroundColor;
    chatController.navBarTintColor = NavigationBarBackgroundColor;
    chatController.title = @"联系商家";

    //                NSString *headUrl;
    //                if ([_contactInfo.user_logo hasPrefix:@"http"]) {
    //                    headUrl= [NSString stringWithFormat:@"%@",_contactInfo.user_logo];
    //                }else {
    //                    headUrl = [NSString stringWithFormat:@"%@%@",APPBaseUrl,_contactInfo.user_logo];
    //                }
    //
    //                chatController.urlStr = _contactInfo.user_logo;

    [self pushVc:chatController];
}

#pragma mark 拨打电话
- (void)callUp {
    [CommonUtils call:@"13621202803"];
}

#pragma mark 立即购买
- (void)buyNow {
    [self pushVc:[CheckOrderInfoVC new]];
}

- (UITableView *)goodDetailTabbleView {
    if (!_goodDetailTabbleView) {
        _goodDetailTabbleView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _goodDetailTabbleView.delegate = self;
        _goodDetailTabbleView.dataSource = self;
        _goodDetailTabbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _goodDetailTabbleView.backgroundColor = [UIColor clearColor];
        
        [_goodDetailTabbleView registerClass:[GoodsCell_Mall class] forCellReuseIdentifier:@"GoodsCell_Mall"];
        [_goodDetailTabbleView registerNib:[UINib nibWithNibName:@"LNGInfoCell" bundle:nil] forCellReuseIdentifier:@"LNGInfoCell"];
        [_goodDetailTabbleView registerNib:[UINib nibWithNibName:@"LNGCarInfoCell" bundle:nil] forCellReuseIdentifier:@"LNGCarInfoCell"];
        
        
    }
    return _goodDetailTabbleView;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = @[@"icon_sign", @"MarkIcon"];
    }
    return _imageArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[@"气质报告", @"新奥能源贸易有限公司"];
    }
    return _titleArray;
}

@end
