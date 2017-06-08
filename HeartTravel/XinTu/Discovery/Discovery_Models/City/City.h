//
//  City.h
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (assign,nonatomic) NSInteger   cityID;
@property (copy,nonatomic)   NSString  * cnname;
@property (copy,nonatomic)   NSString  * enname;
@property (copy,nonatomic)   NSString  * country_cnname;
@property (copy,nonatomic)   NSString  * country_enname;
@property (assign,nonatomic) NSInteger   country_id;
@property (copy,nonatomic)   NSString  * overview_url;

//当前城市的当地热门特色数组
@property (retain,nonatomic) NSMutableArray * hot_mguide;

//城市图片数组
@property (retain,nonatomic) NSMutableArray * photos;

@property (copy,nonatomic) NSString * type;

@end
