//
//  WayPoint.h
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WayPoint : NSObject

@property (assign,nonatomic) NSInteger  beentocounts;
@property (copy,nonatomic)   NSString * cateid;
@property (copy,nonatomic)   NSString * cate_name;

@property (copy,nonatomic)   NSString * chinesename;
@property (copy,nonatomic)   NSString * englishname;

@property (copy,nonatomic)   NSString * city_id;
@property (assign,nonatomic) NSInteger  commentcounts;
@property (retain,nonatomic) NSMutableArray * comment_list;
@property (retain,nonatomic) NSMutableArray * mguides;
@property (assign,nonatomic) NSInteger  img_count;
@property (assign,nonatomic) CGFloat    duration;
@property (copy,nonatomic)   NSString * firstname;
@property (copy,nonatomic)   NSString * secnodname;
@property (copy,nonatomic)   NSString * pointID;
@property (copy,nonatomic)   NSString * introduction;
@property (assign,nonatomic) CGFloat    lng;
@property (assign,nonatomic) CGFloat    lat;
@property (copy,nonatomic)   NSString * localname;
@property (copy,nonatomic)   NSString * site;
@property (copy,nonatomic)   NSString * updatetime;
@property (assign,nonatomic) NSInteger  mapstatus;
@property (copy,nonatomic)   NSString * wayto;
@property (copy,nonatomic)   NSString * price;
@property (copy,nonatomic)   NSString * phone;
@property (copy,nonatomic)   NSString * opentime;
@property (copy,nonatomic)   NSString * address;
@property (copy,nonatomic)   NSString * photo;

@property (assign,nonatomic) NSInteger  recommendnumber;




@end
