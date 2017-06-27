//
//  HomeWebView.m
//  YQW
//
//  Created by Sunshine on 2017/5/17.
//  Copyright © 2017年 Sunshine. All rights reserved.
//

#import "HomeWebView.h"
#import "CYTWebProgressLayer.h"

@interface HomeWebView (){
    CYTWebProgressLayer *_progressLayer;
}

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HomeWebView

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)SetUpUI {
    _progressLayer = [CYTWebProgressLayer  new];
    _progressLayer.frame = CGRectMake(0, 42, CYTMainScreen_WIDTH, 2);
    [self.navigationController.navigationBar.layer addSublayer:_progressLayer];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CYTMainScreen_WIDTH, CYTMainScreen_HEIGHT)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"www.baidu.com"]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];

}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [_progressLayer startLoad];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [_progressLayer finishedLoad];
    
    // 禁用用户选择
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    
    // 禁用长按弹出框
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    //将tianbai对象指向自身
    self.jsContext[@"HomeWebView"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常信息：%@", exceptionValue);
    };
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
   
    return YES;
}

- (NSString *)URLEncoded:(NSString *)url {
    if (url.length <= 0) {
        return url;
    }
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)url,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    return encodedString;
}
#pragma mark 清除缓存
-(void)cleanCookie {
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

#pragma mark 刷新页面
-(void)refeshCurView {
//   NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.MainUrl]];
//   [self.webView loadRequest:request];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [_progressLayer finishedLoad];
}

- (void)dealloc {
    [_progressLayer closeTimer];
    [_progressLayer removeFromSuperlayer];
    _progressLayer = nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self popToRootVc];
}

@end
