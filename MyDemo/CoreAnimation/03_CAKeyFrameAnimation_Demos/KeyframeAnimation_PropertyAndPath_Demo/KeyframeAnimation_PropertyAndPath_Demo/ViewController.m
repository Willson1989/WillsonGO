//
//  ViewController.m
//  KeyframeAnimation_PropertyAndPath_Demo
//
//  Created by Willson on 16/4/13.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    CALayer *_layer;
}

@end

#define lWidth  80
#define kAnimation_Translation @"animation_translation"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _layer = [[CALayer alloc]init];
    _layer.backgroundColor = [[UIColor purpleColor] CGColor];
    _layer.bounds = CGRectMake(0, 0, lWidth, lWidth);
    _layer.position = CGPointMake(lWidth, lWidth);
    _layer.cornerRadius = lWidth/2;
    [self.view.layer addSublayer:_layer];

    [self translationAnimation_SettingValues];
//    [self translationAnimation_SettingPath];
}

#pragma mark 关键帧动画
//设置动画的几个关键点
- (void)translationAnimation_SettingValues{
    
    //1.创建关键帧动画对象并设置属性
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    kfAnimation.delegate = self;
    
    //2.设置关键帧，并放到数组中
    NSValue *key1=[NSValue valueWithCGPoint:_layer.position];//对于关键帧动画初始值不能省略
    NSValue *key2=[NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3=[NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4=[NSValue valueWithCGPoint:CGPointMake(55, 400)];
    NSArray *values = @[key1,key2,key3,key4];
    kfAnimation.values = values;
    /*
     caculationMode：
     动画计算模式。还拿上面keyValues动画举例，之所以1到2帧能形成连贯性动画
     而不是直接从第1帧经过8/3秒到第2帧是因为动画模式是连续的（值为kCAAnimationLinear，这是计算模式的默认值）；
     而如果指定了动画模式为kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，
     中间没有任何过渡。其他动画模式还有：
     kCAAnimationPaced（均匀执行，会忽略keyTimes）、
     kCAAnimationCubic（平滑执行，对于位置变动关键帧动画运行轨迹更平滑）、
     kCAAnimationCubicPaced（平滑均匀执行）。
     
     NSString * const kCAAnimationLinear
     NSString * const kCAAnimationDiscrete
     NSString * const kCAAnimationPaced
     NSString * const kCAAnimationCubic
     NSString * const kCAAnimationCubicPaced
     */
    //kfAnimation.calculationMode = kCAAnimationCubicPaced;
    
    /*
     keyTimes：
     各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。
     如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，
     就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，
     此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），
     也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
     */
    kfAnimation.keyTimes = @[@0.0, @(1/8), @(3/8), @1];
    
    [kfAnimation setValue:key4 forKey:@"end_Point"];
    
    //设置其他属性
    kfAnimation.duration = 4.0;
    kfAnimation.beginTime = CACurrentMediaTime() + 2;
    
    //3.添加关键帧动画到layer中
    [_layer addAnimation:kfAnimation forKey:kAnimation_Translation];

}

//设置动画按照指定的路径行进
- (void)translationAnimation_SettingPath{
    
    //1.创建关键帧动画并设置动画属性
    CAKeyframeAnimation *kfAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    kfAnimation.delegate = self;
    
    //2.设置路径
    //绘制贝塞尔曲线
    CGPathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);//移动到起始点
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 55, 400);//绘制二次贝塞尔曲线
    
    [kfAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(55, 400)] forKey:@"end_Point"];
    kfAnimation.calculationMode = kCAAnimationDiscrete;
    kfAnimation.path = path; //设置path属性
    CGPathRelease(path); //释放路径对象
    
    //设置其他属性
    kfAnimation.duration = 3;
    kfAnimation.beginTime = CACurrentMediaTime() + 1;
    [_layer addAnimation:kfAnimation forKey:kAnimation_Translation];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [CATransaction begin];
    
    [CATransaction setDisableActions:YES];
    _layer.position = [[anim valueForKey:@"end_Point"] CGPointValue];
    
    [CATransaction commit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
