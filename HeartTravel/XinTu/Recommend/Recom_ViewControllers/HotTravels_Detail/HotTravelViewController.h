//
//  HotTravelViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTravels_DetailCell.h"
#import "HotTravel.h"
#import "RouteListViewController.h"
#import "Route.h"
#import "PhotoViewController.h"





@interface HotTravelViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate,goBackInDetaC, UMSocialUIDelegate, TopNavigationViewDelegate>


@property (nonatomic,retain) UITableView *detaTable;

@property (nonatomic,retain) HotTravel   *DetaHottravel;

@property (nonatomic,retain) NSMutableArray *myArray;

@property (nonatomic,retain) NSMutableArray *cellHeightArray;

@property (nonatomic,retain) NSMutableArray *SectionArraynumber;

@property (nonatomic, copy) NSString *urlId;

//headerView
@property (nonatomic,retain)NSMutableDictionary *headerDic;
@property (nonatomic,copy  )NSString            *headerPic;
@property (nonatomic,copy  )NSString            *titlePic;
@property (nonatomic,copy  )NSString            *titleText;
@property (nonatomic,retain)NSMutableArray      *SectionsArray;
//RouteID
@property (nonatomic,copy)  NSString            *RouteId;


@property (nonatomic,retain)MONActivityIndicatorView *MONAView;

@property (retain,nonatomic) TopNavigationView  * topNavView;

@property (retain,nonatomic)UIView *ButtonView;

@property (nonatomic,assign)BOOL Y_N;

@property (nonatomic,assign) BOOL appeared;

@end
