//
//  HotTravel.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotTravel : NSObject
//一级页面--------------------------------------
@property (nonatomic,copy)NSString   *cover;

@property (nonatomic,copy)NSString   *title;

@property (nonatomic,copy)NSString   *date;

@property (nonatomic,copy)NSString   *days;
//浏览次数
@property (nonatomic,copy)NSString   *browse;

@property (nonatomic,copy)NSString   *place;

@property (nonatomic,copy)NSString   *UserName;

@property (nonatomic,copy)NSString   *Userpic;

@property (nonatomic,copy)NSString   *coverTitle;

@property (nonatomic,copy)NSString   *NextId;
//滚动广告的标题
//@property (nonatomic,retain)NSString   *cover_title;
//二级页面---------------------------------------

@property (nonatomic,copy)NSString   *NextText;

@property (nonatomic,copy)NSString   *Nextcover;

@property (nonatomic,copy)NSString   *NextTime;

@property (nonatomic,copy)NSString   *NextPlace;

@property (nonatomic,assign)NSInteger Width;

@property (nonatomic,assign)NSInteger Hight;
//cell 高度
@property (nonatomic,assign) CGFloat    MyHeight;




@end
