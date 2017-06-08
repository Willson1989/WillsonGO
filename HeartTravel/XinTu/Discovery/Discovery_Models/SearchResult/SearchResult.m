//
//  SearchResult.m
//  XinTu
//
//  Created by WillHelen on 15/7/4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SearchResult.h"

@implementation SearchResult

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.resultID = [(NSString*)value integerValue];
    }
}

@end
