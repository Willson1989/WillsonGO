//
//  Country.m
//  XinTu
//
//  Created by WillHelen on 15/6/20.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Country.h"

@implementation Country

-(void)dealloc{
    [self.photos release];
    [self.hot_mguide release];
    [self.hot_city release];
    [super dealloc];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    return nil;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        self.countryID = value;
    }
}

-(instancetype)init{
    if (self = [super init]) {
        self.type = @"country";
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"cID : %@ , cCnName : %@ , cEnName : %@ ",self.countryID,self.cnname,self.enname];
}


@end
