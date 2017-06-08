//
//  MusicModel.h
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MusicModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *tname; //风格列表题目

@property (nonatomic, copy) NSString *cover_path; //风格列表图片链接



@property (nonatomic, copy) NSString *title; // 电台列表题目(+ 播放列表题目)

@property (nonatomic, copy) NSString *albumCoverUrl290; // 图片链接

@property (nonatomic, copy) NSString *playsCounts; //播放次数

@property (nonatomic, copy) NSString *intro; //简介

@property (nonatomic, copy) NSString *albumId; //跳转到播放列表id


@property (nonatomic, copy) NSString *playUrl64; // 音频链接

@property (nonatomic, copy) NSString *playtimes; // 音频播放次数

@property (nonatomic, copy) NSString *duration; // 音频时长(秒)

@property (nonatomic, copy) NSString *coverLarge; // 音频截图

@end
