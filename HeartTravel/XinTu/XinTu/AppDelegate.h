//
//  AppDelegate.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabBarController.h"
#import "RightViewController.h"
#import "ABCIntroView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,ABCIntroViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, assign) BOOL isFull; // 是否全屏

@property (nonatomic, assign) NSInteger timeCount;

@property (nonatomic, retain) NSTimer *timer;

@property (nonatomic, retain) ABCIntroView *introView;

@end

