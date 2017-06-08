//
//  SearchListCell.h
//  XinTu
//
//  Created by WillHelen on 15/7/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResult.h"

#define RESULT_CELL_INSET 15.0f

@interface SearchListCell : UITableViewCell

@property (retain,nonatomic) UILabel * cnnameLabel;
@property (retain,nonatomic) UILabel * ennameLabel;
@property (retain,nonatomic) UILabel * beenToLabel;
@property (retain,nonatomic) UIImageView * resultImage;
@property (retain,nonatomic) UILabel * belongLabel;
@property (retain,nonatomic) UILabel * catgoryLabel;

@property (retain,nonatomic) SearchResult * searchResult;



@end
