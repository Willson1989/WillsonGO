//
//  MultipleProgressView.m
//  CAShapeLayer_Demo
//
//  Created by Willson on 16/4/18.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "MultipleProgressView.h"

#define kLineWidth  20

@interface MultipleProgressView ()

@property (strong, nonatomic) CAShapeLayer *redLayer;
@property (strong, nonatomic) CAShapeLayer *blueLayer;
@property (strong, nonatomic) CAShapeLayer *yellowLayer;

@end

@implementation MultipleProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self.layer addSublayer:self.redLayer];
        [self.layer addSublayer:self.yellowLayer];
        [self.layer addSublayer:self.blueLayer];
    }
    return self;
}

- (void)setProgressWithRedValue: (CGFloat)rValue
                    YellowValue: (CGFloat)yValue
                      BlueValue: (CGFloat)bValue{
    if (rValue >= 100) {
        rValue = 100;
    }
    if (yValue >= 100) {
        yValue = 100;
    }
    if (bValue >= 100) {
        bValue = 100;
    }

    [self setProgressWithValue:rValue/100 ForLayer:_redLayer];
    [self setProgressWithValue:yValue/100 ForLayer:_yellowLayer];
    [self setProgressWithValue:bValue/100 ForLayer:_blueLayer];
}

- (void)setProgressWithValue:(CGFloat)value ForLayer:(CAShapeLayer*)layer{
    layer.speed = 0.3;
    
    //设置CAShapeLayer 路径的起点（画线的起点）
    layer.strokeStart = 0.0;
    
    //设置CAShapeLayer 路径的终点（画线的的终点）
    layer.strokeEnd = value;
}

- (CAShapeLayer *)redLayer{
    if (_redLayer == nil) {
        _redLayer = [CAShapeLayer layer];
        _redLayer.bounds = CGRectMake(0, 0,
                                      self.frame.size.width-kLineWidth*4,
                                      self.frame.size.width-kLineWidth*4);
        _redLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        //设置填充色为透明
        _redLayer.fillColor = [[UIColor clearColor] CGColor];
        
        //设置线条的宽度和颜色
        _redLayer.lineWidth = kLineWidth;
        _redLayer.strokeColor = [[UIColor redColor] CGColor];
        _redLayer.lineCap = kCALineCapRound;
        
        //创建圆形贝塞尔曲线
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_redLayer.bounds];
        
        //赋值CAShapeLayer的路径
        _redLayer.path = path.CGPath;
        
        //起点 和 终点
        _redLayer.strokeStart = 0.0;
        _redLayer.strokeEnd   = 0.0;
        _redLayer.transform = CATransform3DMakeRotation(M_PI/2*3, 0, 0, 1);
        
        [self createPrgressBgLayerWithRadius:_redLayer.bounds.size.width/2];
    }
    return _redLayer;
}

- (CAShapeLayer *)yellowLayer{
    if (_yellowLayer == nil) {
        _yellowLayer = [CAShapeLayer layer];
        _yellowLayer.bounds = CGRectMake(0, 0,
                                       self.frame.size.width-kLineWidth*2,
                                       self.frame.size.width-kLineWidth*2);
        _yellowLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        //设置填充色为透明
        _yellowLayer.fillColor = [[UIColor clearColor] CGColor];
        
        //设置线条的宽度和颜色
        _yellowLayer.lineWidth = kLineWidth;
        _yellowLayer.strokeColor = [[UIColor yellowColor] CGColor];
        _yellowLayer.lineCap = kCALineCapRound;
        
        //创建圆形贝塞尔曲线
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_yellowLayer.bounds];
        
        //赋值CAShapeLayer的路径
        _yellowLayer.path = path.CGPath;
        
        //起点 和 终点
        _yellowLayer.strokeStart = 0.0;
        _yellowLayer.strokeEnd   = 0.0;
        _yellowLayer.transform = CATransform3DMakeRotation(M_PI/2*3, 0, 0, 1);
        [self createPrgressBgLayerWithRadius:_yellowLayer.bounds.size.width/2];
        
    }
    return _yellowLayer;
}

- (CAShapeLayer *)blueLayer{
    if (_blueLayer == nil) {
        _blueLayer = [CAShapeLayer layer];
        _blueLayer.bounds = CGRectMake(0, 0,
                                      self.frame.size.width,
                                      self.frame.size.width);
        _blueLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        //设置填充色为透明
        _blueLayer.fillColor = [[UIColor clearColor] CGColor];
        
        //设置线条的宽度和颜色
        _blueLayer.lineWidth = kLineWidth;
        _blueLayer.strokeColor = [[UIColor blueColor] CGColor];
        _blueLayer.lineCap = kCALineCapRound;
        
        //创建圆形贝塞尔曲线
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:_blueLayer.bounds];
        
        //赋值CAShapeLayer的路径
        _blueLayer.path = path.CGPath;
        
        //起点 和 终点
        _blueLayer.strokeStart = 0.0;
        _blueLayer.strokeEnd   = 0.0;
        _blueLayer.transform = CATransform3DMakeRotation(M_PI/2*3, 0, 0, 1);
        [self createPrgressBgLayerWithRadius:_blueLayer.bounds.size.width/2];
        
    }
    return _blueLayer;
}

//每条进度条的底色条
- (void)createPrgressBgLayerWithRadius:(CGFloat)radius{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.bounds   = CGRectMake(0, 0, radius*2, radius*2);
    layer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.lineWidth = kLineWidth;
    layer.strokeColor = [[UIColor grayColor] CGColor];
    layer.opacity = 0.8;
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:layer.bounds];
    
    layer.path = path.CGPath;
    layer.strokeEnd = 1.0;
    layer.strokeStart = 0.0;
    [self.layer addSublayer:layer];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
