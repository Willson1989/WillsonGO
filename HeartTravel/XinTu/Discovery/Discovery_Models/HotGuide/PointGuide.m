//
//  PointGuide.m
//  XinTu
//
//  Created by WillHelen on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PointGuide.h"

@implementation PointGuide

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.pointID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.pointDesc = value;
    }
}

@end
