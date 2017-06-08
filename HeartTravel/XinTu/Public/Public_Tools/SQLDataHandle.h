//
//  SQLDataHandle.h
//  XinTu
//
//  Created by Bunny on 15/6/30.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface SQLDataHandle : NSObject

+ (SQLDataHandle *)shareDataHandle;

-(void)openSqlite;

-(void)creatFeatureDollectList;

-(NSMutableDictionary *)selectFeatureDollectList:(NSString *)title;

-(void)insertFeatureDollectList:(NSString *)title andId:(NSString *)guideID;

-(void)deletFeatureDollectList:(NSString *)title;

-(NSMutableDictionary *)selectAllFeatureDollectList;


-(void)creatHotDollectList;

-(NSMutableDictionary *)selectHotDollectList:(NSString *)title;

-(NSMutableDictionary *)selectAllHotDollectList;

-(void)insertHotDollectList:(NSString *)title andId:(NSString *)NextId;

-(void)deletHotDollectList:(NSString *)title;

@end
