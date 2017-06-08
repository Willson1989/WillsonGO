//
//  RecomTravelMainViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommTravelViewController.h"
#import "RecomTravelDetailViewController.h"

@interface RecomTravelMainViewController : UIViewController

@property (retain,nonatomic) RecommTravelViewController * leftVC;
@property (retain,nonatomic) RecommTravelViewController * rightVC;
@property (retain,nonatomic) TopTabBar * myBar;

@property (copy,nonatomic) NSString * idType;
@property (copy,nonatomic) NSString * recommandType;
@property (copy,nonatomic) NSString * itemID;
@property (copy,nonatomic) NSString * itemType;

@end
