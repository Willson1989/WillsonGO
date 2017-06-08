//
//  WayPointListCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WayPointListCell.h"

@implementation WayPointListCell

-(void)dealloc{
    
    [self.wayNameLabel release];
    [self.wayPoiImageV release];
    [self.wayPointList release];
    [self.recomStar release];
    [self.beentoLabel release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
//        self.backgroundColor = [PublicFunction getColorWithRed:211.0 Green:211.0 Blue:211.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
//        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

-(void)setWayPointList:(WayPointList *)wayPointList{
    if (_wayPointList != wayPointList) {
        [_wayPointList release];
        _wayPointList = [wayPointList retain];
    }
    
    [self.wayPoiImageV sd_setImageWithURL:[NSURL URLWithString:wayPointList.photo]
                         placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    self.wayNameLabel.text = wayPointList.chinesename;
    self.beentoLabel.text = wayPointList.beenstr;
    [self addRecomStarsWithStarCount:wayPointList.gradescores];
    
}

-(void)createSubViews{
    CGFloat screenWidth = CGRectGetWidth([[UIScreen mainScreen]bounds]);
    self.wayPoiImageV = [[UIImageView alloc] initWithFrame:CGRectMake(WAYPOI_CELL_INSET,
                                                                      WAYPOI_CELL_INSET,
                                                                      WAYPOI_LIST_HEIGHT - WAYPOI_CELL_INSET*2,
                                                                      WAYPOI_LIST_HEIGHT - WAYPOI_CELL_INSET*2)];
    
    self.wayNameLabel = [[UILabel alloc]initWithFrame:
                                        CGRectMake(self.wayPoiImageV.frame.origin.x + self.wayPoiImageV.frame.size.width+WAYPOI_CELL_INSET,
                                                   WAYPOI_CELL_INSET,
                                                   screenWidth - self.wayPoiImageV.frame.size.width - WAYPOI_CELL_INSET*3,
                                                   self.wayPoiImageV.frame.size.height * 1/5)];
    self.wayNameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE -3];
    self.wayNameLabel.textAlignment = NSTextAlignmentLeft;
    self.wayNameLabel.textColor = [UIColor blackColor];
    
    self.beentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.wayNameLabel.frame.origin.x,
                                                                self.wayPoiImageV.frame.size.height * 4/5 + WAYPOI_CELL_INSET,
                                                                self.wayNameLabel.frame.size.width,
                                                                self.wayNameLabel.frame.size.height)];
    self.beentoLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 6];
    self.beentoLabel.textColor = [UIColor grayColor];
    self.beentoLabel.textAlignment = NSTextAlignmentLeft;
    
    self.recomStar = [[UIImageView alloc]initWithFrame:CGRectMake(self.wayNameLabel.frame.origin.x,
                                                                  self.wayPoiImageV.frame.size.height * 4/5 + WAYPOI_CELL_INSET,
                                                                  self.wayNameLabel.frame.size.width,
                                                                  self.wayNameLabel.frame.size.height)];
    
    [self.contentView addSubview:self.recomStar];
    [self.contentView addSubview:self.wayNameLabel];
    [self.contentView addSubview:self.wayPoiImageV];
    [self.contentView addSubview:self.beentoLabel];
    
    
    [self.recomStar release];
    [self.beentoLabel release];
    [self.wayNameLabel release];
    [self.wayPoiImageV release];
    
}

-(void)addRecomStarsWithStarCount:(NSInteger)count{
    CGFloat startY = WAYPOI_CELL_INSET + self.wayPoiImageV.frame.size.height * 4/5;
    NSInteger fullStarCount  = count/2;
    NSInteger halfStarCount  = 0;
    NSInteger emptyStarCount = 5;
    if (count % 2 != 0) {
        halfStarCount = 1;
    }
    emptyStarCount = emptyStarCount - fullStarCount - halfStarCount;
    NSInteger starInset = 3;
    NSInteger i = 0;
    NSInteger index = 0;
    while (i < fullStarCount) {
        UIImageView * fullStar = [[UIImageView alloc]initWithFrame:CGRectMake(WAY_POINT_STAR_WIDTH * index + starInset * (index+1) , startY ,WAY_POINT_STAR_WIDTH , WAY_POINT_STAR_WIDTH)];
        fullStar.image = [UIImage imageNamed:@"MGuideDetail_Star1@3x.png"];
        [self.recomStar addSubview:fullStar];
        [fullStar release];
        i++;
        index++;
    }
    i = 0;
    while (i < halfStarCount) {
        UIImageView * halfStar = [[UIImageView alloc]initWithFrame:CGRectMake(WAY_POINT_STAR_WIDTH * index + starInset * (index+1) , startY ,WAY_POINT_STAR_WIDTH , WAY_POINT_STAR_WIDTH)];
        halfStar.image = [UIImage imageNamed:@"MGuideDetail_Star3@3x.png"];
        [self.recomStar addSubview:halfStar];
        i++;
        index++;
        [halfStar release];
    }
    i = 0;
    while (i < emptyStarCount) {
        UIImageView * emptyStar = [[UIImageView alloc]initWithFrame:CGRectMake(WAY_POINT_STAR_WIDTH * index + starInset * (index+1) , startY ,WAY_POINT_STAR_WIDTH , WAY_POINT_STAR_WIDTH)];
        emptyStar.image = [UIImage imageNamed:@"MGuideDetail_Star2@3x.png"];
        [self.recomStar addSubview:emptyStar];
        i++;
        index++;
        [emptyStar release];
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
