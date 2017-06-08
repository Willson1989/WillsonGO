//
//  SearchResult.h
//  XinTu
//
//  Created by WillHelen on 15/7/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchResult : NSObject

@property (assign,nonatomic) NSInteger beennumber;
@property (copy,nonatomic) NSString * beenstr;
@property (copy,nonatomic) NSString * cnname;
@property (copy,nonatomic) NSString * enname;
@property (assign,nonatomic) NSInteger grade;
@property (assign,nonatomic) BOOL  has_mguide;
@property (assign,nonatomic) NSInteger resultID;
@property (copy,nonatomic) NSString * label;
@property (copy,nonatomic) NSString * parentname;
@property (copy,nonatomic) NSString * parent_parentname;
@property (assign,nonatomic) NSInteger parentid;

@property (copy,nonatomic) NSString * photo;
@property (assign,nonatomic) NSInteger type;


@end
