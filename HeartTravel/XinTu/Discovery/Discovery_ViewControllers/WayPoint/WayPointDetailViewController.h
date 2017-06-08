//
//  WayPointDetailViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntroductionCell.h"
#import "WayPointDetailCell.h"

@interface WayPointDetailViewController : UIViewController

@property (retain,nonatomic) UITableView * myTableView;
@property (retain,nonatomic) WayPointDetailCell * cell0;
@property (retain,nonatomic) WayPointDetailCell * cell1;
@property (retain,nonatomic) WayPointDetailCell * cell2;

@property (retain,nonatomic) WayPoint * wPoint;

@property (copy,nonatomic) NSString * poi_id;
@property (copy,nonatomic) NSString * cname;
@property (copy,nonatomic) NSString * ename;
@property (retain,nonatomic) NSMutableArray * wpArry;
@property (retain,nonatomic) NSMutableDictionary * descDic;
@property (retain,nonatomic) NSArray * keyArray;

@property (retain,nonatomic) UIImageView * topImageView;
@property (retain,nonatomic) TopNavigationView * topNavView;

@property (assign,nonatomic) BOOL isExtend;
@property (assign,nonatomic) BOOL isFirstLoad;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@end
