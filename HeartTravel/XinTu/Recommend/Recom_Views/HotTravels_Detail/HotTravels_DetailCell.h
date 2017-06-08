//
//  HotTravels_DetailCell.h
//  XinTu
//
//  Created by 菊次郎 on 15-6-22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotTravel.h"


@interface HotTravels_DetailCell : UITableViewCell



@property (nonatomic,retain)UILabel *day;

@property (nonatomic,retain)UILabel *date;

@property (nonatomic,retain)UIImageView *photo;

@property (nonatomic,retain)UILabel *Text;

@property (nonatomic,retain)UILabel *local_time;
//国家  省份
@property (nonatomic,retain)UILabel *country;
@property (nonatomic,retain)UILabel *province;

@property (nonatomic,retain)HotTravel *myHotTravel;

//小图标
@property (nonatomic,retain)UIImageView *ioc;

@property (nonatomic,assign)CGFloat CellHeight;
@end
