//
//  GuideDetailCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PointGuide.h"
#define POINT_SIDE_INSET 15.0f
#define START_IMAGE_WIDTH 12.0f
#define GUIDE_DETAIL_FONT_SIZE 13.0f

#define GUIDE_DETAIL_IMAGE_HEIGHT ([[UIScreen mainScreen] bounds].size.width / 2.7)
static CGFloat fontSize = GUIDE_DETAIL_FONT_SIZE;

@interface GuideDetailCell : UITableViewCell

@property (retain,nonatomic) UIImageView * guidePointImage;
@property (retain,nonatomic) UILabel * pointDesc;

@property (retain,nonatomic) UILabel * pointTitle;
@property (retain,nonatomic) UIImageView * recomStar;

@property (retain,nonatomic) PointGuide * poiGuide;


@end
