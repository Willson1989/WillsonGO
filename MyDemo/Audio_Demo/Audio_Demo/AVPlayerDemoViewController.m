//
//  AVPlayerDemoViewController.m
//  Audio_Demo
//
//  Created by ZhengYi on 16/9/22.
//  Copyright © 2016年 ZhengYi. All rights reserved.
//

#import "AVPlayerDemoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface AVPlayerDemoViewController ()<AVAudioPlayerDelegate>


@property (weak, nonatomic) IBOutlet UIButton *btn_Play;
@property (weak, nonatomic) IBOutlet UILabel  *lb_MusicName;
@property (weak, nonatomic) IBOutlet UIProgressView *progresView;
@property (strong, nonatomic) AVAudioSession *audioSession;
@property (strong, nonatomic) AVAudioPlayer  *audioPlayer;
@property (strong, nonatomic) NSMutableArray *musicList;
@property (strong, nonatomic) NSMutableArray *musicNameArr;
@property (assign, nonatomic) NSInteger currentIndex;
@property (strong, nonatomic) NSTimer  *timer;

@end

@implementation AVPlayerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"音频播放";

    [self _loadMusicList];
    [self _configudioPlayerWithUrl:(NSURL *)self.musicList[0]];
    [self _confiUI];
}

- (void)viewWillDisappear:(BOOL)animated{
    [self.audioSession setActive:NO error:nil];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)_confiUI{
    [self.progresView setProgress:0.0 animated:NO];
    self.lb_MusicName.text = self.musicNameArr[self.currentIndex];
}

- (void)_loadMusicList{
    self.musicList = [NSMutableArray array];
    self.musicNameArr = [NSMutableArray array];
    self.currentIndex = 0;
    NSString *baseName = @"music-0";
    NSInteger index = 1;
    while ([[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%ld.mp3",baseName,index] ofType:nil]) {
        NSString *resourcePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%ld.mp3",baseName,index] ofType:nil];
        NSLog(@"resourcePath : %@",resourcePath);
        NSURL *fileUrl = [NSURL fileURLWithPath:resourcePath];
        [self.musicList addObject:fileUrl];
        [self.musicNameArr addObject:[NSString stringWithFormat:@"%@%li",baseName,index]];
        index ++;
    }
}

- (void)_configudioPlayerWithUrl:(NSURL *)contentUrl{
    if (_audioPlayer) {
        _audioPlayer = nil;
        _audioPlayer.delegate = nil;
    }
    NSError *error = nil;
    
    _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:contentUrl error:&error];
    
    _audioPlayer.delegate = self;
    
    //0 为不循环
    _audioPlayer.numberOfLoops = 0;
    
    //预加载，将音频文件先加载到缓冲区中，就算不执行，在播放音频的时候也会隐式执行
    [_audioPlayer prepareToPlay];
    
    
    [self.audioSession setActive:YES error:nil];
    
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                  target:self
                                                selector:@selector(updateProgess)
                                                userInfo:nil
                                                 repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
    return _timer;
}

- (AVAudioSession *)audioSession{
    if (!_audioSession) {
        self.audioSession = [AVAudioSession sharedInstance];
        [self.audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(routeChanged:)
                                                     name:AVAudioSessionRouteChangeNotification
                                                   object:nil];
    }
    return _audioSession;
}

- (IBAction)playButtonAction:(UIButton *)sender {
    
    if (![self.audioPlayer isPlaying]) {
        //未播放
        
        [self _play];
        
    } else {
        //正在播放
       
        [self _pause];
    }
}

- (IBAction)prevButtonAction:(id)sender {
    [self _pause];
    self.currentIndex--;
    if (self.currentIndex < 0) {
        self.currentIndex = self.musicList.count - 1;
    }
    [self _configudioPlayerWithUrl:self.musicList[self.currentIndex]];
    [self _confiUI];
    [self _play];
    
}
- (IBAction)nextButtonAction:(id)sender {
    [self _pause];
    self.currentIndex++;
    if (self.currentIndex > self.musicList.count - 1) {
        self.currentIndex = 0;
    }
    [self _configudioPlayerWithUrl:self.musicList[self.currentIndex]];
    [self _confiUI];
    [self _play];
}

- (void)updateProgess{
    CGFloat progress = self.audioPlayer.currentTime / self.audioPlayer.duration;
    [self.progresView setProgress:progress animated:YES];
}

- (void)_play{
    if (![self.audioPlayer isPlaying]) {
        [self.audioPlayer play];
        //恢复计时
        self.timer.fireDate = [NSDate distantPast];
        [self _setPlayBtnStyleIsPlaying:YES];
    }
}

- (void)_pause{
    if ([self.audioPlayer isPlaying]) {
        [self.audioPlayer pause];
        //停止计时
        self.timer.fireDate = [NSDate distantFuture];
        [self _setPlayBtnStyleIsPlaying:NO];
    }
}

- (void)_setPlayBtnStyleIsPlaying:(BOOL)isPlaying{
    [self.btn_Play setTitle:isPlaying ? @"暂停" : @"播放" forState:UIControlStateNormal];
    [self.btn_Play setTitle:isPlaying ? @"暂停" : @"播放" forState:UIControlStateHighlighted];
}

#pragma mark - AVAudioPlayerDelegate
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    [self _setPlayBtnStyleIsPlaying:NO];
    [self.audioSession setActive:NO error:nil];
    self.currentIndex ++;
    if (self.currentIndex > self.musicList.count-1) {
        self.currentIndex = 0;
    }
    [self _configudioPlayerWithUrl:self.musicList[self.currentIndex]];
    [self _confiUI];
    [self _play];
    [self _setPlayBtnStyleIsPlaying:YES];
}

- (void)routeChanged:(NSNotification *)notification{
    
    NSDictionary *dic = notification.userInfo;
    int chageReason = [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    if (chageReason == AVAudioSessionRouteChangeReasonNewDeviceAvailable) {
        
        AVAudioSessionRouteDescription *routeDesc = dic[AVAudioSessionRouteChangePreviousRouteKey];
        //插上耳机之后，NewDevice为耳机，那么PreviousRoute就是speaker。
        AVAudioSessionPortDescription  *portDesc = [routeDesc.outputs firstObject];
        NSLog(@"===== portType : %@",portDesc.portType);
    }
    //耳机拔出
    if (chageReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        
        AVAudioSessionRouteDescription *routeDesc = dic[AVAudioSessionRouteChangePreviousRouteKey];
        //拔掉耳机之后，OldDevice为耳机，那么PreviousRoute就是Headphones
        AVAudioSessionPortDescription  *portDesc = [routeDesc.outputs firstObject];
        //如果原输出设备为耳机的话，则暂停
        if ([portDesc.portType isEqualToString:@"Headphones"]) {
            NSLog(@"===== portType : %@",portDesc.portType);
            /*
             这里暂停的方法需要放在主线程中执行，因为其中涉及到UI的更新
             如果不放在主线程中执行的话，会报错，但是貌似不会影响使用，但是有风险
             This application is modifying the autolayout engine from a 
             background thread, which can lead to engi....
             参考：http://www.th7.cn/Program/IOS/201511/702408.shtml
             */
            
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(mainQueue, ^{
                
                [self _pause];
            });
        }
    }
}

- (void)dealloc{
//    UInt32 audioRouteOverride = hasHeadset ?kAudioSessionOverrideAudioRoute_None:kAudioSessionOverrideAudioRoute_Speaker;
//    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);

    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVAudioSessionRouteChangeNotification object:nil];
}

@end
