//
//  Route.h
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Route : NSObject

//地点


@property (nonatomic,copy) NSString     *PlaceText;


//景区

@property (nonatomic,retain)NSMutableArray *spotArray;
@property (nonatomic,copy) NSString     *spotText;

//布局
@property (nonatomic,assign)NSInteger   Cellnumber;

//section
@property (nonatomic,copy)NSString   *days;
@property (nonatomic,copy)NSString   *date;
//地点ID
@property (nonatomic,copy)NSString   *PlaceID;
@property (nonatomic,copy)NSString   *PlaceType;

//3级
@property (nonatomic,copy)NSString  *type;
//*****4级
@property (nonatomic,copy)NSString   *spotsName;

@property (nonatomic,copy)NSString   *spotsPic;

@property (nonatomic,copy)NSString   *country;
@end
