//
//  HotGuideDetailViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGuide.h"
#import "PointGuide.h"
#import "HotGuideListCell.h"
#import "GuideListTitleCell.h"
#import "GuideDetailCell.h"
#import "WayPointDetailViewController.h"
#import "FunctionView.h"


@interface HotGuideDetailViewController : UIViewController<UMSocialUIDelegate>

@property (retain,nonatomic) TopNavigationView  * topNavView;
@property (retain,nonatomic) UITableView * myTableView;
@property (copy,nonatomic)   NSString * guideID;
@property (assign,nonatomic) NSInteger page;
@property (assign,nonatomic) NSInteger pointCount;

@property (retain,nonatomic) HotGuide * hGuide;
@property (retain,nonatomic) PointGuide * pGuide;
@property (retain,nonatomic) UIImageView * topImageV;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@property (retain,nonatomic) UIButton * collectButton;
@property (retain,nonatomic) UIButton * shareButton;

@property (assign,nonatomic) BOOL  appeared;
@property (retain,nonatomic) FunctionView * funcView;


@end
