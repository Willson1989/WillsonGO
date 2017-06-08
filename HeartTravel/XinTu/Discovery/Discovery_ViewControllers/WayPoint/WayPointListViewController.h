//
//  WayPointListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayPointList.h"
#import "pointType.h"
#import "WayPointListCell.h"
#import "WayPointDetailViewController.h"

@interface WayPointListViewController : UIViewController

@property (retain,nonatomic) UITableView * myTableView;
@property (retain,nonatomic) WayPointList * wPointList;
@property (retain,nonatomic) NSMutableArray * wPointListArray;
@property (retain,nonatomic) NSMutableArray * typeArray;


@property (copy,nonatomic) NSString * wayPoiTitle;

@property (assign,nonatomic) NSInteger  cat_ID;
@property (copy,nonatomic)   NSString * city_id;
@property (assign,nonatomic) NSInteger  page;

@property (assign,nonatomic) NSInteger  pointCount;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@property (assign,nonatomic) BOOL  isUpLoad;
@property (assign,nonatomic) BOOL  isDownLoad;

@property (assign,nonatomic) BOOL  isFirstLoad;

@end
