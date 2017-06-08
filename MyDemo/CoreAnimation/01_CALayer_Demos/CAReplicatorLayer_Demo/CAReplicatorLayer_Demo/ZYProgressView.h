//
//  ZYProgressView.h
//  CAReplicatorLayer_Demo
//
//  Created by Willson on 16/4/22.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ProgressBlock)();

@interface ZYProgressView : UIView
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPanGestureRecognizer *pan;

+(instancetype)progressViewWithBlock:(ProgressBlock)block;


@end
