//
//  HomeWebView.h
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "BaseVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

@end


@interface HomeWebView : BaseVC<UIWebViewDelegate ,JSObjcDelegate>

@property (nonatomic, strong) JSContext *jsContext;

@end
