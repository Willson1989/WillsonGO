//
//  PointMapLast.m
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "PointMapLast.h"

@implementation PointMapLast

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.pointID = value;
    }
}

@end
