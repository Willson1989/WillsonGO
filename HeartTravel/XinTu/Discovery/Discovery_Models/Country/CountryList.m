//
//  CountryList.m
//  XinTu
//
//  Created by WillHelen on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CountryList.h"

@implementation CountryList

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.cImage = [aDecoder decodeObjectForKey:@"cImage"];
        self.hot_country = [aDecoder decodeObjectForKey:@"hot_country"];
        self.other_country = [aDecoder decodeObjectForKey:@"other_country"];
    }
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.cImage forKey:@"cImage"];
    [aCoder encodeObject:self.hot_country forKey:@"hot_country"];
    [aCoder encodeObject:self.other_country forKey:@"other_country"];
}

@end
