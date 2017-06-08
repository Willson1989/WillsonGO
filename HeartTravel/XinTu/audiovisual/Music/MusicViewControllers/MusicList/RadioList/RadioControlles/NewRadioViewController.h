//
//  NewRadioViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioListCell.h"
#import "PlayListViewController.h"

@protocol NewRadioViewControllerDelegate <NSObject>

-(void)pushPlayListVC:(UIViewController *)playListVC;

@end

@interface NewRadioViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MONActivityIndicatorViewDelegate>

@property (nonatomic, copy) NSString *urlId;

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isHeader;

@property (nonatomic, assign) id<NewRadioViewControllerDelegate>delegate;

-(void)initMONA;

@property (nonatomic, retain) MONActivityIndicatorView *MONAView;

@property (nonatomic, assign) BOOL isHUB;


@end
