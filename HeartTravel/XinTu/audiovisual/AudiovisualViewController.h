//
//  AudiovisualViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicViewController.h"
#import "VideoListViewController.h"

@interface AudiovisualViewController : UIViewController<MusicViewControllerDelegate, TopTabBarDelegate>

@property (retain,nonatomic) MusicViewController * leftVC;
@property (retain,nonatomic) VideoListViewController * rightVC;
@property (retain,nonatomic) TopTabBar * myBar;

@end
