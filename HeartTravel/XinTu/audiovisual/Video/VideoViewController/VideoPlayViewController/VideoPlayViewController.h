//
//  VideoPlayViewController.h
//  XinTu
//
//  Created by Bunny on 15/6/29.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayMusicViewController.h"

@interface VideoPlayViewController : UIViewController<UIWebViewDelegate>

-(void)creatWebView:(NSURL *)url;

@property (nonatomic, retain) UIWebView  *playWeb;


@end
