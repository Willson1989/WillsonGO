//
//  Video.m
//  XinTu
//
//  Created by WillHelen on 15/6/19.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "Video.h"

@implementation Video

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    if ([key isEqualToString:@"description"]) {
        
        self.descriptioned = value;
        
    }
    if ([key isEqualToString:@"outerPlayerUrl"]) {
        
        self.outerPlayerUrl = value;
    }
}
#pragma mark 归档第三步:实现编码方法,将对象的属性进行编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.bigPicUrl forKey:@"bigPicUrl"];
    [aCoder encodeObject:self.outerGPlayerUrl forKey:@"outerGPlayerUrl"];
    [aCoder encodeObject:self.outerPlayerUrl forKey:@"outerPlayerUrl"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.descriptioned forKey:@"descriptioned"];

}
#pragma mark 归档第四步:将对象的属性进行解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.bigPicUrl = [aDecoder decodeObjectForKey:@"bigPicUrl"];
        self.outerGPlayerUrl = [aDecoder decodeObjectForKey:@"outerGPlayerUrl"];
        self.outerPlayerUrl = [aDecoder decodeObjectForKey:@"outerPlayerUrl"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.descriptioned = [aDecoder decodeObjectForKey:@"descriptioned"];
    }
    return self;
}

@end
