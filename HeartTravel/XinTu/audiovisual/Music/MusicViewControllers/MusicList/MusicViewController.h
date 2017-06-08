//
//  MusicViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"
#import "FirstListCell.h"
#import "RadioListRootViewController.h"


@protocol  MusicViewControllerDelegate <NSObject>

-(void)pushSubVCmethod:(UIViewController *)radioVC;

@end


@interface MusicViewController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, MONActivityIndicatorViewDelegate>


@property (nonatomic, retain) NSMutableArray *dataArray;

@property (nonatomic, retain) NSMutableArray *urlArray;

@property (nonatomic, retain) NSMutableArray *titleArray;

@property (nonatomic, retain) UICollectionView *musicCollectionView;

@property (nonatomic, retain) UICollectionViewFlowLayout *musicFlowLayout;

@property (nonatomic, copy) NSString *filePath;

-(void)getCacheData;

-(void)initMONA;

@property (nonatomic, retain) MONActivityIndicatorView *MONAView;

@property (nonatomic, assign) id<MusicViewControllerDelegate>delegate;

@end
