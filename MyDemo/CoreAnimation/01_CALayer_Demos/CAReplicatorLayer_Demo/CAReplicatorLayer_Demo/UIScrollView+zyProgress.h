//
//  UIScrollView+zyProgress.h
//  CAReplicatorLayer_Demo
//
//  Created by Willson on 16/4/25.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZYProgressView;
@interface UIScrollView (zyProgress)

@property (strong, nonatomic) ZYProgressView *zy_header;

@property (nonatomic) CGFloat top;

@end
