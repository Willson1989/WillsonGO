//
//  FirstListCell.m
//  XinTu
//
//  Created by Bunny on 15/6/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "FirstListCell.h"

@implementation FirstListCell

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
                                                                   self.frame.size.height - 30)];
//    [self.bigPicUrl.layer setMasksToBounds:YES];
//    [self.bigPicUrl.layer setCornerRadius:4.5];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                           self.frame.size.height - 30,
                                                           self.frame.size.width - 5,
                                                           30)];
    self.title.font = [UIFont systemFontOfSize:13];
    self.title.numberOfLines = 0;
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.lineBreakMode = NSLineBreakByCharWrapping;
    self.title.textColor = [UIColor blackColor];
    
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




-(void)dealloc{
    [_bigPicUrl release];
    [_title release];
    [_musicList release];
    [_bgView release];
    [super dealloc];
    
}

-(void)setMusicList:(MusicModel *)musicList{
    if (_musicList != musicList) {
        [_musicList release];
        _musicList = [musicList retain];
    }
    self.title.text = musicList.tname;
   
//    UIImage *cachedImage = [[SDWebImageManager sharedManager] imageWithURL:musicList.cover_path]; // 将需要缓存的图片加载进来
//    if (cachedImage) { //如果缓存中有对应链接的图片
//        
//        self.bigPicUrl.image = cachedImage;
//        
//    } else {
//        // 如果Cache没有命中，则去下载指定网络位置的图片，并且给出一个委托方法
////        [[SDWebImageManager sharedManager] downloadWithURL:musicList.cover_path delegate:self];
//    }
    
    
    [self.bigPicUrl sd_setImageWithURL:[NSURL URLWithString:musicList.cover_path] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    
}

@end
