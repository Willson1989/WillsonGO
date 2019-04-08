//
//  downloadCell.m
//  downLoad_Demo
//
//  Created by Willson on 16/4/10.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "DownloadCell.h"
#import "DownLoadInfo.h"
#import "DownLoadInfoEx.h"

@interface DownloadCell ()

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UIButton *funcButton;
@property (strong, nonatomic) DownLoadInfo   *downLoadInfo;
@property (strong, nonatomic) DownLoadInfoEx *downLoadInfoEx;

@end

@implementation DownloadCell

//AFNetWorking实现
-(void)setDownLoadInfo:(DownLoadInfo *)downLoadInfo{
    _downLoadInfo = downLoadInfo;
    if (_downLoadInfo.isCompleted) {
        _statusLabel.text = @"已完成";
        _funcButton.hidden = YES;
    } else{
        _funcButton.hidden = NO;
        if (_downLoadInfo.isPaused) {
            _statusLabel.text = @"已暂停";
            [_funcButton setTitle:@"开始" forState:UIControlStateNormal];
        } else{
            _progressView.progress = 1.0
                                   * _downLoadInfo.progress.completedUnitCount
                                   / _downLoadInfo.progress.totalUnitCount;
            
            [_funcButton setTitle:@"暂停" forState:UIControlStateNormal];
            _statusLabel.text = [NSString stringWithFormat:@"%li / %li",
                                 _downLoadInfo.progress.completedUnitCount,
                                 _downLoadInfo.progress.totalUnitCount];
        }
    }
}

//NSURLSession实现
-(void)setDownLoadInfoEx:(DownLoadInfoEx *)downLoadInfoEx{
    _downLoadInfoEx = downLoadInfoEx;
    if (_downLoadInfoEx.isCompleted) {
        _statusLabel.text = @"已完成";
        _funcButton.hidden = YES;
    } else{
        _funcButton.hidden = NO;
        if (_downLoadInfoEx.isPaused) {
            _statusLabel.text = @"已暂停";
            [_funcButton setTitle:@"开始" forState:UIControlStateNormal];
        } else{
            _progressView.progress = 1.0
            * _downLoadInfoEx.progress.completedUnitCount
            / _downLoadInfoEx.progress.totalUnitCount;
            
            [_funcButton setTitle:@"暂停" forState:UIControlStateNormal];
            _statusLabel.text = [NSString stringWithFormat:@"%li / %li",
                                 _downLoadInfoEx.progress.completedUnitCount,
                                 _downLoadInfoEx.progress.totalUnitCount];
        }
    }
}

- (IBAction)funcButtonAction:(id)sender {
    if (_downLoadInfo) {
        if (_downLoadInfo.isPaused) {
            [_downLoadInfo resumeDownload];
            [_funcButton setTitle:@"暂停" forState:UIControlStateNormal];
        } else{
            [_downLoadInfo pauseDownload];
            [_funcButton setTitle:@"开始" forState:UIControlStateNormal];
        }
    }
    
    if (_downLoadInfoEx) {
        if (_downLoadInfoEx.isPaused) {
            [_downLoadInfoEx resumeDownload];
            [_funcButton setTitle:@"暂停" forState:UIControlStateNormal];
        } else{
            [_downLoadInfoEx pauseDownload];
            [_funcButton setTitle:@"开始" forState:UIControlStateNormal];
            _statusLabel.text = @"已暂停";
        }
    }
}

@end
