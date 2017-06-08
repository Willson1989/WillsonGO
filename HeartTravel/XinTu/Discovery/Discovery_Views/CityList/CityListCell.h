//
//  CityListCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotCityCell.h"
#import "CityList.h"

#define CITY_LIST_CELL_WIDTH (([UIScreen mainScreen].bounds.size.width - 15.0f * 2.0f - 10.0f) / 2.0f) 
#define CITY_LIST_CELL_HEIGHT 170.0f

@interface CityListCell : UICollectionViewCell

@property (retain,nonatomic) UILabel * cCnnameLabel;
@property (retain,nonatomic) UILabel * cEnnameLabel;
@property (retain,nonatomic) UILabel * descLabel;
@property (retain,nonatomic) UILabel * beentoLabel;
@property (retain,nonatomic) UIImageView * cityImage;
@property (retain,nonatomic) HotCityCell * HCCell;
@property (retain,nonatomic) CityList * clist;
@property (retain,nonatomic) UIImageView * BKImageView;




@end
