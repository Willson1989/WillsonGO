//
//  WayPointList.m
//  XinTu
//
//  Created by WillHelen on 15/6/27.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "WayPointList.h"

@implementation WayPointList


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.wayPointID = [(NSString *)value integerValue];
    }
}

@end
