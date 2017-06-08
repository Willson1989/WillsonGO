//
//  FeatureDollectViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeatureDollectViewCell.h"
#import "FeatureDollectModel.h"
#import "HotGuideDetailViewController.h"

@interface FeatureDollectViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) UITableView *tableView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) UIView *topBar;

@property (nonatomic, copy) NSString *HotGuideTitle;

@property (nonatomic, copy) NSString *guideID;

-(void)getTitle:(NSString *)title andID:(NSString *)guideID;

@end
