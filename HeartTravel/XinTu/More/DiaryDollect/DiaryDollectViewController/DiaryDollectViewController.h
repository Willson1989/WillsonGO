//
//  DiaryDollectViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DiaryDellectModel.h"
#import "DiaryDollectViewCell.h"
#import "HotTravelViewController.h"


@interface DiaryDollectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (retain,nonatomic) UIView * topBar;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, copy) NSString *imageTitle;

@property (nonatomic, copy) NSString *nextID;

-(void)getTitle:(NSString *)title andID:(NSString *)nextID;

@end
