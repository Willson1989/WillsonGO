//
//  CityListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CityListCollectionView.h"
#import "CityList.h"
#import "CityDetailViewController.h"

@interface CityListViewController : UIViewController

@property (retain,nonatomic) CityListCollectionView * allCityCollectionView;
@property (retain,nonatomic) UICollectionViewFlowLayout * layout;
@property (copy,nonatomic)   NSString * myCountryID;
@property (retain,nonatomic) NSMutableArray * cityArray;
@property (assign,nonatomic) NSInteger page;
@property (assign,nonatomic) NSInteger cityCount;
@property (assign,nonatomic) BOOL  isUpLoad;
@property (assign,nonatomic) BOOL  isDownLoad;

@property (assign,nonatomic) BOOL  footerRemoved;
@property (retain,nonatomic) MONActivityIndicatorView * MONAView;




@end
