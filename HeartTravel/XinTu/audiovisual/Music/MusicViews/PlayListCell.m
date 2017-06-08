//
//  PlayListCell.m
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PlayListCell.h"

@implementation PlayListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatSubViews];
    }
    return self;
    
}

-(void)creatSubViews{
    
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(25 * WIDTHR,
                                                           10 * HEIGHTR,
                                                           (self.frame.size.width - 120) * WIDTHR,
                                                           60 * HEIGHTR)];
    self.title.textColor = [UIColor blackColor];
    self.title.numberOfLines = 2;
    self.title.lineBreakMode = NSLineBreakByCharWrapping;
    self.title.font = [UIFont boldSystemFontOfSize:16];
    
    self.playtimes = [[UILabel alloc] initWithFrame:CGRectMake(self.title.frame.origin.x,
                                                               (self.title.frame.size.height / 2) + 60,
                                                               self.title.frame.size.width / 2,
                                                               (self.title.frame.size.height / 2))];
    self.playtimes.textColor = [UIColor lightGrayColor];
    self.playtimes.font = [UIFont boldSystemFontOfSize:13];
    
    
    self.duration = [[UILabel alloc] initWithFrame:CGRectMake(self.playtimes.frame.origin.x + self.playtimes.frame.size.width + 20,
                                                              self.playtimes.frame.origin.y,
                                                              self.playtimes.frame.size.width,
                                                              self.playtimes.frame.size.height)];
    self.duration.textColor = [UIColor lightGrayColor];
    self.duration.font = [UIFont boldSystemFontOfSize:13];
    
    self.coverLarge = [[UIImageView alloc] initWithFrame:CGRectMake(self.title.frame.size.width + self.title.frame.origin.x,
                                                                    self.title.frame.origin.y + 5,
                                                                    (self.title.frame.size.height / 2) + self.playtimes.frame.origin.y,
                                                                    100
                                                                   )];
    [self.coverLarge.layer setMasksToBounds:YES];
    [self.coverLarge.layer setCornerRadius:4.5];
    
    [self addSubview:self.title];
    [self addSubview:self.playtimes];
    [self addSubview:self.duration];
    [self addSubview:self.coverLarge];
    
    [_title release];
    [_playtimes release];
    [_duration release];
    [_coverLarge release];

}

-(void)setPlayList:(MusicModel *)playList{
    
    if (_playList != playList) {
        
        [_playList release];
        _playList = [playList retain];
    }
    _title.text = playList.title;

    
    NSInteger num = [playList.duration integerValue];
    
    NSInteger min = num / 60;
    float sec = num % 60;
    _duration.text = [NSString stringWithFormat:@"时长: %ld:%.f", min, sec];
    
    _playtimes.text = [NSString stringWithFormat:@"播放次数:%@次", playList.playtimes];
    
    [_coverLarge sd_setImageWithURL:[NSURL URLWithString:playList.coverLarge] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    
}

-(void)dealloc{
    [_title release];
    [_playtimes release];
    [_duration release];
    [_coverLarge release];
    [super dealloc];
}

@end
