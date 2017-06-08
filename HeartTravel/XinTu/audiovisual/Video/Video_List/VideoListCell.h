//
//  VideoListCell.h
//  XinTu
//
//  Created by Bunny on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Video.h"

@interface VideoListCell : UICollectionViewCell

@property (nonatomic, retain) Video *videoList;


@property (nonatomic, retain) UIImageView *bigPicUrl;

@property (nonatomic, retain) UIImageView *startPic;

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UIImageView *bgView;

@end
