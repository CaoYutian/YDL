//
//  QCDetailVC.h
//  YQW
//
//  Created by Sunshine on 2017/6/22.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"

typedef NS_ENUM(NSInteger, QCFileType) {
    groupCode,            //组织机构代码证
    businessLC,           //经营执照
    taxRegCF,             //税务登记证
    powerBook,            //授权委托证
    openAccountLC,        //开户许可证
    legalRepresentative,  //法人代表证
    safetyProdTLC,        //安全生产证
    lngBusinessLC         //LNG经营许可证
};

@interface QCDetailVC : BaseVC
@property (nonatomic, assign) QCFileType QCFileType;


@end
