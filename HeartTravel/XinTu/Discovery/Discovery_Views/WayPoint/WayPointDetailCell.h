//
//  WayPointDetailCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WayPoint.h"

#define WP_DETAIL_CELL_INSET 15.0f
#define WP_INTRO_CELL_HEIGHT 100.0f
#define WP_TITLE_CELL_HEIGHT 100.0f
#define WP_DESC_CELL_HEIGHT  100.0f

#define WP_CELL_HEIGHT 100.0f

#define TITLE_HEIGHT  (CGRectGetWidth([[UIScreen mainScreen]bounds]) / 8)
#define MAIN_FONT_SIZE   (COMMON_FONT_SIZE-5)

#define sWidth CGRectGetWidth([[UIScreen mainScreen]bounds])
#define sHeight CGRectGetHeight([[UIScreen mainScreen]bounds])

@protocol WayPointCellDelegate <NSObject>

-(void)extendCell;

@end

@interface WayPointDetailCell : UITableViewCell


@property (retain,nonatomic) UILabel * firstNameLabel;
@property (retain,nonatomic) UILabel * secondNameLabel;
@property (retain,nonatomic) UIImageView * recomStar;
@property (retain,nonatomic) UILabel * beentoLabel;


@property (retain,nonatomic) UILabel  * titleLabel;
@property (retain,nonatomic) UIButton * extendButton;
@property (retain,nonatomic) UILabel  * introLabel;

@property (retain,nonatomic) UILabel * descTitle;
@property (retain,nonatomic) UILabel * descContent;


@property (retain,nonatomic) UILabel * descContentLabel;

@property (retain,nonatomic) WayPoint * wayPoint;

@property (assign,nonatomic) id <WayPointCellDelegate> myDelegate;
@property (assign,nonatomic) NSInteger  option;

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andOption:(NSInteger)option;

@end
