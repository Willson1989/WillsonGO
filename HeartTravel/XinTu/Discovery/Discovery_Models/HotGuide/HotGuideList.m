//
//  HotGuideList.m
//  XinTu
//
//  Created by WillHelen on 15/6/25.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotGuideList.h"

@implementation HotGuideList

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.guideID = value;
    }
    if ([key isEqualToString:@"description"]) {
        self.guideListDesc = value;
    }
}

@end
