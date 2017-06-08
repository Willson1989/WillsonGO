//
//  RouteListCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
@interface RouteListCell : UITableViewCell

//地点
@property (nonatomic,retain) UIImageView *PlacePic;

@property (nonatomic,retain) UILabel     *PlaceText;

//景区
@property (nonatomic,retain) UIImageView *spotPic;

@property (nonatomic,retain) UILabel     *spotText;

@property (nonatomic,retain) Route       *cellRoute;
@end
