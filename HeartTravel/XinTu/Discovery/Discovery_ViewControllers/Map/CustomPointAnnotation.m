//
//  CustomPointAnnotation.m
//  XinTu
//
//  Created by WillHelen on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CustomPointAnnotation.h"

@implementation CustomPointAnnotation

-(void)dealloc{
    [self.baseList release];
    [super dealloc];
}

-(instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

@end
