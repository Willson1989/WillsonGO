//
//  downLoadInfo.m
//  downLoad_Demo
//
//  Created by Willson on 16/4/10.
//  Copyright © 2016年 郑毅. All rights reserved.
//
//  以AFNetWorking来实现断线续传下载

#import "downLoadInfo.h"
#import "AFNetworking.h"

@interface DownLoadInfo ()
{
    progrssHandler  _pHandler;
    completeHandler _cHandler;
    NSURLRequest *_request;
    NSURLSessionDownloadTask *_dlTask;
    AFURLSessionManager *_manager;
    NSURL  *_downLoadUrl;
    NSData *_resumeData;
}

@end

@implementation DownLoadInfo

-(instancetype)initWithURL:(NSURL*)url
           ProgressHandler:(progrssHandler)pHandler
           completeHandler:(completeHandler)cHandler{
    self = [super init];
    if (self) {
        _downLoadUrl = url;
        _isPaused    = YES;
        _isCompleted = NO;
        _pHandler = pHandler;
        _cHandler = cHandler;
    }
    return self;
}

-(void)startDownload{
    [self createDownloadSession];
    [self resumeDownload];
}

- (void)createDownloadSession{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _request = [NSURLRequest requestWithURL:_downLoadUrl];
    _manager = [[AFURLSessionManager alloc]initWithSessionConfiguration:configuration];
}

-(void)pauseDownload{
    //不适用suspend方法是因为，暂停之后还是还是会继续下载，
    //导致画面显示内容和实际下载的数据内容不一致
    //[_dlTask suspend];
    [_dlTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _resumeData = resumeData;
        _dlTask = nil;
    }];
    _isPaused = YES;
}

-(void)resumeDownload{
    typeof(self)wself = self;
    if (_resumeData == nil) {
        //如果可恢复的下载任务的数据为空，说明是第一次开启下载，
        //使用request开初始化下载任务
        _dlTask = [_manager downloadTaskWithRequest:_request
          progress:^(NSProgress * _Nonnull downloadProgress) {
            wself.progress = downloadProgress;
            //回到主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                _pHandler(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount,_index);
            });
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath,
                                        NSURLResponse * _Nonnull response) {
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString * temppath = [NSString stringWithFormat:@"%li%@",
                                   wself.index,response.suggestedFilename];
            NSString *path = [cachePath stringByAppendingPathComponent:temppath];
            NSLog(@"path ： %@",path);
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response,
                              NSURL * _Nullable filePath,
                              NSError * _Nullable error) {
            if (_isPaused == NO) {
                _isCompleted = YES;
            } else{
                _isCompleted = NO;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                _cHandler(filePath.absoluteString, _index);
            });
        }];
        
    } else{
        //如果可恢复的下载任务的数据不为空，说明是暂停之后恢复下载，
        //使用上次已经下载的数据(resumeData)来恢复下载任务
        _dlTask = [_manager downloadTaskWithResumeData:_resumeData
          progress:^(NSProgress * _Nonnull downloadProgress) {
            wself.progress = downloadProgress;
            dispatch_async(dispatch_get_main_queue(), ^{
                _pHandler(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount,_index);
            });
            
        } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath,
                                        NSURLResponse * _Nonnull response) {
            NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
            NSString * temppath = [NSString stringWithFormat:@"%li%@",wself.index,response.suggestedFilename];
            NSString *path = [cachePath stringByAppendingPathComponent:temppath];
            NSLog(@"path ： %@",path);
            return [NSURL fileURLWithPath:path];
            
        } completionHandler:^(NSURLResponse * _Nonnull response,
                              NSURL * _Nullable filePath,
                              NSError * _Nullable error) {
            if (_isPaused == NO) {
                _isCompleted = YES;
            } else{
                _isCompleted = NO;
            }
            //回到主线程更新UI
            dispatch_async(dispatch_get_main_queue(), ^{
                _cHandler(filePath.absoluteString, _index);
            });
        }];
    }
    [_dlTask resume];
    _isPaused = NO;
}


@end
