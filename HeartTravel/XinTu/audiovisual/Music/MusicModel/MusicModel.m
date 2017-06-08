//
//  MusicModel.m
//  XinTu
//
//  Created by Bunny on 15/6/26.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "MusicModel.h"

@implementation MusicModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    

}

#pragma mark 归档第三步:实现编码方法,将对象的属性进行编码
-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.tname forKey:@"tname"];
    [aCoder encodeObject:self.cover_path forKey:@"cover_path"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.albumCoverUrl290 forKey:@"albumCoverUrl290"];
    [aCoder encodeObject:self.playsCounts forKey:@"playsCounts"];
    [aCoder encodeObject:self.intro forKey:@"intro"];
    [aCoder encodeObject:self.albumId forKey:@"albumId"];
    [aCoder encodeObject:self.playUrl64 forKey:@"playUrl64"];
    [aCoder encodeObject:self.playtimes forKey:@"playtimes"];
    [aCoder encodeObject:self.duration forKey:@"duration"];
    [aCoder encodeObject:self.coverLarge forKey:@"coverLarge"];

}
#pragma mark 归档第四步:将对象的属性进行解码
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.tname = [aDecoder decodeObjectForKey:@"tname"];
        self.cover_path = [aDecoder decodeObjectForKey:@"cover_path"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.albumCoverUrl290 = [aDecoder decodeObjectForKey:@"albumCoverUrl290"];
        self.playsCounts = [aDecoder decodeObjectForKey:@"playsCounts"];
        self.intro = [aDecoder decodeObjectForKey:@"intro"];
        self.albumId = [aDecoder decodeObjectForKey:@"albumId"];
        self.playUrl64 = [aDecoder decodeObjectForKey:@"playUrl64"];
        self.playtimes = [aDecoder decodeObjectForKey:@"playtimes"];
        self.duration = [aDecoder decodeObjectForKey:@"duration"];
        self.coverLarge = [aDecoder decodeObjectForKey:@"coverLarge"];
    }
    return self;
}

@end
