//
//  RightViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayMusicViewController.h"
#import "DiaryDollectViewController.h"
#import "FeatureDollectViewController.h"
#import "AboutViewController.h"

@interface RightViewController : UIViewController

@property (nonatomic, retain) UIButton *DiaryDollectButton;

@property (nonatomic, retain) UIButton *FeatureDollectButton;

@property (nonatomic, retain) UISwitch *nightModeSwitch;

@property (nonatomic, retain) UILabel *nightLabel;

@property (nonatomic, retain) UIButton *clearButton;

@property (nonatomic, retain) UIButton *musicButton;

@property (nonatomic, retain) UIButton *aboutButton;

@end
