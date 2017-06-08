//
//  HotGuideListCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotGuideList.h"

@interface HotGuideListCell : UITableViewCell

@property (retain,nonatomic) UIImageView * gImageView;
@property (retain,nonatomic) UIImageView * avatarImageView;
@property (retain,nonatomic) UILabel * uNameLabel;
@property (retain,nonatomic) UILabel *gTitleLabel;
@property (retain,nonatomic) UIView  * avatarBKView;

@property (copy,nonatomic) NSString * itemID;
@property (copy,nonatomic) NSString * itemType;

@property (retain,nonatomic) HotGuideList *guideList;

@end
