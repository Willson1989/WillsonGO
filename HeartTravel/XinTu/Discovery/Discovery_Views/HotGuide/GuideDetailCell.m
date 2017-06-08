//
//  GuideDetailCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "GuideDetailCell.h"

@implementation GuideDetailCell

-(void)dealloc{
    
    [self.guidePointImage release];
    [self.poiGuide release];
    [self.pointTitle release];
    [self.pointDesc release];
    [super dealloc];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createSubViews];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return  self;
}

-(void)setPoiGuide:(PointGuide *)poiGuide{
    if (_poiGuide != poiGuide) {
        [_poiGuide release];
        _poiGuide = [poiGuide retain];
    }
    [self.guidePointImage sd_setImageWithURL:[NSURL URLWithString:poiGuide.photo] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    if ([poiGuide.chinesename isEqualToString:@""]) {
        self.pointTitle.text = poiGuide.englishname;
    }
    else if ([poiGuide.englishname isEqualToString:@""]){
        self.pointTitle.text = poiGuide.chinesename;
    }
    else{
        self.pointTitle.text = @"";
    }
    self.pointDesc.text  = poiGuide.pointDesc;
    CGRect tempFrame = self.pointDesc.frame;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    tempFrame.size.height = [PublicFunction heightForSubView:self.pointDesc.text andWidth:screenWidth-POINT_SIDE_INSET*2 andFontOfSize:fontSize];
    self.pointDesc.frame = tempFrame;
    [self addRecomStarsWithStarCount:poiGuide.recommandstar];
}

-(void)createSubViews{
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    self.guidePointImage = [[UIImageView alloc]initWithFrame:CGRectMake(POINT_SIDE_INSET,
                                                                        0,
                                                                        screenWidth - POINT_SIDE_INSET*2,
                                                                        GUIDE_DETAIL_IMAGE_HEIGHT)];
    
    self.pointTitle = [[UILabel alloc]initWithFrame:CGRectMake(5 ,
                                                               self.guidePointImage.frame.size.height - 34,
                                                               self.guidePointImage.frame.size.width,
                                                               17)];
    self.pointTitle.font = [UIFont boldSystemFontOfSize:fontSize-1];
    self.pointTitle.textColor = [UIColor whiteColor];
    
    self.pointDesc = [[UILabel alloc]initWithFrame:CGRectMake(self.guidePointImage.frame.origin.x,
                                                              self.guidePointImage.frame.size.height + 10,
                                                              self.guidePointImage.frame.size.width,
                                                              100)];
    self.pointDesc.font = [UIFont systemFontOfSize:fontSize];
    self.pointDesc.textAlignment = NSTextAlignmentLeft;
    self.pointDesc.textColor = [PublicFunction getColorWithRed:184.0f Green:184.0f Blue:184.0f];
    self.pointDesc.numberOfLines = 0;
    self.pointDesc.backgroundColor = [UIColor whiteColor];
    
    [self.guidePointImage addSubview:self.pointTitle];
    [self.contentView addSubview:self.guidePointImage];
    [self.contentView addSubview:self.pointDesc];
    
    [self.pointTitle release];
    [self.guidePointImage release];
    [self.pointDesc release];
}


-(void)addRecomStarsWithStarCount:(NSInteger)count{
    CGFloat startY = self.pointTitle.frame.origin.y + self.pointTitle.frame.size.height;
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
        UIImageView * fullStar = [[UIImageView alloc]initWithFrame:CGRectMake(START_IMAGE_WIDTH * index + starInset * (index+1) , startY ,START_IMAGE_WIDTH , START_IMAGE_WIDTH)];
        fullStar.image = [UIImage imageNamed:@"MGuideDetail_Star1@3x.png"];
        [self.guidePointImage addSubview:fullStar];
        [fullStar release];
        i++;
        index++;
    }
    i = 0;
    while (i < halfStarCount) {
        UIImageView * halfStar = [[UIImageView alloc]initWithFrame:CGRectMake(START_IMAGE_WIDTH * index + starInset * (index+1) , startY ,START_IMAGE_WIDTH , START_IMAGE_WIDTH)];
        halfStar.image = [UIImage imageNamed:@"MGuideDetail_Star3@3x.png"];
        [self.guidePointImage addSubview:halfStar];
        i++;
        index++;
        [halfStar release];
    }
    i = 0;
    while (i < emptyStarCount) {
        UIImageView * emptyStar = [[UIImageView alloc]initWithFrame:CGRectMake(START_IMAGE_WIDTH * index + starInset * (index+1) , startY ,START_IMAGE_WIDTH , START_IMAGE_WIDTH)];
        emptyStar.image = [UIImage imageNamed:@"MGuideDetail_Star2@3x.png"];
        [self.guidePointImage addSubview:emptyStar];
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
