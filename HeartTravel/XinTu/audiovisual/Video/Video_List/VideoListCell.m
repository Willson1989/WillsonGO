//
//  VideoListCell.m
//  XinTu
//
//  Created by Bunny on 15/6/22.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "VideoListCell.h"

@implementation VideoListCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    
    self.bigPicUrl = [[UIImageView alloc] initWithFrame:CGRectMake(5,
                                                                   0,
                                                                   self.frame.size.width,
                                                                   self.frame.size.height - 50)];
//    [self.bigPicUrl.layer setMasksToBounds:YES];
//    [self.bigPicUrl.layer setCornerRadius:4.5];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                           self.frame.size.height - 50,
                                                           self.frame.size.width - 5,
                                                           50)];
    self.title.font = [UIFont systemFontOfSize:13];
    self.title.numberOfLines = 2;
    self.title.lineBreakMode = NSLineBreakByCharWrapping;
    self.title.textColor = [UIColor blackColor];
    self.title.textAlignment = NSTextAlignmentCenter;
    
    self.bgView = [[UIImageView alloc] initWithFrame:CGRectMake(-5,
                                                                0,
                                                                self.frame.size.width + 10,
                                                                self.frame.size.height)];
//    [self.bgView.layer setMasksToBounds:YES];
//    [self.bgView.layer setCornerRadius:4.5];
    self.bgView.image = [UIImage imageNamed:@"lastMinute_Bottom@2x.png"];
    self.bgView.backgroundColor = [UIColor clearColor];
    
    [self.bgView addSubview:self.bigPicUrl];
    [self.bgView addSubview:self.title];
    [self addSubview:self.bgView];
    
    [_bigPicUrl release];
    [_title release];
    [_bgView release];
    
}

-(void)setVideoList:(Video *)videoList{
    if (_videoList != videoList) {
        [_videoList release];
        _videoList = [videoList retain];
    }
    self.title.text = videoList.title;
    
    [self.bigPicUrl sd_setImageWithURL:[NSURL URLWithString:videoList.bigPicUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
}


-(void)dealloc{
    [_bigPicUrl release];
    [_title release];
    [_videoList release];
    [_bgView release];
    [super dealloc];
    
}

@end
