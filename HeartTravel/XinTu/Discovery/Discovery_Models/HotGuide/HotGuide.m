//
//  HotGuide.m
//  XinTu
//
//  Created by WillHelen on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuide.h"

@implementation HotGuide

-(void)dealloc{
    [self.pointArray release];
    [super dealloc];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.guideID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.guideDesc = value;
    }
}

-(instancetype)init{
    if (self = [super init]) {
        self.pointArray = [NSMutableArray array];
    }
    return self;
}

@end
