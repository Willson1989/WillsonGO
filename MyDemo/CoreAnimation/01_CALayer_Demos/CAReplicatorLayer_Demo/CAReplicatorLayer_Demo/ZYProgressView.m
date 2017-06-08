//
//  ZYProgressView.m
//  CAReplicatorLayer_Demo
//
//  Created by Willson on 16/4/22.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ZYProgressView.h"

#define progressH 55

@interface ArrowLayer : CALayer

@end

@implementation ArrowLayer

-(void)drawInContext:(CGContextRef)ctx{
    CGFloat width  = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    CGContextMoveToPoint(ctx, width/4, height/3);
    CGContextAddLineToPoint(ctx, width/2, 2);
    CGContextAddLineToPoint(ctx, width/4*3, height/3);
    CGContextSetLineWidth(ctx, 1.5);
    CGContextStrokePath(ctx);
    
    CGContextMoveToPoint(ctx, width/2, 2);
    CGContextAddLineToPoint(ctx, width/2, height-2);
    CGContextStrokePath(ctx);
    //需要在画完线之后设置颜色，否则无效
    CGContextSetRGBStrokeColor(ctx, 44, 127, 252, 1);
}

- (void)rotateArrowToUp:(BOOL)Up{
    CGFloat num = Up ? 0 : 180;
    self.affineTransform = CGAffineTransformMakeRotation((num * M_PI)/180.0);
    
}

@end

NSString * const KVOScrollViewContentOffsetKey = @"contentOffset";
NSString * const KVOScrollViewContentPanState  = @"state";

static CGFloat prevOffsetY = 0;

@interface ZYProgressView ()
{
    BOOL isGoingDown;
}

@property (strong, nonatomic) ArrowLayer *arrowLayer;
@property (strong, nonatomic) CAReplicatorLayer *indicatorLayer;
@property (copy, nonatomic)   ProgressBlock pBlock;

@end

@implementation ZYProgressView

+(instancetype)progressViewWithBlock:(ProgressBlock)block{
    ZYProgressView *view = [[ZYProgressView alloc]initWithFrame:CGRectMake(0,
                                                                           -progressH,
                                                                           [UIScreen mainScreen].bounds.size.width,
                                                                           progressH)];
    view.pBlock = block;
    return view;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupArrowLayer];
//        [self setupIndicatorLayer];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    NSLog(@"willMoveToSuperview  offsetY : %.2f",self.scrollView.contentOffset.y);
    [self addObserver];
}

-(void)addObserver{
    if (self.scrollView != nil && [self.scrollView isKindOfClass:[UIScrollView class]]) {
        NSKeyValueObservingOptions option = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self.scrollView addObserver:self forKeyPath:KVOScrollViewContentOffsetKey options:option context:nil];
        self.pan = self.scrollView.panGestureRecognizer;
        [self.pan addObserver:self forKeyPath:KVOScrollViewContentPanState options:option context:nil];
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context{
    if (keyPath == KVOScrollViewContentOffsetKey) {
        //不知道为什么offset.y是负数
        CGFloat tY = fabsf(self.scrollView.contentOffset.y);
        CGFloat edge = progressH;
        if(prevOffsetY < edge && tY > edge) {
            NSLog(@"箭头向下");
            isGoingDown = YES;
            [_arrowLayer rotateArrowToUp:NO];
        }
        if(prevOffsetY > edge && tY < edge) {
            NSLog(@"箭头向上");
            isGoingDown = NO;
            [_arrowLayer rotateArrowToUp:YES];
        }
        prevOffsetY = tY;
    }
    if (keyPath == KVOScrollViewContentPanState) {
        if (isGoingDown == YES && self.pan.state == UIGestureRecognizerStateEnded) {
            NSLog(@"松开刷新");
            [self setupIndicatorLayer];

        }
    }
}

-(void)setupArrowLayer{
    if (!_arrowLayer) {
        _arrowLayer = [[ArrowLayer alloc] init];
        CGFloat width = progressH-5;
        _arrowLayer.bounds = CGRectMake(0, 0, width, width);
        _arrowLayer.position = CGPointMake(self.frame.size.width/2, width/2);
        _arrowLayer.backgroundColor = [[UIColor clearColor] CGColor];
        [self.layer addSublayer:_arrowLayer];
        [_arrowLayer setNeedsDisplay];
    }
}

- (void)setupIndicatorLayer{
    if (!_indicatorLayer) {
        _indicatorLayer = [CAReplicatorLayer layer];
        CGFloat width = progressH * 3 / 2;
        _indicatorLayer.bounds = CGRectMake(0, 0, width, width);
        _indicatorLayer.position = CGPointMake(self.frame.size.width/2, progressH/2);
        _indicatorLayer.backgroundColor = [[UIColor whiteColor] CGColor];
        
        //单个方块
        CALayer *dotLayer = [[CALayer alloc]init];
        dotLayer.bounds = CGRectMake(0, 0, 4, 10);
        dotLayer.position = CGPointMake(width/2, 22);
        dotLayer.cornerRadius = 2;
        dotLayer.backgroundColor = [[UIColor lightGrayColor] CGColor];
        [_indicatorLayer addSublayer:dotLayer];
        
        //设置主要参数
        NSInteger dotNum = 15;
        CGFloat   duration = 1.5;
        _indicatorLayer.instanceAlphaOffset = 1/dotNum;
        _indicatorLayer.instanceCount = dotNum;
        _indicatorLayer.instanceTransform = CATransform3DMakeRotation(2*M_PI/dotNum, 0, 0, 1);
        
        dotLayer.opacity = 1.0;
        CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        anim.fromValue = @(1.0);
        anim.toValue   = @(0.2);
        anim.duration = duration;
        anim.autoreverses = NO;
        anim.repeatCount = INFINITY;
        [dotLayer addAnimation:anim forKey:@"dotAnimation"];
        _indicatorLayer.instanceDelay = duration/dotNum;
        
        [self.layer addSublayer:_indicatorLayer];
    }
}

- (void)removeIndicator{
    if (_indicatorLayer) {
        [_indicatorLayer removeFromSuperlayer];
        _indicatorLayer = nil;
    }
}

@end
