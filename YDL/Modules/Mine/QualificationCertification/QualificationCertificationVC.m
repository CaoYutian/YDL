//
//  QualificationCertificationVC.m
//  YQW
//
//  Created by Sunshine on 2017/5/15.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "QualificationCertificationVC.h"
#import "QCDetailVC.h"
#import "QfCfCell.h"

@interface QualificationCertificationVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *QCTableView;
@property (nonatomic, strong) NSArray *titleArr;
@property (nonatomic, strong) NSArray *detailTileArr;
@property (nonatomic, strong) NSArray *titleIconPicArr;
@property (nonatomic, strong) NSArray *QCFileTypeArr;


@end

@implementation QualificationCertificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"上传资质文件";

}

- (void)SetUpUI {
    self.messageBtn.hidden = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.QCTableView];
    [self.QCTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(64, 0, 0, 0));
    }];

}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"QfCfCell";
    QfCfCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellAccessoryNone;

    cell.titleIconPic.image = IMAGENAMED(self.titleIconPicArr[indexPath.row]);
    cell.titleName.text = self.titleArr[indexPath.row];
    cell.titleDetail.text = self.detailTileArr[indexPath.row];
    [cell.operationBtn setTitle:@"上传" forState:UIControlStateNormal];
    
    [cell ChooseOpration:^(BOOL isSelected) {
        [self upload];
    }];
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    QCDetailVC *QCDetail = [[QCDetailVC alloc] init];
    QCDetail.title = self.titleArr[indexPath.row];
    
    switch (indexPath.row) {
        case 0: QCDetail.QCFileType = groupCode;

            break;
            
        case 1: QCDetail.QCFileType = businessLC;
            
            break;
            
        case 2: QCDetail.QCFileType = taxRegCF;
            
            break;
            
        case 3: QCDetail.QCFileType = powerBook;
            
            break;
            
        case 4: QCDetail.QCFileType = openAccountLC;
            
            break;
            
        case 5: QCDetail.QCFileType = legalRepresentative;
            
            break;
            
        case 6: QCDetail.QCFileType = safetyProdTLC;
            
            break;
            
        case 7: QCDetail.QCFileType = lngBusinessLC;
            
            break;
    }
    [self pushVc:QCDetail];

}

#pragma mark -- 上传
- (void)upload {
    
}

#pragma mark -- 查看
- (void)lookOver; {
    
}

- (UITableView *)QCTableView {
    if (!_QCTableView) {
        _QCTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _QCTableView.delegate = self;
        _QCTableView.dataSource = self;
        _QCTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _QCTableView.backgroundColor = [UIColor clearColor];
        [_QCTableView registerNib:[UINib nibWithNibName:@"QfCfCell" bundle:nil] forCellReuseIdentifier:@"QfCfCell"];
    }
    return _QCTableView;
}

//- (NSArray *)QCFileTypeArr {
//    if (!_QCFileTypeArr) {
//        _QCFileTypeArr = @[];
//    }
//}

- (NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"组织机构代码证", @"营业执照", @"税务登记证",@"授权委托书"
                        ,@"开户许可证", @"法人代表证",@"燃气（危险品）经营许可证"];
    }
    return _titleArr;
}

- (NSArray *)detailTileArr {
    if (!_detailTileArr) {
        _detailTileArr = @[@"证件要求：必填",@"证件要求：必填", @"证件要求：必填", @"证件要求：必填",
                           @"证件要求：选填",@"证件要求：选填", @"证件要求：选填"];
    }
    return _detailTileArr;
}

- (NSArray *)titleIconPicArr {
    if (!_titleIconPicArr) {
        _titleIconPicArr = @[@"icon_group_Qc",@"icon_yingye_Qc", @"icon_shuiwu_Qc", @"sqwt_Qc",
                             @"icon_kaihu_Qc",@"icon_faren_Qc", @"icon_weixian_Qc"];
    }
    return _titleIconPicArr;
}

@end
