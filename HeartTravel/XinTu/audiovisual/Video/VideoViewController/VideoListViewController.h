//
//  VideoListViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"
#import "VideoListCell.h"
#import "VideoPlayViewController.h"



@interface VideoListViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate,MONActivityIndicatorViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) UICollectionView *videoCollectionView;

@property (nonatomic, retain) UICollectionViewFlowLayout *videoFlowLayout;

@property (nonatomic, copy) NSString *filePath;

-(void)getCacheData;

-(void)initMONA;

@property (nonatomic, retain) MONActivityIndicatorView *MONAView;



@end
