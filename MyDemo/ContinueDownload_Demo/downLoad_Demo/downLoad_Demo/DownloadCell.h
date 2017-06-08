//
//  downloadCell.h
//  downLoad_Demo
//
//  Created by Willson on 16/4/10.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DownLoadInfo;
@class DownLoadInfoEx;

@interface DownloadCell : UITableViewCell

-(void)setDownLoadInfo:(DownLoadInfo *)downLoadInfo;
-(void)setDownLoadInfoEx:(DownLoadInfoEx *)downLoadInfoEx;

@end
