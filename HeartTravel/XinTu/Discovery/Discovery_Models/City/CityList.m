//
//  CityList.m
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CityList.h"

@implementation CityList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.cityID = value;
    }
}

@end
