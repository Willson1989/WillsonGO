//
//  SearchTempListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^tempSearchBlock)();

@protocol SearchTempDelegate <NSObject>

-(void)switchToSearchListToSearchByKeyword:(NSString*)keyword;

@end

@interface SearchTempListViewController : UIViewController

@property (copy,nonatomic) NSString * Keyword;
@property (retain,nonatomic) UITableView * tempTableView;
@property (assign,nonatomic) id <SearchTempDelegate> myDelegate;
@property (assign,nonatomic) tempSearchBlock block;

-(void)requsetData:(NSString*)keyword;

@end
