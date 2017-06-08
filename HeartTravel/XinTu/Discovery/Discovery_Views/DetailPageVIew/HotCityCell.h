//
//  HotCityCell.h
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotCityCell : UICollectionViewCell

@property (retain,nonatomic) UIImageView * cityImage;
@property (retain,nonatomic) UILabel     * cEnnameLabel;
@property (retain,nonatomic) UILabel     * cCnnameLabel;
@property (retain,nonatomic) NSMutableDictionary * cityDic;
@end
