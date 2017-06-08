//
//  Spots_DetaTVCell.h
//  XinTu
//
//  Created by 菊次郎 on 15-6-28.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Route.h"
@interface Spots_DetaTVCell : UITableViewCell

@property (nonatomic, retain) UIImageView *bigPicUrl;

@property (nonatomic, retain) UIImageView *UserPic;

@property (nonatomic, retain) UILabel *TexT;
@property (nonatomic, retain) UILabel *nameOne;
@property (nonatomic, retain) UILabel *nameTwo;

@property(nonatomic,retain) Route *myRoute;
@property(nonatomic,copy)NSString *strii;


@end
