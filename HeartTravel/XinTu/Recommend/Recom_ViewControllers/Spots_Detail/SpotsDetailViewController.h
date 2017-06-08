//
//  SpotsDetailViewController.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
#import "Spots_DetaTVCell.h"



@interface SpotsDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,MONActivityIndicatorViewDelegate>

@property (nonatomic, retain) UIImageView *topImageView;
@property (nonatomic, retain) UITableView *tableView;


@property (nonatomic,retain)  Route       *myRout;

@property (nonatomic,retain)  UILabel     *palceName;

@property (nonatomic,copy )   NSString    *photoUrl;

@property (nonatomic,retain)  UICollectionView *CollectionV;

@property (nonatomic, retain) UICollectionViewFlowLayout *videoFlowLayout;

@property (nonatomic,retain)   NSMutableArray *myArray;

@property (nonatomic,retain) NSMutableArray *cellHeightArray;


@property (nonatomic,retain)MONActivityIndicatorView *MONAView;


@end