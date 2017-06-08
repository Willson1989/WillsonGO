//
//  RecomTravelListCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecomTravel.h"

#define TRAVEL_LIST_HEIGHT  ([[UIScreen mainScreen]bounds].size.width/4)
#define TRAVEL_CELL_INSET    12.0f

@interface RecomTravelListCell : UITableViewCell

@property (retain,nonatomic) UIImageView * travelImage;
@property (retain,nonatomic) UILabel  * travelTitle;
@property (retain,nonatomic) UILabel * routeLabel;

@property (retain,nonatomic) RecomTravel * myTravel;

@end
