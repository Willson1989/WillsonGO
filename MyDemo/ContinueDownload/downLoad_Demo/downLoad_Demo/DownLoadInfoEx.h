//
//  downLoadInfoEx.h
//  downLoad_Demo
//
//  Created by Willson on 16/4/11.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^progrssHandler) (CGFloat comp, CGFloat total, NSInteger index);
typedef void(^completeHandler) (NSString *filePath, NSInteger index);

@interface DownLoadInfoEx : NSObject

@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) BOOL isPaused;
@property (assign, nonatomic) BOOL isCompleted;
@property (strong, nonatomic) NSProgress *progress;

-(instancetype)initWithURL:(NSURL*)url
           ProgressHandler:(progrssHandler)pHandler
           completeHandler:(completeHandler)cHandler;
-(void)startDownload;
-(void)pauseDownload;
-(void)resumeDownload;

@end
