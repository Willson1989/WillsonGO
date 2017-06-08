//
//  RadioListCell.m
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RadioListCell.h"

@implementation RadioListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self creatSubViews];
    }
    return self;
}

-(void)creatSubViews{
    
    self.albumCoverUrl290 = [[UIImageView alloc] initWithFrame:CGRectMake(10,
                                                                          10,
                                                                          120,
                                                                          100)];
    [self.albumCoverUrl290.layer setMasksToBounds:YES];
    [self.albumCoverUrl290.layer setCornerRadius:4.5];
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(self.albumCoverUrl290.frame.origin.x + self.albumCoverUrl290.frame.size.width + 5,
                                                           self.albumCoverUrl290.frame.origin.y,
                                                           MYWIDTH - self.albumCoverUrl290.frame.origin.x - self.albumCoverUrl290.frame.size.width - 10,
                                                           30)];
    self.title.font = [UIFont boldSystemFontOfSize:16];
    self.title.numberOfLines = 0;
    self.title.textColor = [UIColor blackColor];
    
    self.intro = [[UILabel alloc] init];
    self.intro.numberOfLines = 4;
    self.intro.lineBreakMode = NSLineBreakByCharWrapping;
    self.intro.font = [UIFont boldSystemFontOfSize:13];
    self.intro.textColor = [UIColor lightGrayColor];
    _intro.frame = CGRectMake(self.title.frame.origin.x,
                              self.title.frame.size.height + 2,
                              self.title.frame.size.width - 10,
                              self.title.frame.size.height * 2);
    
    self.playsCounts = [[UILabel alloc] initWithFrame:CGRectMake(self.title.frame.origin.x,
                                                                 self.albumCoverUrl290.frame.origin.y + self.albumCoverUrl290.frame.size.height - 15,
                                                                 self.title.frame.size.width,
                                                                 10)];
    self.playsCounts.textColor = [UIColor lightGrayColor];
    self.playsCounts.font = [UIFont boldSystemFontOfSize:12];
    
    self.bg_view = [[UIView alloc] init];
    self.bg_view.frame = CGRectMake(0,
                                    0,
                                    MYWIDTH,
                                    115);
    self.bg_view.backgroundColor = [UIColor whiteColor];
    self.bg_view.alpha = 1;
    //    [self.bg_view.layer setMasksToBounds:YES];
    //    [self.bg_view.layer setCornerRadius:4.5];
    
    [self.bg_view addSubview:self.title];
    [self.bg_view addSubview:self.albumCoverUrl290];
    [self.bg_view addSubview:self.playsCounts];
    [self.bg_view addSubview:self.intro];
    [self addSubview:self.bg_view];
    
    [_title release];
    [_intro release];
    [_albumCoverUrl290 release];
    [_playsCounts release];
    [_bg_view release];
}
-(void)setMusicList:(MusicModel *)musicList{
    
    if (_musicList != musicList) {
        
        [_musicList release];
        _musicList = [_musicList retain];
    }
    _title.text = musicList.title;
    
    NSInteger counts = [musicList.playsCounts integerValue];
    
    if (counts >= 10000) {
        
        _playsCounts.text = [NSString stringWithFormat:@"播放次数:%.1f万次", counts / 10000.0];
    }else if (counts < 10000) {
        
        _playsCounts.text = [NSString stringWithFormat:@"播放次数:%ld次", counts];
    }
    
//    CGFloat height_title = [PublicFunction heightForSubView:musicList.title andWidth:_title.frame.size.width andFontOfSize:16];
//    
//    CGRect frame_title = _title.frame;
//    frame_title.size.height = height_title;
//    _title.frame = frame_title;
    
    _intro.text = musicList.intro;
    
//    CGFloat height_intro = [PublicFunction heightForSubView:musicList.intro andWidth:_intro.frame.size.width andFontOfSize:13];
//    
////    
////    CGRect frame_intro = _intro.frame;
////    frame_intro.size.height = height_intro;
////    _intro.frame = frame_intro;
    
    [_albumCoverUrl290 sd_setImageWithURL:[NSURL URLWithString:musicList.albumCoverUrl290] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
}
-(void)dealloc{
    
    [_title release];
    [_intro release];
    [_albumCoverUrl290 release];
    [_playsCounts release];
    [_bg_view release];
    [super dealloc];
}




@end
