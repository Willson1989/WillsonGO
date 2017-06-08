//
//  CityDetailViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGuideCollectionView.h"
#import "HotGuideDetailViewController.h"
#import "HotGuideListViewController.h"
#import "PracticalInfoViewController.h"
#import "RecomTravelMainViewController.h"
#import "WayPointListViewController.h"
#import "MapViewController.h"

@interface CityDetailViewController : UIViewController

@property (copy,nonatomic)   NSString * cityID;
@property (retain,nonatomic) City  * myCity;
@property (retain,nonatomic) UITableView * myTableView;
@property (retain,nonatomic) TopPhotoScrollView * topScrollView;
@property (retain,nonatomic) TopNavigationView  * topNavView;

@property (retain,nonatomic) NSMutableArray * photoArray;
@property (retain,nonatomic) NSMutableDictionary * CityDetailDic;
@property (retain,nonatomic) UICollectionView * hotGuideCollectionView;
@property (retain,nonatomic) UICollectionViewFlowLayout * layout;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;


//@property (retain,nonatomic) HotGuideCell * guideCell;
//@property (retain,nonatomic) DetailPageCell * detailCell;
//@property (retain,nonatomic) CityFuncCell * cityFuncCell;

@end
