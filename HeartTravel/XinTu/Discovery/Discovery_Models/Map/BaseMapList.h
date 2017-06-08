//
//  BaseMapList.h
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseMapList : NSObject

@property (copy,nonatomic) NSString * beenstr;
@property (copy,nonatomic) NSString * cnname;
@property (copy,nonatomic) NSString * enname;
@property (copy,nonatomic) NSString * itemID;
@property (assign,nonatomic) BOOL     is_recommend;
@property (assign,nonatomic) CGFloat lat;
@property (assign,nonatomic) CGFloat lng;
@property (copy,nonatomic) NSString * photo;


@end
