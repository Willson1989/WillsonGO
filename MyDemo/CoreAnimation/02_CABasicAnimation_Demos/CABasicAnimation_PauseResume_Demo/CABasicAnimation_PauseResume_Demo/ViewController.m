//
//  ViewController.m
//  CABasicAnimation_PauseResume_Demo
//
//  Created by Willson on 16/4/13.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer *_layer;
    CABasicAnimation *_tAnimation;
}

@end

#define lWidth 100
#define kAnimation_Translation @"wAnimation_translation"
#define kAnimation_Rotation    @"wAnimation_rotation"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _layer = [[CALayer alloc]init];
    _layer.backgroundColor = [[UIColor grayColor] CGColor];
    _layer.bounds = CGRectMake(0, 0, lWidth, lWidth);
    _layer.position = CGPointMake(lWidth, lWidth);
    [self.view.layer addSublayer:_layer];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchP = [touch locationInView:self.view];
    
   
    if (_tAnimation) {
        if (_layer.speed == 0.0) {
            //暂停状态，恢复动画
            NSLog(@"resume");
            [self resumeAnimation];
            
        } else{
            //运动中，暂停动画
            NSLog(@"pause");
            [self pauseAnimation];
        }
        
    } else{
        NSLog(@"start");
        [self translationAnimation:touchP];
        [self rotationAnimation];
    }
}

- (void)translationAnimation:(CGPoint)touchPoint{
    
    _tAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    _tAnimation.duration = 1;
    _tAnimation.delegate = self;
    _tAnimation.removedOnCompletion = NO;
    [_tAnimation setValue:[NSValue valueWithCGPoint:touchPoint] forKey:@"tAnimation_touchPoint"];
    _tAnimation.fromValue = [NSValue valueWithCGPoint:_layer.position];
    _tAnimation.toValue = [NSValue valueWithCGPoint:touchPoint];
    [_layer addAnimation:_tAnimation forKey:kAnimation_Translation];
}

- (void)rotationAnimation{
    CABasicAnimation *rAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rAnimation.duration = 3;
    rAnimation.fromValue = @0;
    rAnimation.toValue = @(M_PI*2);
    rAnimation.repeatCount = HUGE_VALF;
    rAnimation.removedOnCompletion = NO;
    [_layer addAnimation:rAnimation forKey:kAnimation_Rotation];
}

//让图层停止旋转
- (void)pauseAnimation{
    //取得指定图层动画的当前的媒体时间，后面参数用于指定子图层，这里不需要
    CFTimeInterval currentInterval = [_layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //设置指定图层的时间偏移量，保证暂停的时候是停在当前旋转的位置
    [_layer setTimeOffset:currentInterval];
 
    //设置速度为0，当动画停止
    _layer.speed = 0.0;
}

//当涂层重新开始旋转
- (void)resumeAnimation{
    
    //从上一次暂停到现在的恢复，经过的时间为 _layer.timeOffset，当前时间为CACurrentMediaTime()
    //那么 CACurrentMediaTime() - _layer.timeOffset 的结果就是上一次暂停时的时间
    //将_layer的动画开始时间（_layer.beginTime）设置为这个时间的话，_layer就会从暂停的位置开始旋转了。
    CFTimeInterval beginTime = CACurrentMediaTime() - _layer.timeOffset;
    
    //重置时间偏移量为0
    _layer.timeOffset = 0;
    
    //设置图层的动画开始时间
    _layer.beginTime = beginTime;
    
    //设置图层的动画速度为1.0，开始动画
    _layer.speed = 1.0;
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CGPoint touchP = [[anim valueForKey:@"tAnimation_touchPoint"] CGPointValue];
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    _layer.position = touchP;
    [CATransaction commit];
    
    //在动画结束时暂停动画
    [self pauseAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
