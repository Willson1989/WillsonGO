//
//  SQLDataHandle.m
//  XinTu
//
//  Created by Bunny on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "SQLDataHandle.h"

@implementation SQLDataHandle

+ (SQLDataHandle *)shareDataHandle{
    
    static SQLDataHandle *data = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        data = [[SQLDataHandle alloc] init];
    });
    return data;
}

#pragma mark 创建指向数据库的指针
static sqlite3 *db = nil;
#pragma mark 打开数据库
-(void)openSqlite{
    if (db != nil) {
        return;
    }
    //获取沙盒的document路径
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [array lastObject];
    //创建数据库路径
    NSString *SQLPath = [documentPath stringByAppendingPathComponent:@"dataBase.sqlite"];
    
    int result = sqlite3_open(SQLPath.UTF8String, &db);
//    if (result == SQLITE_OK) {
//        NSLog(@"数据打开成功");
//        NSLog(@"数据库路径 == %@", SQLPath);
//    }else{
//        NSLog(@"数据库打开失败");
//    }
    
}

#pragma mark 创建当地特色收藏表
-(void)creatFeatureDollectList{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS FeatureDollectList (number INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, guideID TEXT)";
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
//    if (result == SQLITE_OK) {
//        NSLog(@"当地特色藏表创建成功");
//    }else{
//        NSLog(@"当地特色收藏表创建失败");
//    }
}

#pragma mark 读取当地特色收藏表
-(NSMutableDictionary *)selectFeatureDollectList:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM FeatureDollectList WHERE title = '%@'", title];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *guideID = sqlite3_column_text(stmt, 2);
            
            NSString *titleStr= [NSString stringWithUTF8String:(const char *) title];
            NSString *guideIDStr = [NSString stringWithUTF8String:(const char *) guideID];
            [dic setObject:guideIDStr forKey:titleStr];
        }
//        NSLog(@"读取当地特色收藏表成功");
        return dic;
    }else{
//        NSLog(@"读取当地特色收藏表失败");
        return dic;
    }
}
#pragma mark 读取当地特色收藏表(全部)
-(NSMutableDictionary *)selectAllFeatureDollectList{
    NSString *sql = @"SELECT *FROM FeatureDollectList";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *guideID = sqlite3_column_text(stmt, 2);
            
            NSString *titleStr= [NSString stringWithUTF8String:(const char *) title];
            NSString *guideIDStr = [NSString stringWithUTF8String:(const char *) guideID];
            [dic setObject:guideIDStr forKey:titleStr];
        }
//        NSLog(@"读取当地特色收藏表成功");
        return dic;
    }else{
//        NSLog(@"读取当地特色收藏表失败");
        return dic;
    }
}

#pragma mark 插入数据到当地特色收藏表
-(void)insertFeatureDollectList:(NSString *)title andId:(NSString *)guideID{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO FeatureDollectList (title, guideID) VALUES('%@', '%@')", title, guideID];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"插入数据到当地特色收藏表成功");
    }else{
//        NSLog(@"插入数据到当地特色收藏表失败");
    }
}

#pragma mark 从当地特色收藏表中删除数据
-(void)deletFeatureDollectList:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM FeatureDollectList WHERE title = '%@'", title];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"删除当地特色收藏数据成功");
    }else {
//        NSLog(@"删除当地特色收藏数据失败");
    }
}



#pragma mark 创建热门游记收藏表
-(void)creatHotDollectList{
    NSString *sql = @"CREATE TABLE IF NOT EXISTS HotDollectList (number INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, NextId TEXT)";
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"热门游记收藏表创建成功");
    }else{
//        NSLog(@"热门游记收藏表创建失败");
    }
}

#pragma mark 读取热门游记收藏表
-(NSMutableDictionary *)selectHotDollectList:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"SELECT *FROM HotDollectList WHERE title = '%@'", title];
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *NextId = sqlite3_column_text(stmt, 2);
            
            NSString *titleStr= [NSString stringWithUTF8String:(const char *) title];
            NSString *NextIdStr = [NSString stringWithUTF8String:(const char *) NextId];
            [dic setObject:NextIdStr forKey:titleStr];
        }
//        NSLog(@"读取热门游记收藏表成功");
        return dic;
    }else{
//        NSLog(@"读取热门游记收藏表失败");
        return dic;
    }
}
#pragma mark 读取热门收藏表(全部)
-(NSMutableDictionary *)selectAllHotDollectList{
    NSString *sql = @"SELECT *FROM HotDollectList";
    sqlite3_stmt *stmt = nil;
    int result = sqlite3_prepare_v2(db, sql.UTF8String, -1, &stmt, nil);
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if (result == SQLITE_OK) {
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            const unsigned char *title = sqlite3_column_text(stmt, 1);
            const unsigned char *NextId = sqlite3_column_text(stmt, 2);
            
            NSString *titleStr= [NSString stringWithUTF8String:(const char *) title];
            NSString *NextIdStr = [NSString stringWithUTF8String:(const char *) NextId];
            [dic setObject:NextIdStr forKey:titleStr];
        }
//        NSLog(@"读取热门游记收藏表成功");
        return dic;
    }else{
//        NSLog(@"读取热门游记收藏表失败");
        return dic;
    }
}

#pragma mark 插入数据到热门游记收藏表
-(void)insertHotDollectList:(NSString *)title andId:(NSString *)NextId{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO HotDollectList (title, NextId) VALUES('%@', '%@')", title, NextId];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);

}

#pragma mark 从热门游记收藏表中删除数据
-(void)deletHotDollectList:(NSString *)title{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM HotDollectList WHERE title = '%@'", title];
    int result = sqlite3_exec(db, sql.UTF8String, NULL, NULL, nil);
    if (result == SQLITE_OK) {
//        NSLog(@"删除热门游记收藏数据成功");
    }else {
//        NSLog(@"删除热门游记收藏数据失败");
    }
}

@end
