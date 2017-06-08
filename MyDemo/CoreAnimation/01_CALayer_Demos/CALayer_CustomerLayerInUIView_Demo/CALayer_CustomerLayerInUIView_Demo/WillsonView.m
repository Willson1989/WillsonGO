//
//  WillsonView.m
//  CALayer_CustomerLayerInUIView_Demo
//
//  Created by Willson on 16/4/12.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "WillsonView.h"
#import "WillsonLayer.h"

@implementation WillsonView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        WillsonLayer * layer = [[WillsonLayer alloc]init];
        layer.bounds = CGRectMake(0, 0, 185, 185);
        layer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        layer.backgroundColor = [[UIColor purpleColor] CGColor];
//        [layer setValue:@40 forKey:@"transform.scale"];
//        layer.transform = CATransform3DMakeScale(2, 2, 2);
        [self.layer addSublayer:layer];
        [layer setNeedsDisplay];
        NSLog(@"layer : %@",layer);
        NSLog(@"self layer : %@",self.layer);
    }
    return self;
}

#pragma 即使不写下面这两个代理方法也还是可以正常显示的
- (void)drawRect:(CGRect)rect {
    NSLog(@"2-drawRect:");
    NSLog(@"CGContext:%@",UIGraphicsGetCurrentContext());//得到的当前图形上下文正是drawLayer中传递的
    [super drawRect:rect];
    
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    NSLog(@"layer : %@",layer);
    NSLog(@"1-drawLayer:inContext:");
    NSLog(@"CGContext:%@",ctx);
    [super drawLayer:layer inContext:ctx];
}

@end
