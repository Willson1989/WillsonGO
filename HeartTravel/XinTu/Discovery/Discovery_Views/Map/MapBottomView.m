//
//  MapBottomView.m
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MapBottomView.h"

#define bottom_inset (CGRectGetHeight([[UIScreen mainScreen]bounds]) * 1/50)

@implementation MapBottomView

-(instancetype)bottomView{
    CGFloat  screenHeight = CGRectGetHeight([[UIScreen mainScreen]bounds]);
    CGFloat  screenWidth  = CGRectGetWidth([[UIScreen mainScreen]bounds]);

    self = [super initWithFrame:CGRectMake(0, screenHeight, screenWidth, screenHeight * 1/10 + 20.f)];
    
    if (self) {
        [self createSubViews];
    }
    return  self;
}

-(void)setBaseList:(BaseMapList *)baseList{
    if (_baseList != baseList) {
        [_baseList release];
        _baseList = [baseList retain];
    }
    [self.miniImageV sd_setImageWithURL:[NSURL URLWithString:baseList.photo] placeholderImage:[UIImage imageNamed:PHOLDER_IMAGE_NAME]];
    self.cnnameLabel.text = baseList.cnname;
    self.ennameLabel.text = baseList.enname;
}

-(void)createSubViews{
    CGFloat imageWidth = bottom_inset * 5;
    self.miniImageV = [[UIImageView alloc]initWithFrame:CGRectMake(bottom_inset, bottom_inset, imageWidth, imageWidth)];
    self.miniImageV.userInteractionEnabled = YES;
    self.cnnameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.miniImageV.frame.origin.x + self.miniImageV.frame.size.width + bottom_inset,
                                                                bottom_inset,
                                                                self.frame.size.width - self.miniImageV.frame.size.width - bottom_inset*2,
                                                                self.miniImageV.frame.size.height / 2)];
    self.cnnameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 2];
    self.cnnameLabel.textColor = [UIColor blackColor];
    self.cnnameLabel.textAlignment = NSTextAlignmentLeft;
    
    self.ennameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cnnameLabel.frame.origin.x,
                                                                self.cnnameLabel.frame.origin.y + self.cnnameLabel.frame.size.height,
                                                                self.cnnameLabel.frame.size.width,
                                                                self.cnnameLabel.frame.size.height)];
    
    self.ennameLabel.font = [UIFont systemFontOfSize:COMMON_FONT_SIZE - 4];
    self.ennameLabel.textAlignment = NSTextAlignmentLeft;
    self.ennameLabel.textColor = [UIColor lightGrayColor];
    
    self.bkImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.bkImageV.image = [UIImage imageNamed:@"bottomViewBKImage.png"];
    self.bkImageV.userInteractionEnabled = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self addGestureRecognizer:tap];
    
    [self addSubview:self.bkImageV];
    [self addSubview:self.cnnameLabel];
    [self addSubview:self.ennameLabel];
    [self addSubview:self.miniImageV];
    [self.miniImageV release];
    [self.ennameLabel release];
    [self.cnnameLabel release];
}

-(void)tapAction{
    [self.myDelegate gotoPointDetailPage];
}



@end
