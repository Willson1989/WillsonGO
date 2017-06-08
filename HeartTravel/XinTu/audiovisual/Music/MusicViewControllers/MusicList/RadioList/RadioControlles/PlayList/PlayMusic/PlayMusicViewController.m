//
//  PlayMusicViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PlayMusicViewController.h"

@implementation PlayMusicViewController

#pragma mark  将播放器对象设置成单例类
+(instancetype)shareDataHandle{
    static PlayMusicViewController *playVC = nil;
    static dispatch_once_t myPredicate;
    dispatch_once(&myPredicate, ^{
        
        playVC = [[PlayMusicViewController alloc] init];
    });
    return playVC;
    
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [PublicFunction getColorWithRed:206.0 Green:206.0 Blue:206.0];;

    self.title = self.name;
    
    //创建第三方类的对象
    self.url = self.playUrl64;
    
    self.streamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:_url]];

    
    [self creatSubViews];

    self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.backButton.frame = CGRectMake(0, 20, 20, 20);
    
    [self.backButton addTarget:self action:@selector(leftButtonAction) forControlEvents:UIControlEventTouchUpInside];
    UIImage * image = [UIImage imageNamed:@"auth_back_button_image.png"];
    image =  [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [self.backButton setBackgroundImage:image forState:UIControlStateNormal];
    self.backButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentLeft; //button居左
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:self.backButton] autorelease];
    
    //监听音乐播放状态 -- 利用通知中心捕捉播放状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playStateAction) name: ASStatusChangedNotification object:nil];
}

#pragma mark 监听播放状态
-(void)playStateAction{
    if (self.streamer.isPlaying) {//播放
        
        NSLog(@"正在播放");
        
    }else if (self.streamer.isPaused){//暂停
        
        NSLog(@"暂停");
        
    }else if (self.streamer.isWaiting){//加载
        
        NSLog(@"正在加载");
        
    }else if (self.streamer.isIdle){//闲置
        
        NSLog(@"闲置停止");
        
    }
}

-(void)viewWillAppear:(BOOL)animated{
    
//    self.navigationController.navigationBar.hidden = YES;
    
 
    if ((self.url != self.playUrl64)) {
        
        
        //先停止正在播放的音乐，然后重新创建新的streamer的对象，加载新的音乐链接
        [self stopMusic];
        //开启定时器
        self.playTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
        //开启音乐
        self.streamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:self.playUrl64]];
        
        [self.playButton setImage:[UIImage imageNamed:@"play@2x.png"] forState:UIControlStateNormal];
        
        [self.bigImage sd_setImageWithURL:[NSURL URLWithString:self.coverLarge] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
        
        [self.roundView sd_setImageWithURL:[NSURL URLWithString:self.coverLarge] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
        
        
        self.title = self.name;
    }else{
        
        [self.streamer pause];
        
        [self.playButton setImage:[UIImage imageNamed:@"play@2x.png"] forState:UIControlStateNormal];
        
    }
}

-(void)creatSubViews{
    
    UIImageView *bg_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    bg_image.frame = CGRectMake(0,
                                64,
                                self.view.frame.size.width,
                                MYHEIGHT - 64 - 49 - 20);
    bg_image.clipsToBounds = NO;
    
    self.bigImage = [[UIImageView alloc] init];
    
    self.bigImage.frame = bg_image.frame;

    
    
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:self.coverLarge] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        
        [UIView animateWithDuration:3 animations:^{
            
            [self.view bringSubviewToFront:self.bigImage];
        }];
        
    }];
    //毛玻璃
    UIVisualEffectView *visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    visualEfView.frame = CGRectMake(0,
                                    0,
                                    self.bigImage.frame.size.width,
                                    self.bigImage.frame.size.height);
    visualEfView.alpha = 0.8;
    [self.bigImage  addSubview:visualEfView];
    
    self.roundView = [[UIImageView alloc] initWithFrame:CGRectMake(self.bigImage.frame.size.width / 6,
                                                                           self.bigImage.frame.size.height / 4,
                                                                           (self.view.frame.size.width / 3) * 2,
                                                                           (self.view.frame.size.width / 3) * 2)];
    self.roundView.layer.masksToBounds = YES;//边框是否有弧度
    self.roundView.layer.borderWidth = 2;//边框厚度
    self.roundView.layer.cornerRadius = self.roundView.frame.size.width / 2;//边框弧度 = 矩形任意一边的一半,前提是矩形为的宽和高相等
    self.roundView.layer.borderColor = [UIColor blackColor].CGColor;//边框颜色

    
    
    [self.roundView sd_setImageWithURL:[NSURL URLWithString:self.coverLarge] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    
    [self.bigImage addSubview:self.roundView];
    
    
    UIImageView *footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                            self.view.frame.size.height - 70,
                                                                            self.view.frame.size.width,
                                                                            70)];
    footerView.userInteractionEnabled = YES;
    footerView.backgroundColor = [UIColor whiteColor];
    footerView.alpha = 1;
    
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.playButton.frame = CGRectMake((footerView.frame.size.width / 2) - 25,
                                  (footerView.frame.size.height / 2) - 25,
                                  50,
                                  50);
    [self.playButton setImage:[UIImage imageNamed:@"play@2x.png"] forState:UIControlStateNormal];
    
    self.playButton.backgroundColor = [UIColor clearColor];
    [self.playButton addTarget:self action:@selector(playButtonAciton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.backgroundColor = [UIColor clearColor];
    [nextButton setImage:[UIImage imageNamed:@"nextSong@2x.png"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    nextButton.frame = CGRectMake(self.playButton.frame.origin.x + self.playButton.frame.size.width + 10,
                                  self.playButton.frame.origin.y,
                                  self.playButton.frame.size.width ,
                                  self.playButton.frame.size.height);
    
    UIButton *upButton = [UIButton buttonWithType:UIButtonTypeCustom];
    upButton.backgroundColor = [UIColor clearColor];
    [upButton setImage:[UIImage imageNamed:@"preSong@2x.png"] forState:UIControlStateNormal];
    [nextButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [upButton addTarget:self action:@selector(UpButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    upButton.frame = CGRectMake(self.playButton.frame.origin.x - self.playButton.frame.size.width - 10,
                                  self.playButton.frame.origin.y,
                                  self.playButton.frame.size.width,
                                  self.playButton.frame.size.height);
    
    //创建进度条
    self.progressSlider = [[UISlider alloc] initWithFrame:CGRectMake(0,
                                                                     0,
                                                                     self.view.frame.size.width,
                                                                     10)];
    
    self.progressSlider.minimumValue = 0.0;
    self.progressSlider.minimumTrackTintColor = [UIColor blackColor];
    self.progressSlider.maximumTrackTintColor = [UIColor lightGrayColor];
    [self.progressSlider addTarget:self action:@selector(progressSliderAction:) forControlEvents:UIControlEventValueChanged];
    
    
    //创建播放时间标签
    self.timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,
                                                               self.progressSlider.frame.origin.y + 20,
                                                               50,
                                                               10)];
    self.timeLabel.text = @"00:00";
    self.timeLabel.font = [UIFont systemFontOfSize:14];
    
    //创建总时间标签
    self.totalTime = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 40,
                                                               self.timeLabel.frame.origin.y,
                                                               50,
                                                               10)];
    self.totalTime.text = @"00:00";
    self.totalTime.font = [UIFont systemFontOfSize:14];
    
    
    [footerView addSubview:self.totalTime];
    
    [footerView addSubview:self.timeLabel];
    
    [footerView addSubview:self.progressSlider];
    
    [footerView addSubview:self.playButton];
    
    [footerView addSubview:nextButton];
    
    [footerView addSubview:upButton];
    
    
    [self.view addSubview:bg_image];
    [self.view addSubview:self.bigImage];
    
    
    [self.view addSubview:footerView];
    
    [_timeLabel release];
    [_totalTime release];
    [_progressSlider release];
    [_roundView release];
    [_bigImage release];
    [bg_image release];
    [footerView release];
}
#pragma mark 滑动进度条改变播放进度
-(void)progressSliderAction:(UISlider *)slider{
    
    [self.streamer seekToTime:self.progressSlider.value];
    
}
#pragma mark 播放/暂停按钮
-(void)playButtonAciton:(UIButton *)button{
    
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    
    
    //设置暂停功能
    if (self.streamer.isPlaying) {
        [self.streamer pause];
        
        [self.playButton setImage:[UIImage imageNamed:@"play@2x.png"] forState:UIControlStateNormal];
        
       // [self RebeginRotate];
        [self stopRotate];
        
    }else if (self.streamer.isWaiting || self.streamer.isPaused || self.streamer.isIdle) {
        [self.streamer start];

        [self.playButton setImage:[UIImage imageNamed:@"pasueHight@2x.png"] forState:UIControlStateNormal];
        
        //开始旋转
        [self beginRotate];
    }

    
}
#pragma mark 恢复旋转
-(void)RebeginRotate{

    CFTimeInterval pausedTime = [self.roundView.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    self.roundView.layer.speed = 0.2;
    self.roundView.layer.timeOffset = pausedTime;
    
}
#pragma mark 停止旋转
-(void)stopRotate{
    CFTimeInterval pausedTime = [self.roundView.layer timeOffset];
    CFTimeInterval timeSincePause = [self.roundView.layer convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.roundView.layer.beginTime = timeSincePause;
}
#pragma mark 开始旋转
-(void)beginRotate{
    
    CABasicAnimation *monkeyAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    monkeyAnimation.toValue = [NSNumber numberWithFloat:2.0 * M_PI];
    monkeyAnimation.duration = 1.5f;
    monkeyAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    monkeyAnimation.cumulative = NO;
    monkeyAnimation.removedOnCompletion = NO; //No Remove
    
    monkeyAnimation.repeatCount = FLT_MAX;
    [self.roundView.layer addAnimation:monkeyAnimation forKey:@"AnimatedKey"];
    self.roundView.layer.speed = 0.2;
    self.roundView.layer.beginTime = 0.0;
}

#pragma mark  播放进度同步时间与进度条
-(void)timerAction:(NSTimer *)timer{
    
    //进度条与播放时间同步
    self.progressSlider.value = self.streamer.progress;
    
    //显示时间的标签与播放时间同步
    self.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)self.streamer.progress / 60, (NSInteger)self.streamer.progress % 60];//只有整形才能进行取余运算
    

    //进度条总时间与播放总时间
    self.progressSlider.maximumValue = self.streamer.duration;
    
    //显示总时间的标签与播放总时间同步
    self.totalTime.text = [NSString stringWithFormat:@"%02ld:%02ld", (NSInteger)self.streamer.duration / 60, (NSInteger)self.streamer.duration % 60];
    
    
        if ([self.streamer isIdle] && self.streamer.isPaused == NO) {//在正常结束播放的时候，将进度条与播放总时间相等
            self.progressSlider.value = self.streamer.progress;
        }
    
}
#pragma mark 下一首
-(void)nextButtonAction:(UIButton *)button{
    
    self.index++;
    
    //判断是否到达最后最后一首
    if (self.index == self.urlArray.count) {
        self.index = 0;
    }
    
    NSString *url = [self.urlArray objectAtIndex:self.index];
    
    self.title = [self.nameArray objectAtIndex:self.index];
    
    NSString *iamgeUrl = [self.imageArray objectAtIndex:self.index];
    
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    [self.roundView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];

    
    //先停止正在播放的音乐，然后重新创建新的streamer的对象，加载新的音乐链接
    [self stopMusic];
    //开启定时器
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    //开启音乐
    self.streamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:url]];
    
    [self.playButton setImage:[UIImage imageNamed:@"pasueHight@2x.png"] forState:UIControlStateNormal];
    [self.streamer start];
    
}
#pragma mark 上一首
-(void)UpButtonAction:(UIButton *)button{
    
    self.index--;
    
    //判断是否到达第一首
    if (self.index == -1) {
        self.index = self.urlArray.count - 1;
    }
    
    NSString *url = [self.urlArray objectAtIndex:self.index];
    
    self.title = [self.nameArray objectAtIndex:self.index];
    
    NSString *iamgeUrl = [self.imageArray objectAtIndex:self.index];
    
    [self.bigImage sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    [self.roundView sd_setImageWithURL:[NSURL URLWithString:iamgeUrl] placeholderImage:[UIImage imageNamed:@"placeHolder.png"]];
    
    //先停止正在播放的音乐，然后重新创建新的streamer的对象，加载新的音乐链接
    [self stopMusic];
    //开启定时器
    self.playTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];
    //开启音乐
    self.streamer = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:url]];
    
    [self.playButton setImage:[UIImage imageNamed:@"pasueHight@2x.png"] forState:UIControlStateNormal];
    [self.streamer start];
    
}
#pragma mark 停止音乐
-(void)stopMusic{
    
    if (self.streamer) {
        //停止音乐
        [self.streamer stop];
        [self.streamer release];
        self.streamer = nil;
        //停止定时器
        [self.playTimer invalidate];
        self.playTimer = nil;
    }
    
}
-(void)leftButtonAction{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        
    }];
}
-(void)dealloc{
    [_timeLabel release];
    [_totalTime release];
    [_progressSlider release];
    [_roundView release];
    [_bigImage release];
    [super dealloc];
}

@end
