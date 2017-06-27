//
//  BaseAPIRequest.m
//  CYTHighlights
//
//  Created by 。。。 on 2017/3/20.
//  Copyright © 2017年 isofoo. All rights reserved.
//

#import "BaseAPIRequest.h"
#import "BaseAPIProxy.h"
#import "CYTMD5.h"
#import "GetEquipmentModel.h"
#import "LogInAPIRequest.h"
#import "AppDelegate.h"

#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define APPKEY  @"c6951b95e33674fe39d9660580032115"

@interface BaseAPIRequest ()
@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, copy, readwrite) NSString *successMessage;
@property (nonatomic, readwrite) APIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong)UIView *hudSuperView;
@property (nonatomic, assign)NSInteger reloginCount;

@end

@implementation BaseAPIRequest

-(instancetype)initWithDelegate:(id)delegate paramSource:(id)paramSource
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _paramSource = paramSource;
        _validator = (id)self;
        _errorType = APIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(APIManager)]) {
            self.child = (id <APIManager>)self;
        }
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _paramSource = nil;
        _validator = (id)self;
        _errorType = APIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(APIManager)]) {
            self.child = (id <APIManager>)self;
        }
    }
    return self;
}

- (void)dealloc {
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - calling api
-(NSInteger)loadDataWithHUDOnView:(UIView *)view {
    return [self loadDataWithHUDOnView:view HUDMsg:@""];
}

-(NSInteger)loadDataWithHUDOnView:(UIView *)view HUDMsg:(NSString *)HUDMsg
{
    [self cancelAllRequests];
    if (view) {
        self.hudSuperView = view;
        [MBProgressHUD showLoadingHUD:HUDMsg onView:self.hudSuperView];
    }
    NSDictionary *params = [self.paramSource paramsForApi:self];
    if ([self.child respondsToSelector:@selector(reformParamsForApi:)]) {
        params = [self.child reformParamsForApi:params];
    }
    params = [self publicParamAndprivateParamJoinTogether:params];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSDictionary *)publicParamAndprivateParamJoinTogether:(NSDictionary *)privatepara {
    
    //uuid
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    //手机系统
    NSString *os = [NSString stringWithFormat:@"iOS %.2f",CYT_SYSTEM_VERSION];
    //时间戳
    NSString *timestamp = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970] * 1000];
    
    NSString *Pingjie = [NSString stringWithFormat:@"%@%@",APPKEY,timestamp];
    NSString *signature = [NSString stringWithFormat:@"%@",[CYTMD5 md5:Pingjie]];
    
    NSString *device = [GetEquipmentModel EquipmentModel];
    
    NSMutableDictionary *PublicDic = [[NSMutableDictionary alloc] init];
    [PublicDic setValue:APPKEY forKey:@"appkey"];
    [PublicDic setValue:uuid forKey:@"uuid"];
    [PublicDic setValue:CYTAppVersion forKey:@"app_version"];
    [PublicDic setValue:os forKey:@"os"];
    [PublicDic setValue:timestamp forKey:@"timestamp"];
    [PublicDic setValue:signature forKey:@"signature"];
    [PublicDic setValue:userManager.userData.user_token forKey:@"user_token"];
    [PublicDic setValue:device forKey:@"device"];
    [PublicDic setValue:userManager.userData.account_id forKey:@"account_id"];
    
    [PublicDic addEntriesFromDictionary:privatepara];
    return PublicDic;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params {
    NSInteger requestId = 0;
    if ([self isReachable]) {
        if ([self.child respondsToSelector:@selector(requestSerializer)]) {
            [BaseAPIProxy sharedInstance].requestSerializer = self.child.requestSerializer;
        } else {
            [BaseAPIProxy sharedInstance].requestSerializer = [AFHTTPRequestSerializer serializer]; // 拼接，如果是JSON换成AFJSON
        }
        if ([self.child respondsToSelector:@selector(responseSerializer)]) {
            [BaseAPIProxy sharedInstance].responseSerializer = self.child.responseSerializer;
        } else {
            [BaseAPIProxy sharedInstance].responseSerializer = [AFJSONResponseSerializer serializer];
        }
        [[BaseAPIProxy sharedInstance] callAPIWithRequestType:self.child.requestType params:params requestPath:self.child.requestPath uploadBlock:[self.paramSource respondsToSelector:@selector(uploadBlock:)]?[self.paramSource uploadBlock:self]:nil success:^(BaseAPIResponse *response) {
            [self successedOnCallingAPI:response];
        } fail:^(BaseAPIResponse *response) {
            [self failedOnCallingAPI:response withErrorType:response.errorType];
        }];
        [self.requestIdList addObject:@(requestId)];
        return requestId;
        
    } else {
        [self failedOnCallingAPI:nil withErrorType:APIManagerErrorTypeNoNetWork];
        return requestId;
    }
    return requestId;
}

- (void)successedOnCallingAPI:(BaseAPIResponse *)response
{
    if (self.hudSuperView) {
        [MBProgressHUD hideLoadingHUD];
    }
    self.responseData.error_code = [response.responseData[@"error_code"] integerValue];
    [self removeRequestIdWithRequestID:response.requestId];
    NSLog(@"%@:%@", [self.child requestPath],response.responseData);
    if ([self.child respondsToSelector:@selector(responseClass)]) {
        self.responseData =  [[self.child responseClass] yy_modelWithDictionary:response.responseData];
        if (self.responseData.error_code != 100) {
            response.msg = self.responseData.error_text;
            [self failedOnCallingAPI:response withErrorType:APIManagerErrorTypeDefault];
            return;
        }
    } else {
        self.responseData = response.responseData;
    }
    
    if ([self.validator respondsToSelector:@selector(manager:isCorrectWithCallBackData:)] && ![self.validator manager:self isCorrectWithCallBackData:self.responseData]) {
        [self failedOnCallingAPI:response withErrorType:APIManagerErrorTypeNoContent];
    } else {
        if ([self.child respondsToSelector:@selector(reformData)]) {
            [self.child reformData];
        }
        [self.delegate managerCallAPIDidSuccess:self];
    }
}

- (void)failedOnCallingAPI:(BaseAPIResponse *)response withErrorType:(APIManagerErrorType)errorType
{
    if (self.hudSuperView) {
        [MBProgressHUD hideLoadingHUD];
    }
    
    self.errorType = errorType;
    self.msg = response.msg;
    [self removeRequestIdWithRequestID:response.requestId];
    switch (errorType) {
        case APIManagerErrorTypeDefault:
            self.errorMessage = response.msg;
            break;
        case APIManagerErrorTypeSuccess:
            break;
        case APIManagerErrorTypeNoContent:
            break;
        case APIManagerErrorTypeParamsError:
            break;
        case APIManagerErrorTypeTimeout:
            self.msg = Tip_RequestOutTime;
            break;
        case APIManagerErrorTypeNoNetWork:
            self.msg = Tip_NoNetwork;
            break;
        case APIManagerErrorLoginTimeout:
            self.msg = Tip_LoginTimeOut;
            break;
        default:
            break;
    }
    if (self.errorType==APIManagerErrorLoginTimeout) {
        if (!self.reloginCount && ![self isKindOfClass:[LogInAPIRequest class]]) {
            self.reloginCount++;
            [LogInAPIRequest autoReloginSuccess:^{
                [self loadDataWithHUDOnView:self.hudSuperView];
            } failure:^{
                [UserManager removeLocalUserLoginInfo];
                [kAppDelegate showMainView];
            }];
        } else {
            [UserManager removeLocalUserLoginInfo];
            [kAppDelegate showMainView];
        }
    } else {
        [self.delegate managerCallAPIDidFailed:self];
        if (self.hudSuperView && !self.disableErrorTip) {
            [MBProgressHUD showMsgHUD:response.msg];
        }
    }
    
    if (self.responseData.error_code==11010) {
        [LogInAPIRequest autoReloginSuccess:^{
            [self loadDataWithHUDOnView:self.hudSuperView];
        } failure:^{
            [UserManager removeLocalUserLoginInfo];
            [kAppDelegate showMainView];
        }];
    }
}

#pragma mark - private methods
- (void)cancelAllRequests
{
    [[BaseAPIProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [self removeRequestIdWithRequestID:requestID];
    [[BaseAPIProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

-(NSString *)paramsSignatureString:(NSDictionary *)params
{
    if (![params isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *keyArray = [params allKeys];
    NSArray *sortKeyArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSString *str1 = @"";
    for (int i=0; i<sortKeyArray.count; i++) {
        NSString *value = params[sortKeyArray[i]];
        
        if ([value isKindOfClass:[NSArray class]]) {
            continue;
        }
        if (i>0 && str1.length) {
            str1 = [str1 stringByAppendingString:@"&"];
        }
        if ([value isKindOfClass:[NSDictionary class]]) {
            value = [self paramsSignatureString:(NSDictionary *)value];
        }
        str1 = [str1 stringByAppendingString:[NSString stringWithFormat:@"%@=%@",sortKeyArray[i],value]];
    }
    return str1;
}

#pragma mark - getters and setters
- (BOOL)isReachable
{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusUnknown) {
        return YES;
    } else {
        return [[AFNetworkReachabilityManager sharedManager] isReachable];
    }
}

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

@end
