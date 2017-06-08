//
//  MapViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import "CustomPointAnnotation.h"
#import "MapBottomView.h"
#import "CityDetailViewController.h"
#import "WayPointDetailViewController.h"

@interface MapViewController : UIViewController

@property (assign,nonatomic) CGPoint coordinate;
@property (retain,nonatomic) MAMapView * mapView;


@property (assign,nonatomic) VCEnum fromWhichVC;
@property (copy,nonatomic) NSString *  itemID;
@property (copy,nonatomic) NSString * urlStr;
@property (retain,nonatomic) NSMutableArray * itemArray;


@property (retain,nonatomic) TopNavigationView * topNavView;
@property (retain,nonatomic) MapBottomView * bottomView;


@property (assign,nonatomic) BOOL  isFirstLoad;


@property (retain,nonatomic) MONActivityIndicatorView * MONAView;




@end
