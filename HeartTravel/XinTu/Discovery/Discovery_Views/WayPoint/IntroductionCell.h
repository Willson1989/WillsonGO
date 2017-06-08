//
//  IntroductionCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WP_DETAIL_CELL_INSET 15.0f
#define WP_INTRO_CELL_HEIGHT 100.0f

@protocol IntroductionCellDelegate <NSObject>

-(void)extendCell;

@end

@interface IntroductionCell : UITableViewCell

@property (retain,nonatomic) UILabel  * titleLabel;
@property (retain,nonatomic) UIButton * extendButton;
@property (retain,nonatomic) UILabel  * introLabel;

@property (assign,nonatomic) id <IntroductionCellDelegate> myDelegate;


@end
