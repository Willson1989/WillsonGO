//
//  RecordViewController.m
//  Audio_Demo
//
//  Created by ZhengYi on 16/9/28.
//  Copyright © 2016年 ZhengYi. All rights reserved.
//

#import "RecordViewController.h"
#import <AVFoundation/AVFoundation.h>

#define kRecordFileName @"myRecord001"

#define kTitle_Player_Play @"播放录音"
#define kTitle_Player_Stop @"暂停播放"

#define kTitle_Record_Record @"开始录音"
#define kTitle_Record_Stop   @"结束录音"

@interface RecordViewController ()<AVAudioRecorderDelegate, AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *recordBtn;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@property (weak, nonatomic) IBOutlet UIButton *playBtn;

@property (strong, nonatomic) AVAudioRecorder *audioRecord;

@property (strong, nonatomic) AVAudioPlayer   *audioPlay;

@property (strong, nonatomic) AVAudioSession  *audioSession;

@property (assign, nonatomic) BOOL recording;

@property (assign, nonatomic) BOOL playing;

@property (strong, nonatomic) NSMutableDictionary *settings;

@property (strong, nonatomic) NSTimer *timer_Progress;

@property (assign, nonatomic) BOOL isHeadset;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"录音02";
    [self.recordBtn addTarget:self action:@selector(recordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.playBtn addTarget:self action:@selector(playBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(routeDidChanged:) name:AVAudioSessionRouteChangeNotification object:nil];
    _audioSession = [AVAudioSession sharedInstance];
    NSError *sessionError;
    [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (!_audioSession) {
        NSLog(@"session error");
    }
    //setActive 方法会触发 AVAudioSessionRouteChangeNotification 通知
    [_audioSession setActive:YES error:nil];
    
    [self setHeadSet:[self isHeadsetPlugin]];
    
}

//检测耳机是否插入
- (BOOL)isHeadsetPlugin{
    AVAudioSessionRouteDescription *routeDesc = [[AVAudioSession sharedInstance] currentRoute];
    //NSLog(@"outputs : %@",routeDesc.outputs);
    for (AVAudioSessionPortDescription *portDesc in routeDesc.outputs) {
        NSLog(@"output : %@",portDesc.portType);
        if ([portDesc.portType isEqualToString:AVAudioSessionPortHeadphones]){
            NSLog(@"isHeadSet");
            return YES;
        }
    }
    return NO;
}

- (void)setHeadSet:(BOOL)isHeadset{
    _isHeadset =  isHeadset;
    
    //插上耳机时，输出设备为耳机、拔掉耳机时，输出设备为手机扬声器
    //kAudioSessionOverrideAudioRoute_None  内声道,耳机
    //kAudioSessionOverrideAudioRoute_Speaker 扬声器
    UInt32 audioRouteOverride = isHeadset ? kAudioSessionOverrideAudioRoute_None:kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideAudioRoute, sizeof(audioRouteOverride), &audioRouteOverride);
    
}

- (void)routeDidChanged:(NSNotification *)notification{
    NSLog(@"routeDidChanged");
    NSDictionary *dic = notification.userInfo;
    int changeReason = [dic[AVAudioSessionRouteChangeReasonKey] intValue];
    AVAudioSessionRouteDescription *routedesc = dic[AVAudioSessionRouteChangePreviousRouteKey];
    AVAudioSessionPortDescription *portDesc = [routedesc.outputs firstObject];
    NSLog(@"===== portType : %@",portDesc.portType);
    if (changeReason == AVAudioSessionRouteChangeReasonNewDeviceAvailable) {
        //插上耳机
        if ([portDesc.portType isEqualToString:@"Speaker"]) {
            [self setHeadSet:YES];
        }
    }
    if (changeReason == AVAudioSessionRouteChangeReasonOldDeviceUnavailable) {
        if ([portDesc.portType isEqualToString:@"Headphones" ]) {
            [self setHeadSet:NO];
        }
    }
}

- (NSURL *)_getAudioFilePath{
    
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *filePath = [docPath stringByAppendingPathComponent:kRecordFileName];
    
    NSLog(@"-------- record path : %@",filePath);
    
    return [NSURL URLWithString:filePath];
}

- (NSDictionary *)_getAudioRecordSettings{
    
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    
    //设置录音格式
    //[settings setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    [settings setObject:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
    
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    //[settings setObject:@(8000) forKey:AVSampleRateKey];
    [settings setObject:@(44100.0) forKey:AVSampleRateKey];
    
    //设置通道,这里采用单声道
    [settings setObject:@(1) forKey:AVNumberOfChannelsKey];
    
    //每个采样点位数,分为8、16、24、32
    [settings setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    
    //是否使用浮点数采样
    [settings setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    return settings;
}

- (void)recordBtnAction:(UIButton *)button{
    if (_playing) {
        return;
    }
    if (!_audioRecord) {
        
        NSError *error ;
        _audioRecord = [[AVAudioRecorder alloc]initWithURL:[self _getAudioFilePath] settings:[self _getAudioRecordSettings] error:&error];
        _audioRecord.meteringEnabled = YES;
        _playBtn.enabled = NO;
        _audioRecord.delegate = self;
        [_audioRecord prepareToRecord];
        [_audioRecord record];
        _recording = YES;
        [_recordBtn setTitle:kTitle_Record_Stop forState:UIControlStateNormal];
        
        if (_timer_Progress) {
            [_timer_Progress invalidate];
            _timer_Progress = nil;
        }
        _timer_Progress = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer_Progress forMode:NSRunLoopCommonModes];
    }
    else {
        
        [_audioRecord stop];
        _audioRecord = nil;
        _recording = NO;
        [_recordBtn setTitle:kTitle_Record_Record forState:UIControlStateNormal];
        
        [_timer_Progress invalidate];
        _timer_Progress = nil;
    }
}

- (void)playBtnAction:(UIButton *)button{
    
    if (_recording) {
        return;
    }
    
    if (!_audioPlay) {
        _playing = YES;
        NSError *error;
        _audioPlay = [[AVAudioPlayer alloc]initWithContentsOfURL:[self _getAudioFilePath] error:&error];
        _audioPlay.delegate = self;
        _audioPlay.numberOfLoops = 0;
        [_audioPlay prepareToPlay];
        [_audioPlay play];
        [_playBtn setTitle:kTitle_Player_Stop forState:UIControlStateNormal];
        //[_audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    else {
        _playing = NO;
        [_audioPlay stop];
        _audioPlay = nil;
        [_playBtn setTitle:kTitle_Player_Play forState:UIControlStateNormal];
    }
}

- (void)updateProgress{
    [_audioRecord updateMeters];
    
    float power = [_audioRecord averagePowerForChannel:0];
    
    CGFloat progress = (power + 60) / 60;
    
    [_progressView setProgress:progress];
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    NSLog(@"play  did finished");
    [_playBtn setTitle:kTitle_Player_Play forState:UIControlStateNormal];
    _playing = NO;
    _recording = NO;
    _audioPlay = nil;
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    NSLog(@"record  did finished");
    [_progressView setProgress:0.0];
    _playBtn.enabled = YES;
    _recording = NO;
    _playing = NO;
}

@end
