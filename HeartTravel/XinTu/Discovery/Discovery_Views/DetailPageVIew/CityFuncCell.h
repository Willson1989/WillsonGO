//
//  CityFuncCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

//-----城市详情 功能cell参数 (景点,美食,活动)
#define CITY_FUNC_BUTTON_WIDTH 60.0f
#define CITY_FUNC_LABEL_WIDTH  60.0f
#define CITY_FUNC_LABEL_HEIGHT 20.0f
#define SPACE_BETWEEN_BUTTONS  (([[UIScreen mainScreen]bounds].size.width - 60.0 * 3)/4.0f)
#define BUTTON_UP_INSET        20.0f
#define CITY_FUNC_CELL_HEIGHT  100.0f
#define BUTTON_CORNER_RADIUS   10.0f


@protocol CityFuncCellDelegate <NSObject>

-(void)gotoWayPointListPageWithCategoryID:(NSInteger)ID;

@end

@interface CityFuncCell : UITableViewCell

@property (retain,nonatomic) UIButton * foodButton;
@property (retain,nonatomic) UILabel  * foodLabel;

@property (retain,nonatomic) UIButton * viewSightButton;
@property (retain,nonatomic) UILabel  * viewSightLabel;

@property (retain,nonatomic) UIButton * activityButton;
@property (retain,nonatomic) UILabel  * activityLabel;

@property (assign,nonatomic) id <CityFuncCellDelegate> myDelegate;


@end
