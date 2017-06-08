//
//  CountryListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OtherCountryCell.h"
#import "MJCollectionViewCell.h"
#import "CountryListHeaderView.h"
#import "CityDetailViewController.h"
#import "MBProgressHUD.h"

#define HEADER_VIEW_ID        @"header"
#define HOT_COUNTRY_CELL_ID   @"hot_cell"
#define OTHER_COUNTRY_CELL_ID @"other_cell"

#define HEADER_HEIGHT 50
#define OTHER_COUNTRY_CELL_HEIGHT 30
#define OTHER_HEIGHT  (64+49+44)
#define HOT_CELL_WIDTH [UIScreen mainScreen].bounds.size.width



@protocol CountryListDelegate <NSObject>

-(void)gotoCountryDetailPageWithCountryID:(NSString*)countryID andCityCount:(NSInteger)cityCount;
-(void)gotoCityDetailPageWithcityID:(NSString*)cityID;

@end

@interface CountryListViewController : UIViewController

@property(retain,nonatomic) NSMutableArray * hotCountry;
@property(retain,nonatomic) NSMutableArray * otherCountry;
@property(retain,nonatomic) UICollectionView * myCollectionView;
@property(retain,nonatomic) UICollectionView * otherCollView;

@property(retain,nonatomic) UICollectionViewFlowLayout * layout;

@property (copy,nonatomic) NSString * continentName;

@property (retain,nonatomic) MBProgressHUD * HUD;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@property (assign,nonatomic) id<CountryListDelegate>myDelegate;

-(instancetype)initWithContinentName:(NSString*)continentName;



@end
