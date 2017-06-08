//
//  VideoPlayViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "VideoPlayViewController.h"

@implementation VideoPlayViewController

-(void)dealloc{
    [_playWeb release];
    [super dealloc];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popBack)];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];

    
    
}

-(void)creatWebView:(NSURL *)url{
    
    self.playWeb = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.playWeb.backgroundColor = [UIColor blackColor];
    
    self.playWeb.delegate = self;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.playWeb loadRequest:request];
    
    [self.view addSubview:self.playWeb];
    
    [self.playWeb setScalesPageToFit:YES];
    
    self.playWeb.allowsInlineMediaPlayback = NO;
    
    [_playWeb release];
    
    
    
}

-(void)popBack{
    
    [self dismissViewControllerAnimated:YES completion:^{}];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    [[PlayMusicViewController shareDataHandle].streamer pause];
    
    [[PlayMusicViewController shareDataHandle].playButton setImage:[UIImage imageNamed:@"songlist_play_normal.png"] forState:UIControlStateNormal];
}

-(void) viewDidDisappear:(BOOL)animated {
    
    [self.playWeb loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
    [self.playWeb removeFromSuperview];
    
    [[PlayMusicViewController shareDataHandle].streamer start];
}

@end
