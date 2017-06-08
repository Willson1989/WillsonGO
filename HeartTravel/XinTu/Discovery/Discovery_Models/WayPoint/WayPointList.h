//
//  WayPointList.h
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WayPointList : NSObject

@property (copy,nonatomic)   NSString * photo;
@property (copy,nonatomic)   NSString * beennumber;
@property (copy,nonatomic)   NSString * beenstr;
@property (copy,nonatomic)   NSString * chinesename;
@property (copy,nonatomic)   NSString * englishname;
@property (copy,nonatomic)   NSString * firstname;
@property (copy,nonatomic)   NSString * secondname;
@property (copy,nonatomic)   NSString * localname;
@property (assign,nonatomic) NSInteger  grade;
@property (assign,nonatomic) NSInteger  gradescores;
@property (assign,nonatomic) BOOL       has_mguide;
@property (assign,nonatomic) NSInteger  wayPointID;
@property (copy,nonatomic)   NSString * distance;

@property (assign,nonatomic) NSInteger  mapstatus;
@property (assign,nonatomic) CGFloat    lat;
@property (assign,nonatomic) CGFloat    lon;


@end
