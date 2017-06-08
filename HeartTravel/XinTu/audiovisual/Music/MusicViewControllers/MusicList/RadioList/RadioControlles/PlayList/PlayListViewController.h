//
//  PlayListViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayListCell.h"
#import "PlayMusicViewController.h"

@interface PlayListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MONActivityIndicatorViewDelegate>

@property (nonatomic, copy) NSString *albumId;

@property (nonatomic, retain) UITableView *musicListTable;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, retain) UIButton *backButton;

@property (nonatomic, retain) MONActivityIndicatorView *MONAView;

@end
