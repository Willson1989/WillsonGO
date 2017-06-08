//
//  PlayMusicViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioStreamer.h"

@interface PlayMusicViewController : UIViewController

+(instancetype)shareDataHandle;

@property (nonatomic, retain) NSMutableArray *urlArray; //音频链接数组

@property (nonatomic, retain) NSMutableArray *nameArray; //音频名字数组

@property (nonatomic, retain) NSMutableArray *imageArray; //音频图片链接

@property (nonatomic, copy) NSString *coverLarge; // 音频截图

@property (nonatomic, copy) NSString *playUrl64; // 音频链接

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *duration; // 音频时长

@property (nonatomic, retain) UIImageView *bigImage; //背景大图

@property (nonatomic, retain) UIView *topBar; // 顶部自定义导航栏

@property (nonatomic, assign) NSInteger index;//数组下标

@property (nonatomic, retain) AudioStreamer *streamer;

@property (nonatomic, retain) NSTimer *playTimer;//定时器

@property (nonatomic, retain) UISlider *progressSlider;//进度条

@property (nonatomic, retain) UILabel *timeLabel;

@property (nonatomic, retain) UILabel *totalTime;

@property (nonatomic, retain) UILabel *titleLabel;

@property (nonatomic, retain) UIButton *playButton;

@property (nonatomic, retain) UIButton *backButton;

@property (nonatomic, retain) UIImageView *roundView;


@end
