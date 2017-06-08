//
//  ViewController.m
//  CAAnimationGroup_001
//
//  Created by Willson on 16/4/14.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer *_layer;
    CABasicAnimation    *_basicAnimation;
    CAKeyframeAnimation *_keyframeAnimation;
    CAAnimationGroup    *_animationGroup;
}

@end

#define lWidth 100
#define animGroup_Duration 5.0
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _layer = [[CALayer alloc]init];
    _layer.backgroundColor = [[UIColor blueColor] CGColor];
    _layer.bounds = CGRectMake(0, 0, lWidth, lWidth);
    _layer.position = CGPointMake(lWidth, lWidth);
    [self.view.layer addSublayer:_layer];
    _animationGroup = [self AnimationGroup];
    //将动画组添加到图层中
    [_layer addAnimation:_animationGroup forKey:@"Animaiton_Group"];
}

- (CAAnimationGroup*)AnimationGroup{
    //1.创建动画组
    CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
    
    //2.将动画对象添加到动画组中
    if (_basicAnimation == nil) {
        _basicAnimation = [self BasicAnimation];
    }
    if (_keyframeAnimation == nil) {
        _keyframeAnimation = [self KeyframeAnimation];
    }
    animationGroup.animations = @[_basicAnimation, _keyframeAnimation];
    animationGroup.delegate = self;
    animationGroup.duration = animGroup_Duration;
    animationGroup.beginTime = CACurrentMediaTime() + 2;
    return animationGroup;
}

//创建旋转的 基础动画
- (CABasicAnimation*)BasicAnimation{
    CABasicAnimation * basicAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    basicAnimation.fromValue = @0;
    basicAnimation.toValue = @(M_PI * 2);
    basicAnimation.duration = 2;
    basicAnimation.autoreverses = NO;
    basicAnimation.repeatCount = HUGE_VALF;
    basicAnimation.removedOnCompletion = NO;
    [basicAnimation setValue:basicAnimation.toValue forKey:@"rotation_toValue"];
    return basicAnimation;
}

//创建位移的关键帧动画
- (CAKeyframeAnimation*)KeyframeAnimation{
    CAKeyframeAnimation * keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(100, 50)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(100, 150)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(150, 250)];
    NSValue *key5 = [NSValue valueWithCGPoint:CGPointMake(250, 250)];
    [keyframeAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(250, 250)] forKey:@"end_point"];
    keyframeAnimation.values = @[key1, key2, key3, key4, key5];
    //这里要不就不设置动画时长，要不就将动画时长设置为动画组的时长。
    //keyframeAnimation.duration = animGroup_Duration;
    keyframeAnimation.removedOnCompletion = NO;
    keyframeAnimation.autoreverses = NO;
    return keyframeAnimation;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    CGPoint endP = [[_keyframeAnimation valueForKey:@"end_point"] CGPointValue];
    CGFloat rEndValue = [[_basicAnimation valueForKey:@"rotation_toValue"] floatValue];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _layer.position = endP;
    _layer.transform = CATransform3DMakeRotation(rEndValue, 0, 0, 1);
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
