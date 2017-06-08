//
//  HotTravelListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTravelCell.h"
#import "HotTravel.h"
#import "mySctollview.h"
#import "HotTravelViewController.h"

@interface HotTravelListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,MONActivityIndicatorViewDelegate>

@property(nonatomic,retain)UITableView    *Mytable;

@property(nonatomic,retain)NSMutableArray *myArray;

@property(nonatomic,retain)HotTravel      *myHotTravel;

@property(nonatomic,retain)NSMutableArray *titleArray;

@property(nonatomic,assign)NSInteger  page;

@property(nonatomic,retain)MONActivityIndicatorView *MONAView;


@end
