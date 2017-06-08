//
//  HotCityCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/23.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotCityCell.h"

@implementation HotCityCell

-(void)dealloc{
    
    [self.cityImage release];
    [self.cEnnameLabel release];
    [self.cCnnameLabel release];
    [self.cityDic release];
    [super dealloc];

}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];

    }
    return self;
}

-(void)setCityDic:(NSMutableDictionary *)cityDic{
    if (_cityDic != cityDic) {
        [_cityDic release];
        _cityDic = [cityDic retain];
    }
    self.cEnnameLabel.text = [cityDic objectForKey:@"enname"];
    self.cCnnameLabel.text = [cityDic objectForKey:@"cnname"];
    NSString * hotCity_url     = [cityDic objectForKey:@"photo"];
//    NSLog(@"city_url : %@",hotCity_url);
    [self.cityImage sd_setImageWithURL:[NSURL URLWithString:hotCity_url] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
}

-(void)createSubViews{
//    NSLog(@"%s",__func__);
    self.cityImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.cityImage.userInteractionEnabled = YES;
    
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
    
    
    
    [self.contentView addSubview:self.cityImage];
    [self.contentView addSubview:self.cEnnameLabel];
    [self.contentView addSubview:self.cCnnameLabel];
    [self.cityImage release];
    [self.cEnnameLabel release];
    [self.cCnnameLabel release];

}

@end
