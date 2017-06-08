//
//  RecommTravelViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecomTravel.h"
#import "RecomTravelListCell.h"

@protocol RecomTravelListDelegate <NSObject>

-(void)gotoTravelDetailPageWithURL:(NSString*)url;

@end

@interface RecommTravelViewController : UIViewController

@property (copy,nonatomic) NSString * itemType;
@property (copy,nonatomic) NSString * idType;
@property (copy,nonatomic) NSString * itemID;
@property (assign,nonatomic) NSInteger  page;
@property (copy,nonatomic) NSString * recommandType;

@property (retain,nonatomic) UITableView * myTableView;
@property (retain,nonatomic) NSMutableArray * travelListArray;

@property (assign,nonatomic) BOOL    isUpLoad;
@property (assign,nonatomic) BOOL    firstLoad;
@property (assign,nonatomic) id <RecomTravelListDelegate> myDelegate;


//@property (retain,nonatomic) RecomTravel * myTravel;

@end
