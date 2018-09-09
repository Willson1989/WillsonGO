//
//  ZYWebViewController.m
//  TempOCProoj
//
//  Created by 朱金倩 on 2018/8/28.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

#import "ZYWebViewController.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>


@interface ZYWebViewController ()<WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler>

@property (nonatomic, strong) WKWebView *webView;


@end

@implementation ZYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    WKPreferences *preference = [[WKPreferences alloc] init];
    preference.javaScriptEnabled = YES;
    config.preferences = preference;
    [config.userContentController addScriptMessageHandler:self name:@"aaa"];
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webView];
    self.webView.navigationDelegate = self;
    self.webView.UIDelegate = self;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(0, 0, 200, 40);
    btn.backgroundColor = [UIColor redColor];

    btn.center = CGPointMake(self.view.bounds.size.width / 2, self.view.bounds.size.height - 100);
    [self.webView addSubview:btn];
    
}

- (void)btnAction {
    //changeBgColor(color)
    NSString *jsStr = @"changeBgColor('blue');";

    //NSString *jsStr = @"document.getElementById('outer').style.background = 'red';";
    [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable obj, NSError * _Nullable error) {
        
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSURL *url = [self htmlResource];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}

- (NSURL *)htmlResource {
    NSString * bundleURLStr = [[NSBundle mainBundle] bundleURL].absoluteString;
    NSString * htmlPath = [NSString stringWithFormat:@"%@/jsTest.html", bundleURLStr];
    NSURL * url = [NSURL URLWithString:htmlPath];
    return url;
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"message : %@",NSStringFromClass(object_getClass(message.body)));
    NSString *jsonStr = (NSString *)message.body;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err = nil;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
    
    NSDictionary *dic = (NSDictionary *)jsonObj;
    NSLog(@"json dic : %@",dic);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"didFailProvisionalNavigation");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
