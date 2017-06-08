//
//  GuideListTitleCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGuide.h"

@interface GuideListTitleCell : UITableViewCell

@property (retain,nonatomic) UIImageView * avatarImage;
@property (retain,nonatomic) UILabel * uNameLabel;
@property (retain,nonatomic) UILabel * titleLabel;
@property (retain,nonatomic) UILabel * titleDesc;
@property (retain,nonatomic) UIImageView * leftMark;
@property (retain,nonatomic) UIImageView * rightMark;

@property (retain,nonatomic) HotGuide * hotGuide;

@end
