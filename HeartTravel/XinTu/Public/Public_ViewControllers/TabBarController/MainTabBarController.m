//
//  MainTabBarController.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MainTabBarController.h"


@implementation MainTabBarController

-(instancetype)init{
    
    if (self = [super init]) {
        
        [self setupNavigationController];
    }
    
    return self;
}

-(void)setupNavigationController{
    
    CountryListMainViewController *countryListVC = [[CountryListMainViewController alloc]init];
    UINavigationController * cNavigationC = [[UINavigationController alloc]initWithRootViewController:countryListVC];
    
    AudiovisualViewController *audiovisualVC     = [[AudiovisualViewController alloc]init];
    UINavigationController * aNavigationC = [[UINavigationController alloc]initWithRootViewController:audiovisualVC];
    
    HotTravelListViewController *hotTravelVC = [[HotTravelListViewController alloc]init];
    UINavigationController * hNavigationC = [[UINavigationController alloc]initWithRootViewController:hotTravelVC];
    

    self.viewControllers = @[hNavigationC,cNavigationC,aNavigationC];
//<<<<<<< HEAD
//
//    cNavigationC.tabBarItem.image = [[UIImage imageNamed:@"BeanTrip-tejia.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    aNavigationC.tabBarItem.image = [[UIImage imageNamed:@"user_info_inbox_button_image@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    hNavigationC.tabBarItem.image = [[UIImage imageNamed:@"tabbar_trips_button_image_hl@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    cNavigationC.tabBarItem.selectedImage = [[UIImage imageNamed:@"BeanTrip-tejia.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  
//    aNavigationC.tabBarItem.selectedImage = [[UIImage imageNamed:@"user_info_inbox_button_image_hl@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//=======
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    cNavigationC.tabBarItem.image = [[UIImage imageNamed:@"BeanTrip-tuijian.png"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    aNavigationC.tabBarItem.image = [[UIImage imageNamed:@"BeanTrip-fenlei.png"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    hNavigationC.tabBarItem.image = [[UIImage imageNamed:@"BeanTrip-tejia.png"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    
//    cNavigationC.tabBarItem.selectedImage = [[UIImage imageNamed:@"navbar_city@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//  
//    aNavigationC.tabBarItem.selectedImage = [[UIImage imageNamed:@"user_info_inbox_button_image_hl@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    
//    hNavigationC.tabBarItem.selectedImage = [[UIImage imageNamed:@"tabbar_trips_button_image@2x.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    
    UIView * BKGView = [[UIView alloc] initWithFrame:self.tabBar.frame];
    BKGView.backgroundColor = SELECT_COLOR;
    [self.tabBar insertSubview:BKGView atIndex:2];
    self.tabBar.opaque = YES;
    UIColor * tintcolor = [PublicFunction getColorWithRed:22.0 Green:131.0 Blue:145.0];
    UIColor * barTintColor = SELECT_COLOR;
    [self.tabBar setTintColor:tintcolor];
    [self.tabBar setBarTintColor:barTintColor];
    UITabBar * tabbar = self.tabBar;
    tabbar.backgroundColor = SELECT_COLOR;
    cNavigationC.tabBarItem.title = @"发现";
    aNavigationC.tabBarItem.title = @"视听";
    hNavigationC.tabBarItem.title = @"推荐";
    
    [countryListVC release];
    [audiovisualVC release];
    [hotTravelVC release];
    [cNavigationC release];
    [aNavigationC release];
    [hNavigationC release];
}


@end
