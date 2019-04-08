//
//  downLoadInfoEx.m
//  downLoad_Demo
//
//  Created by Willson on 16/4/11.
//  Copyright © 2016年 郑毅. All rights reserved.
//
//以系统代码（NSURLSession）方式实现断点续传下载

#import "DownLoadInfoEx.h"

@interface DownLoadInfoEx ()<NSURLSessionDownloadDelegate>

{
    progrssHandler  _pHandler;
    completeHandler _cHandler;
    NSURL  *_downLoadUrl;
    NSData *_resumeData;
    NSURLRequest *_request;
    NSURLSession *_session;
    NSURLSessionDownloadTask *_dlTask;
}

@end

@implementation DownLoadInfoEx

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
        _progress = [[NSProgress alloc]initWithParent:nil userInfo:nil];
    }
    return self;
}

-(void)startDownload{
    
    [self createDownloadSession];
    [self resumeDownload];
}

- (void)createDownloadSession{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
    _session.sessionDescription = @"sessionDownLoadWillson";
    _request = [NSURLRequest requestWithURL:_downLoadUrl];
}

-(void)pauseDownload{
    [_dlTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        _resumeData = resumeData;
        _dlTask = nil;
    }];
    _isPaused = YES;
}

-(void)resumeDownload{
    if (!_resumeData) {
        _dlTask = [_session downloadTaskWithRequest:_request];
        [_dlTask resume];
    } else {
        _dlTask = [_session downloadTaskWithResumeData:_resumeData];
        [_dlTask resume];
    }
    _isPaused = NO;
}

#pragma mark - NSURLSessionDownloadDelegate
//下载中，数据传输时调用该方法
-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
     didWriteData:(int64_t)bytesWritten
totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    _progress.completedUnitCount = totalBytesWritten;
    _progress.totalUnitCount = totalBytesExpectedToWrite;
    dispatch_async(dispatch_get_main_queue(), ^{
        _pHandler(bytesWritten, totalBytesExpectedToWrite, _index);
    });
}

//下载完成
-(void)URLSession:(NSURLSession *)session
     downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    _isCompleted = YES;
    dispatch_async(dispatch_get_main_queue(), ^{
        _cHandler(location.absoluteString, _index);
    });
}

//暂停后恢复下载
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
}
@end
