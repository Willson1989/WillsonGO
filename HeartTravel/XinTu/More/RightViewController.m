//
//  RightViewController.m
//  XinTu
//
//  Created by Bunny on 15/6/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "RightViewController.h"

@implementation RightViewController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatBackgroundView];
    
    [self creatSubViews];
}

-(void)creatSubViews{
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(115, 95, MYWIDTH - 120 - 20, 447)];
    buttonView.backgroundColor = [UIColor clearColor];
    
    self.DiaryDollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.DiaryDollectButton.backgroundColor = [UIColor clearColor];
    
    self.DiaryDollectButton.frame = CGRectMake(0,
                                               0,
                                               buttonView.frame.size.width,
                                               80);
    
    [self.DiaryDollectButton setTitle:@"热门游记收藏" forState:UIControlStateNormal];
    
    [self.DiaryDollectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.DiaryDollectButton addTarget:self action:@selector(DiaryDollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.FeatureDollectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.FeatureDollectButton.backgroundColor = [UIColor clearColor];
    
    self.FeatureDollectButton.frame = CGRectMake(0,
                                                 self.DiaryDollectButton.frame.origin.y + self.DiaryDollectButton.frame.size.height + 10,
                                                 buttonView.frame.size.width,
                                                 80);
    
    [self.FeatureDollectButton setTitle:@"当地特色收藏" forState:UIControlStateNormal];
    
    [self.FeatureDollectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.FeatureDollectButton addTarget:self action:@selector(FeatureDollectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.clearButton.backgroundColor = [UIColor clearColor];
    
    self.clearButton.frame = CGRectMake(0,
                                        self.FeatureDollectButton.frame.origin.y + self.FeatureDollectButton.frame.size.height + 10,
                                        buttonView.frame.size.width,
                                        80);
    
    [self.clearButton setTitle:@"清空缓存" forState:UIControlStateNormal];
    
    [self.clearButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.clearButton addTarget:self action:@selector(clearButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.musicButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.musicButton.backgroundColor = [UIColor clearColor];
    
    self.musicButton.frame = CGRectMake(0,
                                        self.clearButton.frame.origin.y + self.clearButton.frame.size.height + 10,
                                        buttonView.frame.size.width,
                                        80);
    [self.musicButton setTitle:@"正在播放" forState:UIControlStateNormal];
    
    [self.musicButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.musicButton addTarget:self action:@selector(musicButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.aboutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.aboutButton.backgroundColor = [UIColor clearColor];
    self.aboutButton.frame = CGRectMake(0,
                                        self.musicButton.frame.origin.y + self.musicButton.frame.size.height + 10,
                                        buttonView.frame.size.width,
                                        80);
    [self.aboutButton setTitle:@"关于" forState:UIControlStateNormal];
    
    [self.aboutButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.aboutButton addTarget:self action:@selector(aboutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [buttonView addSubview:self.FeatureDollectButton];
    
    [buttonView addSubview:self.DiaryDollectButton];
    
    [buttonView addSubview:self.clearButton];
    
    [buttonView addSubview:self.musicButton];
    
    [buttonView addSubview:self.aboutButton];
    
    [self.view addSubview:buttonView];
    
    [_nightLabel release];
    [buttonView release];
}


-(void)creatBackgroundView{
    
    UIImageView *bg_view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    bg_view.alpha = 0.5;
    
    bg_view.image = [UIImage imageNamed:@"bg_rightVC.png"];
    
    [self.view addSubview:bg_view];
    
    [bg_view release];
    
    
}

-(void)musicButtonAction:(UIButton *)button{
    
    UINavigationController *playMusic = [[UINavigationController alloc] initWithRootViewController:[PlayMusicViewController shareDataHandle]];
    
    if ([PlayMusicViewController shareDataHandle].streamer.isPlaying == YES || [PlayMusicViewController shareDataHandle].streamer.isPaused == YES) {
        
        [self presentViewController:playMusic animated:YES completion:^{

        }];
    }
    [playMusic release];

}
-(void)FeatureDollectButtonAction:(UIButton *)button{
    
    FeatureDollectViewController *featureDollectVC = [[FeatureDollectViewController alloc] init];
    
    UINavigationController *featureDollecNC = [[UINavigationController alloc] initWithRootViewController:featureDollectVC];
    
    [self presentViewController:featureDollecNC animated:YES completion:^{
        
        
    }];
    [featureDollecNC release];
    [featureDollectVC release];
}

-(void)DiaryDollectButtonAction:(UIButton *)button{
    
    DiaryDollectViewController *diaryCollectVC = [[DiaryDollectViewController alloc] init];
    UINavigationController * dnav = [[UINavigationController alloc]initWithRootViewController:diaryCollectVC];
    
    [self presentViewController:dnav animated:YES completion:^{
        
        
    }];
    
    [diaryCollectVC release];
    
}

-(void)aboutButtonAction:(UIButton *)button{
    
    AboutViewController *abutVC = [[AboutViewController alloc] init];
    
    UINavigationController *aboutNC = [[UINavigationController alloc] initWithRootViewController:abutVC];
    
    [self presentViewController:aboutNC animated:YES completion:^{
        
        
    }];
    
    [aboutNC release];
    [abutVC release];
}

-(void)clearButtonAction:(UIButton *)button{
    
    [self creatAlerView];
    
}

-(void)creatAlerView{
    
    [[CacheDataHandle shareDataHandle] clearCache];
    
    NSString *size = [[CacheDataHandle shareDataHandle] getCacheFileSize];
    
    NSString *str = [NSString stringWithFormat:@"小途为主人清空了%@MB的缓存",size];
    
    UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"哇塞" message:str delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alerView show];
}

@end
