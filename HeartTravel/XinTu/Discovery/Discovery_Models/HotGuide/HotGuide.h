//
//  HotGuide.h
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HotGuide : NSObject
@property (copy,nonatomic) NSString * avatar;
@property (copy,nonatomic) NSString * user_id;
@property (copy,nonatomic) NSString * username;

@property (copy,nonatomic) NSString * guideID;
@property (copy,nonatomic) NSString * guideDesc;
@property (copy,nonatomic) NSString * title;

@property (copy,nonatomic) NSString * photo;

//存放PointGuide类型 对象的数组
@property (retain,nonatomic) NSMutableArray * pointArray;

@property (assign,nonatomic) NSInteger count;



@end
