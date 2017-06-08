//
//  HotGuideCell.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuideCell.h"

@implementation HotGuideCell

-(void)dealloc{
    
    [self.guideImage release];
    [self.avatarImage release];
    [self.avatarBKImage release];
    [self.lineView release];
    [self.guideDic release];
    [self.userName release];
    [self.titleLabel release];
    [super dealloc];
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createSubViews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)setGuideDic:(NSMutableDictionary *)guideDic{
    if (_guideDic != guideDic) {
        [_guideDic release];
        _guideDic = [guideDic retain];
    }
    self.titleLabel.text = [guideDic objectForKey:@"title"];
    self.userName.text   = [guideDic objectForKey:@"username"];
    NSString * hotGuide_url   = [guideDic objectForKey:@"photo"];
    NSString * avatar_url     = [guideDic objectForKey:@"avatar"];
    [self.titleLabel verticalUpAlignmentWithText:self.titleLabel.text maxHeight:self.titleLabel.frame.size.height];
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:avatar_url] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    [self.guideImage sd_setImageWithURL:[NSURL URLWithString:hotGuide_url] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
}

-(void)createSubViews{
    self.guideImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 1.8/3)];
    
    self.avatarImage = [[UIImageView alloc]initWithFrame:
                        CGRectMake(self.guideImage.frame.origin.x + 5,
                                   self.guideImage.frame.size.height - USER_IMAGE_WIDTH/2,
                                   USER_IMAGE_WIDTH,
                                   USER_IMAGE_WIDTH)];
    CALayer * layer = self.avatarImage.layer;
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:15.0];
    
    //发布者头像背景图片(实现余白)
    self.avatarBKImage = [[UIImageView alloc]initWithFrame:self.guideImage.frame];
    CGRect newFrame = self.avatarBKImage.frame;
    newFrame.size.width = USER_IMAGE_WIDTH + 2;
    newFrame.size.height = USER_IMAGE_WIDTH + 2;
    self.avatarBKImage.frame = newFrame;
    self.avatarBKImage.center = self.avatarImage.center;
    self.avatarBKImage.backgroundColor = [UIColor whiteColor];
    self.avatarBKImage.layer.cornerRadius = 15;
    
    self.userName = [[UILabel alloc]initWithFrame:CGRectMake(self.avatarBKImage.frame.origin.x + self.avatarBKImage.frame.size.width,
                                                             self.guideImage.frame.origin.y + self.guideImage.frame.size.height,
                                                             self.guideImage.frame.size.width - self.avatarBKImage.frame.size.width,
                                                             USER_IMAGE_WIDTH/2 + 5)];
    self.userName.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE-6];
    
    self.lineView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                            self.userName.frame.origin.y + self.userName.frame.size.height + 1,
                                                            self.frame.size.width,
                                                            1)];
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,
                                                               self.lineView.frame.origin.y + 2,
                                                               self.frame.size.width,
                                                               40)];
    self.titleLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE-6];
    
    [self.contentView addSubview:self.userName];
    [self.contentView addSubview:self.guideImage];
    [self.contentView addSubview:self.avatarBKImage];
    [self.contentView addSubview:self.avatarImage];
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.titleLabel];
    
    [self.lineView release];
    [self.guideImage release];
    [self.avatarBKImage release];
    [self.avatarImage release];
    [self.userName release];
    [self.titleLabel release];
}

@end
