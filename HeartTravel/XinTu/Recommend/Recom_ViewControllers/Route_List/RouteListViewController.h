//
//  RouteListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RouteListCell.h"
#import "Route.h"
#import "SpotsDetailViewController.h"

@interface RouteListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>

@property (nonatomic,retain)UITableView *MyTable;

@property (nonatomic,copy)  NSString    *RouteId;

@property (nonatomic,retain) NSMutableArray *Cellarray;

@property (nonatomic,retain) NSMutableArray *Sectionarray;


@property (nonatomic,retain) NSMutableArray *dateArray;
@property (nonatomic,retain) NSMutableArray *bigdateArray;

@property (nonatomic,retain)NSMutableArray  *DataArray;

@property (nonatomic,retain)NSMutableDictionary *dic;
@property (nonatomic,retain)MONActivityIndicatorView *MONAView;

@end
