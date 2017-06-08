//
//  CountryDetailViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PracticalInfoViewController.h"
#import "CityListViewController.h"
#import "CityDetailViewController.h"
#import "HotGuideCollectionView.h"
#import "CityDetailViewController.h"
#import "HotGuideListViewController.h"
#import "HotGuideDetailViewController.h"
#import "RecomTravelMainViewController.h"
#import "MapViewController.h"

@interface CountryDetailViewController : UIViewController

@property (copy,nonatomic)   NSString * countryID;
@property (copy,nonatomic)   NSString * location_lat;
@property (retain,nonatomic) Country  * myCountry;
@property (retain,nonatomic) UITableView * myTableView;
@property (retain,nonatomic) TopPhotoScrollView * topScrollView;
@property (retain,nonatomic) TopNavigationView  * topNavView;

@property (retain,nonatomic) NSMutableArray * photoArray;
@property (retain,nonatomic) NSMutableDictionary * CountryDetailDic;

@property (retain,nonatomic) UICollectionView * hotCityCollectionView;
@property (retain,nonatomic) HotGuideCollectionView * hotGuideCollectionView;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@property (assign,nonatomic) NSInteger  cityCount;


@end
