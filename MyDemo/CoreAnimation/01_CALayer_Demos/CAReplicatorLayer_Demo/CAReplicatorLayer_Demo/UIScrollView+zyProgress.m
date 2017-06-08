//
//  UIScrollView+zyProgress.m
//  CAReplicatorLayer_Demo
//
//  Created by Willson on 16/4/25.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "UIScrollView+zyProgress.h"
#import "ZYProgressView.h"
#import <objc/runtime.h>

static const char zy_headerKey = '\0';

@implementation UIScrollView (zyProgress)


-(void)setZy_header:(ZYProgressView *)zy_header{
    if (self.zy_header != zy_header) {
        [self.zy_header removeFromSuperview];
        //self.zy_header = zy_header;
        zy_header.scrollView = self;
        [self insertSubview:zy_header atIndex:0];
        
        objc_setAssociatedObject(self, &zy_headerKey, zy_header,OBJC_ASSOCIATION_ASSIGN);
    }
}

-(ZYProgressView *)zy_header{
    return objc_getAssociatedObject(self, &zy_headerKey);
}

-(CGFloat)top{
    return self.frame.origin.y;
}

-(void)setTop:(CGFloat)top{
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = top;
    self.frame = tempFrame;
}


@end
