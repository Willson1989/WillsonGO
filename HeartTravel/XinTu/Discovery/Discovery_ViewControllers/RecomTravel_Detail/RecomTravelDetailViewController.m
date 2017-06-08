//
//  RecomTravelDetailViewController.m
//  XinTu
//
//  Created by WillHelen on 15/7/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RecomTravelDetailViewController.h"

@interface RecomTravelDetailViewController ()<UIWebViewDelegate,MONActivityIndicatorViewDelegate>

@end

@implementation RecomTravelDetailViewController

-(void)dealloc{
    
    [self.myWebView release];
    [self.MONAView release];
    [super dealloc];
}

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
    self.MONAView.center = self.view.center;
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
    self.navigationItem.title = @"推荐行程";
    [leftButton release];
}

-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setupMyWenView{
    self.myWebView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen]bounds]), CGRectGetHeight([[UIScreen mainScreen]bounds]))];
    self.myWebView.delegate = self;
    [self.view addSubview:self.myWebView];
    [self.myWebView release];
}

-(void)practicalPageLoad{
    NSURL * url = [NSURL URLWithString:self.view_url];
    NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.myWebView loadRequest:request];
    });
    [request release];
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"已经开始加载推荐行程详情的页面");
    [self.MONAView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSLog(@"网页加载完毕");
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
}

@end
