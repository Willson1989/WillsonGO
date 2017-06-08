//
//  PointGuide.h
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PointGuide : NSObject

//去过
@property (assign,nonatomic) NSInteger beennumber;
@property (copy,nonatomic) NSString * beenstr;

@property (copy,nonatomic) NSString * chinesename;
@property (copy,nonatomic) NSString * englishname;
@property (copy,nonatomic) NSString * firstname;
@property (copy,nonatomic) NSString * secondname;
@property (copy,nonatomic) NSString * cityname;
@property (copy,nonatomic) NSString * countryname;
@property (copy,nonatomic) NSString * pointID;
@property (copy,nonatomic) NSString * pointDesc;
@property (copy,nonatomic) NSString * photo;

@property (assign,nonatomic) NSInteger recommandstar;
@property (assign,nonatomic) NSInteger mapstatus;

//地点定位-纬度
@property (assign,nonatomic) CGFloat  lat;
//地点定位-经度
@property (assign,nonatomic) CGFloat  lng;

@end
