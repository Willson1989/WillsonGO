//
//  ViewController.m
//  BasicAnimation_001
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

#define lWidth 100

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建图层
    _layer = [[CALayer alloc]init];
    _layer.bounds = CGRectMake(0, 0, lWidth, lWidth);
    _layer.position = CGPointMake(lWidth, lWidth);
    _layer.backgroundColor = [[UIColor purpleColor] CGColor];
//    _layer.cornerRadius = lWidth/2;
    [self.view.layer addSublayer:_layer];
    
}

//点击屏幕让涂层跳转到点击的位置
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint  touchPoint = [touch locationInView:self.view];
    [self transitionAnimation:touchPoint];
    [self rotationAnimation];
}

- (void)transitionAnimation:(CGPoint)touchPoint{
    //1.创建动画并指定动画属性
    CABasicAnimation *pAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    pAnimation.delegate = self;
    
    //2.设置动画属性初始值和结束值
    //animation.fromValue = [NSNumber numberWithInt:11]; //可以不用设置fromValue，默认为涂层的初始值
    pAnimation.toValue = [NSValue valueWithCGPoint:touchPoint];
    
    //3.设置其他动画属性
    pAnimation.duration = 0.5;
    
    //设置重复次数,HUGE_VALF可看做无穷大，起到循环动画的效果
    //animation.repeatCount = HUGE_VALF;
    
    //运行一次完成之后，是否移除动画
    pAnimation.removedOnCompletion = NO;
    
    //在动画开始之前，将点击的位置保存到动画的一个value中，在动画结束的时候重新设置layer的position
    //这样会防止涂层在移动之后又重新回到原点。
    [pAnimation setValue:[NSValue valueWithCGPoint:touchPoint] forKey:@"basicAnimationEndPoint"];
    
    //3.将动画添加到涂层中，注意第二个参数key相当于对动画命名，便于之后通过这个key来找到相应的动画
    [_layer addAnimation:pAnimation forKey:@"WAnimation_position"];
}

- (void)rotationAnimation{
    
    CABasicAnimation *rAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rAnimation.duration = 3.0;
    rAnimation.fromValue = @0;
    rAnimation.toValue   = @(M_PI * 2);
    [_layer addAnimation:rAnimation forKey:@"WAnimation_rotation"];
}

-(void)animationDidStart:(CAAnimation *)anim{
    NSLog(@"animation did start %@",anim);
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CAAnimation *tempAnim = [_layer animationForKey:@"WAnimation_position"];
    NSLog(@"animation did stop  %@",tempAnim);
    
    if (anim == tempAnim) {
        
        //取出之前保存的坐标位置，并重新设置_layer的position
        CGPoint touchPoint = [[anim valueForKey:@"basicAnimationEndPoint"] CGPointValue];
        //单纯地设置position会触发layer的隐式动画，从而导致涂层移动到指定位置时，
        //又重新闪回到原点再移动一次
        //_layer.position = touchPoint;
        
        //为了防止设置position时触发隐式动画，
        //在设置时要先禁用涂层的隐式动画，设置完成之后再启用
        [CATransaction begin];
        [CATransaction setDisableActions:YES]; //禁用动画
        _layer.position = touchPoint;
        [CATransaction commit];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
