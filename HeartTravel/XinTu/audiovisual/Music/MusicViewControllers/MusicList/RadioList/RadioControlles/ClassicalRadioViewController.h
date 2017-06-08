//
//  ClassicalRadioViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioListCell.h"
#import "PlayListViewController.h"

@protocol ClassicalRadioViewControllerDelegate <NSObject>

-(void)pushPlayListVC:(UIViewController *)playListVC;

@end

@interface ClassicalRadioViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, MONActivityIndicatorViewDelegate>

@property (nonatomic, copy) NSString *urlId;

@property (nonatomic, retain) UITableView *classicalTableView;

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, assign) BOOL isHeader;
@property (nonatomic, assign) BOOL isFooter;


@property (nonatomic, assign) id<ClassicalRadioViewControllerDelegate>delegate;

@property (nonatomic, assign) BOOL isHUB;

-(void)initMONA;

@property (nonatomic, retain) MONActivityIndicatorView *MONAView;



@end
