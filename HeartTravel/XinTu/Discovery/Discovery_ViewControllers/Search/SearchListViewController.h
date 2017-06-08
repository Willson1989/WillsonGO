//
//  SearchListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/7/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResult.h"
#import "SearchListCell.h"


@protocol SearchListDelegate <NSObject>

@optional
-(void)resignSearchBarFirstResponder;

@required
-(void)gotoDetailPageWithType:(NSInteger)type andResultID:(NSInteger)rID;

@end

@interface SearchListViewController : UIViewController

@property (copy,nonatomic)   NSString * searchKeyWord;
@property (retain,nonatomic) UITableView * listTableView;
@property (assign,nonatomic) NSInteger page;
@property (retain,nonatomic) NSMutableArray * resultArray;

@property (assign,nonatomic) id <SearchListDelegate> myDelegate;

@property (retain,nonatomic) MONActivityIndicatorView * MONAView;

@property (assign,nonatomic) BOOL isUpLoading;

-(void)beginSearch;

@end
