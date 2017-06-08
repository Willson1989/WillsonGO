//
//  SideViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SideViewController.h"

@implementation SideViewController

#pragma mark  将抽屉页面置成单例类
+(YRSideViewController *)shareDataHandle{
    static YRSideViewController *sideViewController = nil;
    static dispatch_once_t myPredicate;
    dispatch_once(&myPredicate, ^{
        
        sideViewController = [[YRSideViewController alloc] init];
    });
    return sideViewController;
    
}

@end
