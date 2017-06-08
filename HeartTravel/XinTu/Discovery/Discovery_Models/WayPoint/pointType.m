//
//  pointType.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "pointType.h"

@implementation pointType

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.poiID = [(NSString *)value integerValue];
    }
    if ([key isEqualToString:@"name"]) {
        self.poiName = value;
    }
}

@end
