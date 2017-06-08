//
//  CityListCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityListCell.h"



@implementation CityListCell

-(void)dealloc{
    
    [self.cCnnameLabel release];
    [self.cEnnameLabel release];
    [self.descLabel release];
    [self.beentoLabel release];
    [self.cityImage release];
    [self.HCCell release];
    [self.clist release];
    [self.BKImageView release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        
    }
    return self;
}

-(void)setClist:(CityList *)clist{
    if (_clist != clist) {
        [_clist release];
        _clist = [clist retain];
    }

    self.cCnnameLabel.text = clist.catename;
    self.cEnnameLabel.text = clist.catename_en;
    self.descLabel.text = clist.representative;
    [self.descLabel verticalUpAlignmentWithText:self.descLabel.text maxHeight:40];
    self.beentoLabel.text = clist.beenstr;
    NSString * City_url = clist.photo;
    [self.cityImage sd_setImageWithURL:[NSURL URLWithString:City_url] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];

}

-(void)createSubViews{
    self.beentoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.frame.size.width, 30)];
    self.beentoLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 7];
    self.beentoLabel.textColor = [UIColor lightGrayColor];
    self.cityImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, (MYWIDTH - LINE_SPACE * 2) / 2 - 10, 100)];
    self.cCnnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                 self.cityImage.frame.size.height/2 - 20,
                                                                 self.bounds.size.width,
                                                                 20)];
    self.cCnnameLabel.textColor = [UIColor whiteColor];
    self.cCnnameLabel.textAlignment = NSTextAlignmentCenter;
    self.cCnnameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE-4];
    
    self.cEnnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                                 self.cityImage.frame.size.height/2,
                                                                 self.bounds.size.width,
                                                                 20)];
    self.cEnnameLabel.textColor = [UIColor whiteColor];
    self.cEnnameLabel.textAlignment = NSTextAlignmentCenter;
    self.cEnnameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE-6];
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.cityImage.frame.size.height + self.beentoLabel.frame.size.height, self.frame.size.width, 40)];
    self.descLabel.textColor = [UIColor blackColor];
    self.descLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 6];
    self.descLabel.numberOfLines = 2;
    
    self.BKImageView = [[UIImageView alloc]init];
    self.BKImageView.frame = CGRectMake(-5, 0, self.frame.size.width + 10, self.frame.size.height);
    UIImage * bkimage = [UIImage imageNamed:@"lastMinute_Bottom@2x.png"];
    bkimage = [bkimage resizableImageWithCapInsets:UIEdgeInsetsMake(20, 20, 20, 20) resizingMode:UIImageResizingModeTile];
    self.BKImageView.image = bkimage;
    self.userInteractionEnabled = YES;
    self.BKImageView.userInteractionEnabled = YES;
    [self.cityImage addSubview:self.cEnnameLabel];
    [self.cityImage addSubview:self.cCnnameLabel];
    [self.contentView addSubview:self.BKImageView];
    [self.contentView addSubview:self.beentoLabel];
    [self.contentView addSubview:self.descLabel];
    [self.contentView addSubview:self.cityImage];
    [self.beentoLabel release];
    [self.HCCell release];
    [self.descLabel release];
    
}

@end
