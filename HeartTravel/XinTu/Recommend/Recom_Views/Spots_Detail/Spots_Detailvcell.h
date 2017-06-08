//
//  Spots_Detailvcell.h
//  XinTu
//
//  Created by 菊次郎 on 15-6-25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
@interface Spots_Detailvcell : UICollectionViewCell

@property (nonatomic, retain) UIImageView *bigPicUrl;

@property (nonatomic, retain) UIImageView *startPic;

@property (nonatomic, retain) UILabel *title;

@property (nonatomic, retain) UIImageView *bgView;

@property  (nonatomic,retain) Route       *myRoute;

@end
