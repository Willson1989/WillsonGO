//
//  CacheDataHandle.h
//  XinTu
//
//  Created by Bunny on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheDataHandle : NSObject

+ (CacheDataHandle *)shareDataHandle;

-(NSString *)getCachePath;

-(NSString *)getKey:(NSString *)key andObject:(id)object andPath:(NSString *)cachePath;

-(id)setData:(NSString *)filePath;

-(void)removeCacheData:(NSString *)filePath;

-(NSString *)getCacheFileSize;

-(void)clearCache;

@end
