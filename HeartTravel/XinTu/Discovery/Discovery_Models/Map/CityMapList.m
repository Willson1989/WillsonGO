//
//  CityMapList.m
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityMapList.h"

@implementation CityMapList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cityID = value;
    }
}

@end
