//
//  Country.h
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Country : NSObject<NSCoding>

@property (copy,nonatomic) NSString * enname;
@property (copy,nonatomic) NSString * cnname;
@property (copy,nonatomic) NSString * countryID;
@property (copy,nonatomic) NSString * label;
@property (copy,nonatomic) NSString * photo;

//国家的使用信息
@property (copy,nonatomic) NSString * overview_url;

//国家图片数组
@property (retain,nonatomic) NSArray * photos;

//热门城市
@property (retain,nonatomic) NSArray * hot_city;

//热门当地特色
@property (retain,nonatomic) NSArray * hot_mguide;

@property (copy,nonatomic) NSString * type;

@property (copy,nonatomic) UIImageView * countryImage;


@end
