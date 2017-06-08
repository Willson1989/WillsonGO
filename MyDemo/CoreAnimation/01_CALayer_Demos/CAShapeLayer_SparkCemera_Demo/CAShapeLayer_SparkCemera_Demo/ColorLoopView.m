//
//  ColorLoopView.m
//  CAShapeLayer_SparkCemera_Demo
//
//  Created by Willson on 16/4/19.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ColorLoopView.h"

@interface ColorLoopView ()
{
    BOOL _isCompleted;
    CGFloat _strokeWidth;
    UIBezierPath   *_circlePath;
    NSMutableArray *_layerArray;
    CAShapeLayer   *_bgLayer;
    CAShapeLayer *_currentLayer;
}


@end


@implementation ColorLoopView

- (instancetype)initWithFrame:(CGRect)frame StrokeWidth:(CGFloat)strokeWidth{
    if (self = [super initWithFrame:frame]) {
        _strokeWidth = strokeWidth;
        _layerArray = [NSMutableArray array];
        _circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
                                                     radius:fminf(frame.size.width, frame.size.height)/2 - 5
                                                 startAngle:0.0
                                                   endAngle:M_PI * 2
                                                  clockwise:NO];
        self.backgroundColor = [UIColor clearColor];
        [self addBackgroundLayer];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isCompleted) {
        [self addLayer];
        [self updateLayerAnimation];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!_isCompleted) {
        [self updateModelOfLayer];
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (_isCompleted == NO && flag) {
        _isCompleted = flag;
    }
}

- (void)addBackgroundLayer{
    _bgLayer = [CAShapeLayer layer];
    _bgLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _bgLayer.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    _bgLayer.fillColor = [[UIColor clearColor] CGColor];
    _bgLayer.path = _circlePath.CGPath;
    _bgLayer.lineWidth = _strokeWidth;
    _bgLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
    [self.layer addSublayer:_bgLayer];
}

- (void)addLayer{
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer = [CAShapeLayer layer];
    layer.bounds = _bgLayer.bounds;
    layer.position = _bgLayer.position;
    layer.fillColor = [[UIColor clearColor] CGColor];
    layer.lineWidth = _strokeWidth;
    layer.strokeEnd = 0.0f;
    layer.path = _circlePath.CGPath;
    layer.strokeColor = [[self randomColor] CGColor];
    
    [self.layer addSublayer:layer];
    [_layerArray addObject:layer];
    _currentLayer = layer;
}


- (void)updateLayerAnimation{
    CGFloat animDuration = 4.0f;
    CGFloat strokeEndFinal = 1.0f;
    CGFloat duration = animDuration * (1 - [[_layerArray firstObject] strokeEnd]);
    for (CAShapeLayer *layer in _layerArray) {
        
        CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        endAnimation.duration = duration;
        endAnimation.autoreverses = NO;
        endAnimation.repeatCount = 0;
        endAnimation.fromValue = @(layer.strokeEnd);
        endAnimation.toValue = @(strokeEndFinal);
        
        CGFloat prevStrokeEnd = layer.strokeEnd;
        layer.strokeEnd = strokeEndFinal;
        strokeEndFinal = strokeEndFinal - (prevStrokeEnd - layer.strokeStart);
        [layer addAnimation:endAnimation forKey:@"strokeEnd_Animation"];
        
        if (_currentLayer != layer) {
            CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
            startAnimation.duration = duration;
            startAnimation.autoreverses = NO;
            startAnimation.repeatCount = 0;
            startAnimation.fromValue = @(layer.strokeStart);
            startAnimation.toValue = @(strokeEndFinal);
            
            layer.strokeStart = strokeEndFinal;
            [layer addAnimation:startAnimation forKey:@"strokeStart_Animation"];
        }
    }
    CABasicAnimation *bgAnimation = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    bgAnimation.duration = duration;
    bgAnimation.autoreverses = NO;
    bgAnimation.delegate = self;
    bgAnimation.repeatCount = 0;
    bgAnimation.fromValue = @(_bgLayer.strokeStart);
    bgAnimation.toValue = @(1.0f);
    
    _bgLayer.strokeStart = 1.0;
    [_bgLayer addAnimation:bgAnimation forKey:@"bgAnimation"];
}

- (void)updateModelOfLayer{
    for (CAShapeLayer *layer in _layerArray) {
        layer.strokeStart = [layer.presentationLayer strokeStart];
        layer.strokeEnd   = [layer.presentationLayer strokeEnd];
        [layer removeAllAnimations];
    }
    _bgLayer.strokeStart = [_bgLayer.presentationLayer strokeStart];
    [_bgLayer removeAllAnimations];
}

- (UIColor *)randomColor{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.f];
}

- (void)resetLayers{
    for (CAShapeLayer *layer in _layerArray) {
        [layer removeFromSuperlayer];
    }
    [_layerArray removeAllObjects];
    _isCompleted = NO;
    [self addBackgroundLayer];
}


@end
