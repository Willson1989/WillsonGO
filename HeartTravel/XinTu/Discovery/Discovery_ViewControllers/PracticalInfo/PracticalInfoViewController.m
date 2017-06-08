//
//  PracticalInfoViewController.m
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PracticalInfoViewController.h"

@interface PracticalInfoViewController ()<UIWebViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation PracticalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupMyWenView];
    [self setupNavigationItems];
    [self initMONA];
    [self practicalPageLoad];
}


-(void)initMONA{
    self.MONAView = [[MONActivityIndicatorView alloc] init];
    self.MONAView.delegate = self;
    self.MONAView.numberOfCircles = 3;
    self.MONAView.radius = 10;
    self.MONAView.internalSpacing = 3;
    self.MONAView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:self.MONAView];
    [self.MONAView release];
}

-(UIColor *)activityIndicatorView:(MONActivityIndicatorView *)activityIndicatorView circleBackgroundColorAtIndex:(NSUInteger)index{
    return SELECT_COLOR;
}

-(void)setupNavigationItems{
    [PublicFunction setupNavigationBarforViewController:self];
    NavigationLeftButton * leftButton = [[NavigationLeftButton alloc]init];
    [leftButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    self.navigationItem.title = @"实用信息";
    [leftButton release];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupMyWenView{
    self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, MYWIDTH, MYHEIGHT)];
    self.myWebView.delegate = self;
//    self.myWebView.scalesPageToFit = YES;
    [self.view addSubview:self.myWebView];
    [self.myWebView release];
}

-(void)practicalPageLoad{
    NSURL * url = [NSURL URLWithString:self.overview_url];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.myWebView loadRequest:request];
    });
    [request release];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.MONAView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.MONAView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [PublicFunction showAlertViewWithTitle:@"" andMessage:error.localizedDescription forViewController:self cancelButtonTitle:nil];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
