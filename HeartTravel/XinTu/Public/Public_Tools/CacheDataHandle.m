//
//  CacheDataHandle.m
//  XinTu
//
//  Created by Bunny on 15/7/3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CacheDataHandle.h"

@implementation CacheDataHandle

+ (CacheDataHandle *)shareDataHandle{
    
    static CacheDataHandle *data = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        data = [[CacheDataHandle alloc] init];
    });
    return data;
}

#pragma mark 获取文件夹路径(返回值: 文件夹路径)
-(NSString *)getCachePath{
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取本地沙盒中cache文件夹
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //获取cache文件夹的路径
    NSString *cachesDirectory = [array objectAtIndex:0];
    //创建自定义文件夹的路径
    NSString *cachePath = [cachesDirectory stringByAppendingPathComponent:@"MyAppCache"];
    //在指定路径下创建自定义文件夹
    BOOL result = [fileManager createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    
    return cachePath;
    
}
#pragma mark 数据归档(返回值: 文件路径)
-(NSString *)getKey:(NSString *)key andObject:(id)object andPath:(NSString *)cachePath{
    
    NSString *fileStr = [NSString stringWithFormat:@"%@.av", key];
    
    NSString *filePath = [cachePath stringByAppendingPathComponent:fileStr]; // 创建文件路径
    
    BOOL result = [NSKeyedArchiver archiveRootObject:object toFile:filePath]; //归档,即创建文件,并将内容写入文件
    
    return filePath;
    
}

#pragma mark 数据反归档,取出文件中的数据(返回值:缓存的数据)
-(id)setData:(NSString *)filePath{
    
    return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath]; //反归档
    
}
#pragma mark 删除缓存数据
-(void)removeCacheData:(NSString *)filePath{
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断文件是否存在
    if ([fileManager fileExistsAtPath:filePath]) {
        [fileManager removeItemAtPath:filePath error:nil]; //删除文件
    }
}

#pragma mark 获取缓存文件大小
-(NSString *)getCacheFileSize{
 
    CGFloat folderSize = 0.0f;
    
    folderSize += [[CacheDataHandle shareDataHandle] fileSizeAtPath];
    
    //SDWebImage框架自身计算缓存的实现
    folderSize += [[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
    
    NSString *size = [NSString stringWithFormat:@"%.1f", folderSize];
    
    return size;
    
}
#pragma mark 计算单个文件大小
-(float)fileSizeAtPath{
    
    float totalSize = 0.0f;
    
    //创建一个文件管理器对象
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //获取本地沙盒中cache文件夹
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    //获取cache文件夹的路径
    NSString *cachesDirectory = [array objectAtIndex:0];
    //创建自定义文件夹的路径
    NSString *Path = [cachesDirectory stringByAppendingPathComponent:@"MyAppCache"];
    
    NSString *cachePath1 = [NSString stringWithFormat:@"%@/musicDataArray.av",Path];
    if([fileManager fileExistsAtPath:cachePath1]){
        float size1=[fileManager attributesOfItemAtPath:cachePath1 error:nil].fileSize;
        totalSize +=size1/1024.0/1024.0;
    }
    
    NSString *cachePath2 = [NSString stringWithFormat:@"%@/videoDataArray.av",Path];
    
    if([fileManager fileExistsAtPath:cachePath2]){
        float size2=[fileManager attributesOfItemAtPath:cachePath2 error:nil].fileSize;
        totalSize += size2/1024.0/1024.0;
    }
    
    NSString *cachePath3 = [NSString stringWithFormat:@"%@/HotTravelListDataArray.av",Path];
    NSString *cachePath4 = [NSString stringWithFormat:@"%@/HotTravelTitleDataArray.av",Path];
    if([fileManager fileExistsAtPath:cachePath3]){
        float size3=[fileManager attributesOfItemAtPath:cachePath4 error:nil].fileSize;
        totalSize += size3/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath4]){
        float size4 = [fileManager attributesOfItemAtPath:cachePath4 error:nil].fileSize;
        totalSize += size4/1024.0/1024.0;
    }
    
    NSString *cachePath5 = [NSString stringWithFormat:@"%@/北美洲hotCountry.av",Path];
    NSString *cachePath6 = [NSString stringWithFormat:@"%@/北美洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath5]){
        float size5 = [fileManager attributesOfItemAtPath:cachePath5 error:nil].fileSize;
        totalSize += size5/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath6]){
        float size6 = [fileManager attributesOfItemAtPath:cachePath6 error:nil].fileSize;
        totalSize += size6/1024.0/1024.0;
    }
    
    NSString *cachePath7 = [NSString stringWithFormat:@"%@/大洋洲hotCountry.av",Path];
    NSString *cachePath8 = [NSString stringWithFormat:@"%@/大洋洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath7]){
        float size7 = [fileManager attributesOfItemAtPath:cachePath7 error:nil].fileSize;
        totalSize += size7/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath8]){
        float size8 = [fileManager attributesOfItemAtPath:cachePath8 error:nil].fileSize;
        totalSize += size8/1024.0/1024.0;
    }
    
    NSString *cachePath9 = [NSString stringWithFormat:@"%@/非洲hotCountry.av",Path];
    NSString *cachePath10 = [NSString stringWithFormat:@"%@/非洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath9]){
        float size9 = [fileManager attributesOfItemAtPath:cachePath9 error:nil].fileSize;
        totalSize += size9/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath10]){
        float size10 = [fileManager attributesOfItemAtPath:cachePath10 error:nil].fileSize;
        totalSize += size10/1024.0/1024.0;
    }

    NSString *cachePath11 = [NSString stringWithFormat:@"%@/南极洲hotCountry.av",Path];
    NSString *cachePath12 = [NSString stringWithFormat:@"%@/南极洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath11]){
        float size11 = [fileManager attributesOfItemAtPath:cachePath11 error:nil].fileSize;
        totalSize += size11/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath12]){
        float size12 = [fileManager attributesOfItemAtPath:cachePath12 error:nil].fileSize;
        totalSize += size12/1024.0/1024.0;
    }
    
    NSString *cachePath13 = [NSString stringWithFormat:@"%@/南美洲hotCountry.av",Path];
    NSString *cachePath14 = [NSString stringWithFormat:@"%@/南美洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath13]){
        float size13 = [fileManager attributesOfItemAtPath:cachePath13 error:nil].fileSize;
        totalSize += size13/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath14]){
        float size14 = [fileManager attributesOfItemAtPath:cachePath14 error:nil].fileSize;
        totalSize += size14/1024.0/1024.0;
    }

    NSString *cachePath15 = [NSString stringWithFormat:@"%@/欧洲hotCountry.av",Path];
    NSString *cachePath16 = [NSString stringWithFormat:@"%@/欧洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath15]){
        float size15 = [fileManager attributesOfItemAtPath:cachePath15 error:nil].fileSize;
        totalSize += size15/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath16]){
        float size16 = [fileManager attributesOfItemAtPath:cachePath16 error:nil].fileSize;
        totalSize += size16/1024.0/1024.0;
    }

    NSString *cachePath17 = [NSString stringWithFormat:@"%@/亚洲hotCountry.av",Path];
    NSString *cachePath18 = [NSString stringWithFormat:@"%@/亚洲otherCountry.av",Path];
    if([fileManager fileExistsAtPath:cachePath17]){
        float size17 = [fileManager attributesOfItemAtPath:cachePath17 error:nil].fileSize;
        totalSize += size17/1024.0/1024.0;
    }
    if([fileManager fileExistsAtPath:cachePath18]){
        float size18 = [fileManager attributesOfItemAtPath:cachePath18 error:nil].fileSize;
        totalSize += size18/1024.0/1024.0;
    }
    
    return totalSize;
}
#pragma mark 清空缓存
-(void)clearCache{
    NSString *extension = @"av";
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSArray *contents = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:NULL];
    NSEnumerator *e = [contents objectEnumerator];
    NSString *filename;
    while ((filename = [e nextObject])) {
        
        if ([[filename pathExtension] isEqualToString:extension]) {
            
            [fileManager removeItemAtPath:[documentsDirectory stringByAppendingPathComponent:filename] error:NULL];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
//    //创建一个文件管理器对象
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //判断文件是否存在
//    if ([fileManager fileExistsAtPath:filePath]) {
//        [fileManager removeItemAtPath:filePath error:nil]; //删除文件
//        NSLog(@"删除缓存文件成功");
//    }
    
}














@end
