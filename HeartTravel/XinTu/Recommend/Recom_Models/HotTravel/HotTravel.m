//
//  HotTravel.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "HotTravel.h"

@implementation HotTravel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
};

#pragma mark 归档第三步:实现编码方法,将对象的属性进行编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.date forKey:@"date"];
    [aCoder encodeObject:self.days forKey:@"days"];
    [aCoder encodeObject:self.browse forKey:@"browse"];
    [aCoder encodeObject:self.place forKey:@"place"];
    [aCoder encodeObject:self.UserName forKey:@"UserName"];
    [aCoder encodeObject:self.Userpic forKey:@"Userpic"];
    [aCoder encodeObject:self.coverTitle forKey:@"coverTitle"];
    [aCoder encodeObject:self.NextId forKey:@"NextId"];
    
    
}
#pragma mark 归档第四步:将对象的属性进行解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.cover = [aDecoder decodeObjectForKey:@"cover"];
        self.date = [aDecoder decodeObjectForKey:@"date"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.days = [aDecoder decodeObjectForKey:@"days"];
        self.browse = [aDecoder decodeObjectForKey:@"browse"];
        self.place = [aDecoder decodeObjectForKey:@"place"];
        self.UserName = [aDecoder decodeObjectForKey:@"UserName"];
        self.Userpic = [aDecoder decodeObjectForKey:@"Userpic"];
        self.coverTitle = [aDecoder decodeObjectForKey:@"coverTitle"];
        self.NextId = [aDecoder decodeObjectForKey:@"NextId"];

    }
    return self;
}



@end
