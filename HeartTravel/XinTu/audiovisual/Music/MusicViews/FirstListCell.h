//
//  FirstListCell.h
//  XinTu
//
//  Created by Bunny on 15/6/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MusicModel.h"

@interface FirstListCell : UICollectionViewCell


@property (nonatomic, retain) MusicModel *musicList;

@property (nonatomic, retain) UIImageView *bigPicUrl;

@property (nonatomic, retain) UIImageView *startPic;

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UIImageView *bgView;

@end
