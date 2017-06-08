//
//  HotTravelCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTravel.h"
#import "UIImageView+WebCache.h"
@interface HotTravelCell : UITableViewCell

@property (nonatomic,retain)UIImageView *cover;

@property (nonatomic,retain)UILabel     *title;

@property (nonatomic,retain)UILabel     *date;

@property (nonatomic,retain)UILabel     *days;
//浏览次数
@property (nonatomic,retain)UILabel     *browse;

@property (nonatomic,retain)UILabel     *place;

@property (nonatomic,retain)UILabel     *UserName;

@property (nonatomic,retain)UIImageView *Userpic;

@property (nonatomic,retain)UILabel     *UserBy;

@property (nonatomic,retain)UIImageView *icon;

@property (nonatomic,retain)HotTravel    *myHotTravel;


@end
