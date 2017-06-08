//
//  AudiovisualViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "AudiovisualViewController.h"

@implementation AudiovisualViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"视听";
    
    self.navigationController.navigationBar.translucent = NO;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupTopBar];
    [self setupSubViewController];
    
    
}
-(void)setupTopBar{
    self.myBar = [[TopTabBar alloc]initTopTabBarWithLeftName:@"电台" andRightName:@"视频"];
    self.myBar.myDelegate = self;
    [self.view addSubview:self.myBar];
}

-(void)setupSubViewController{
    
    self.leftVC = [[MusicViewController alloc] init];
    self.rightVC = [[VideoListViewController alloc] init];
    self.leftVC.delegate = self;
    
    [self.view addSubview:self.rightVC.view];
    [self.view addSubview:self.leftVC.view];

    [self.view bringSubviewToFront:self.leftVC.view];
    [self.view bringSubviewToFront:self.myBar];
    
    [self.leftVC release];
    [self.rightVC release];
    
}
-(void)switchLeftPage{
    NSLog(@"切换到左视图");
    [self.view bringSubviewToFront:self.leftVC.view];
    [self.view bringSubviewToFront:self.myBar];
    [self.leftVC getCacheData];
    
}

-(void)switchRightPage{
    NSLog(@"切换到右视图");
    [self.view bringSubviewToFront:self.rightVC.view];
    [self.view bringSubviewToFront:self.myBar];
    [self.rightVC getCacheData];
}
-(void)pushSubVCmethod:(UIViewController *)radioVC{

    [self.navigationController pushViewController:radioVC animated:YES];
}

-(void)dealloc{
    [self.leftVC release];
    [self.rightVC release];
    [super dealloc];
}



@end
