//
//  HotRadioViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioListCell.h"
#import "PlayListViewController.h"

@protocol HotRadioViewControllerDelegate <NSObject>

-(void)pushPlayListVC:(UIViewController *)playListVC;

@end

@interface HotRadioViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MONActivityIndicatorViewDelegate>

@property (nonatomic, copy) NSString *urlId;

@property (nonatomic, retain) UITableView *hotTableView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isHeader;

@property (nonatomic, assign) id<HotRadioViewControllerDelegate>delegate;

-(void)initMONA;

@property (nonatomic, retain) MONActivityIndicatorView *MONAView;

@property (nonatomic, assign) BOOL isHUB;

@end
