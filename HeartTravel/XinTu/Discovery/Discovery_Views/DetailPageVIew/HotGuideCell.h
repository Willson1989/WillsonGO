//
//  HotGuideCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HotGuideCell : UICollectionViewCell

@property (retain,nonatomic) UIImageView * guideImage;
@property (retain,nonatomic) UIImageView * avatarImage;
@property (retain,nonatomic) UIImageView * avatarBKImage;
@property (retain,nonatomic) UIView * lineView;
@property (retain,nonatomic) NSMutableDictionary * guideDic;

@property (retain,nonatomic) UILabel * userName;

@property (retain,nonatomic) UILabel * titleLabel;



@end
