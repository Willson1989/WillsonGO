//
//  RadioListCell.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"


@interface RadioListCell : UITableViewCell

@property (nonatomic, retain) MusicModel *musicList;

@property (nonatomic, retain) UIImageView *albumCoverUrl290;

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UILabel *intro;

@property (nonatomic, retain) UILabel *playsCounts;

@property (nonatomic, retain) UIView *bg_view;

@end
