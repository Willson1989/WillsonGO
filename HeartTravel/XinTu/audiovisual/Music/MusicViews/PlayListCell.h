//
//  PlayListCell.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface PlayListCell : UITableViewCell

@property (nonatomic, retain) MusicModel *playList;

@property (nonatomic, retain) UILabel *title; //音频题目

@property (nonatomic, retain) UILabel *playtimes; // 音频播放次数

@property (nonatomic, retain) UILabel *duration; // 音频时长(秒)

@property (nonatomic, retain) UIImageView *coverLarge; // 音频截图

@property (nonatomic, retain) UIButton *playButton; //播放按钮

@end
