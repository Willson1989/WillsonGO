//
//  HotGuideListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGuideListCell.h"
#import "HotGuideListViewController.h"
#import "HotGuideDetailViewController.h"

@interface HotGuideListViewController : UIViewController

@property (copy,nonatomic) NSString * itemType;
@property (copy,nonatomic) NSString * itemID;
@property (assign,nonatomic) NSInteger page;
//@property (retain,nonatomic) HotGuideList * guideList;
@property (retain,nonatomic) NSMutableArray * guideListArray;

@property (retain,nonatomic) UITableView * myTableView;

@property (assign,nonatomic) BOOL isUpLoad;
@property (assign,nonatomic) BOOL isDownLoad;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;


@end
