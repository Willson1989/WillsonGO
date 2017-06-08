//
//  Video.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject

@property (nonatomic, copy) NSString *bigPicUrl; //视频截图

@property (nonatomic, copy) NSString *outerGPlayerUrl; //播放链接

@property (nonatomic, copy) NSString *outerPlayerUrl;

@property (nonatomic, copy) NSString *title; //视频名字

@property (nonatomic, copy) NSString *descriptioned; //视频描述

@end
