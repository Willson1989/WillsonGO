//
//  HotSearchViewController.h
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>

#define HOT_ARR   @"hot_array";

@protocol HotSearchDelegate <NSObject>

-(void)clickedToSearchListpageFromHotSearchWithKeyWord:(NSString*)keyword;
-(void)changeContentOfSearchBar:(NSString *)content;
-(void)resignSearchBarFirstResponder;

@end

@interface HotSearchViewController : UIViewController

@property (retain,nonatomic)  UITableView * hotTableView;
@property (retain,nonatomic)  NSMutableArray * hotArray;
@property (retain,nonatomic)  NSMutableArray * historyArray;
@property (assign,nonatomic)  NSIndexPath * indexPathSection1;
@property (assign,nonatomic) id <HotSearchDelegate> myDelegate;

-(void)reloadHotTableView;

@end
