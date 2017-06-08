//
//  WayPointListCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayPointList.h"

#define WAYPOI_LIST_HEIGHT  ([[UIScreen mainScreen]bounds].size.width/4)
#define WAYPOI_CELL_INSET    12.0f
#define WAY_POINT_STAR_WIDTH 12.0f

@interface WayPointListCell : UITableViewCell

@property (retain,nonatomic) WayPointList * wayPointList;
@property (retain,nonatomic) UIImageView  * wayPoiImageV;
@property (retain,nonatomic) UILabel      * wayNameLabel;
@property (retain,nonatomic) UIImageView  * recomStar;
@property (retain,nonatomic) UILabel      * beentoLabel;

@end
