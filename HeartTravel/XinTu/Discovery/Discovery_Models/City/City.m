//
//  City.m
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "City.h"

@implementation City

-(void)dealloc{
    [self.photos release];
    [self.hot_mguide release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cityID = [(NSString *)value integerValue];
    }
}

-(instancetype)init{
    if (self = [super init]) {
        self.type = @"city";
    }
    return self;
}

@end
