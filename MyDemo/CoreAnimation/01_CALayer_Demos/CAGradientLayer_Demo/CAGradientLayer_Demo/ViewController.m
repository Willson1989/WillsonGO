//
//  ViewController.m
//  CAGradientLayer_Demo
//
//  Created by Willson on 16/4/18.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) CAGradientLayer *layer;
@property (strong, nonatomic) NSMutableArray  *mutableColorArr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self addCommonGrandientLayer];
    //[self addTimmerGrandientLayer];
    [self addColorsProgrssGrandientLayer];
}

//基本使用方法
- (void)addCommonGrandientLayer{
    CGColorRef c1 = [[UIColor redColor] CGColor];
    CGColorRef c2 = [[UIColor blueColor] CGColor];
    CGColorRef c3 = [[UIColor yellowColor] CGColor];
    CGColorRef c4 = [[UIColor greenColor] CGColor];
    
    NSArray *colorArr = @[(__bridge id)c1,
                          (__bridge id)c2,
                          (__bridge id)c3,
                          (__bridge id)c4];
    CAGradientLayer *layer = nil;
    layer = [CAGradientLayer layer];
    layer.bounds = self.view.bounds;
    layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    
    //startPoint 和 endPoint 决定了颜色渐变的方向
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint   = CGPointMake(1, 0);
    
    //设置颜色数组
    layer.colors = colorArr;
    
    //设置每种颜色所占的比例  取值范围0 ~ 1
    layer.locations = @[@0.25, @0.5, @0.75, @1.0];
    
    [self.view.layer addSublayer:layer];
}

//----------------------------------------
//渐变颜色，NSTimer方式自动边色
- (void)addTimmerGrandientLayer{
    //创建一个背景图片
    UIImageView *imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bg.png"]];
    imgView.frame = CGRectMake(0, 0, self.view.frame.size.width, 200);
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgView];
    
    CGColorRef c1 = [[UIColor clearColor]  CGColor];
    CGColorRef c2 = [[UIColor purpleColor] CGColor];
    NSArray *colorArr = @[(__bridge id)c1, (__bridge id)c2];
    _layer = [CAGradientLayer layer];
    _layer.bounds    = imgView.frame;
    _layer.position  = CGPointMake(imgView.frame.size.width/2, imgView.frame.size.height/2);
    _layer.colors    = colorArr;
    
    //注意，locations的元素不是间距，而是一个点
    _layer.locations = @[@0.5, @1.0];
    [imgView.layer addSublayer:_layer];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
}

- (void)timerAction{
    CGColorRef tempColor  = [[UIColor colorWithRed:(arc4random() % 255)/255.0
                                             green:(arc4random() % 255)/255.0
                                              blue:(arc4random() % 255)/255.0
                                             alpha:1.0] CGColor];
    
    CGColorRef clearColor = [[UIColor clearColor] CGColor];
    
    _layer.colors = @[(__bridge id)clearColor, (__bridge id)tempColor];
    
    CGFloat location = ( arc4random() % 10 ) / 10;
    
    _layer.locations = @[@(location), @(1.0)];
}
//----------------------------------------
- (void)addColorsProgrssGrandientLayer{

    _mutableColorArr = [NSMutableArray array];
    
    //为了实现色条前进的效果，
    //可以将数组中最后一个元素暂存并删除，然后重新添加到颜色数组的首位，
    //缩短动画区间duration，让其频率足够快，这样就达到了想要的效果。
    for (NSInteger hue = 0; hue <= 360; hue += 5) {
        UIColor *color;
        color = [UIColor colorWithHue:1.0 * hue / 360.0
                           saturation:1.0
                           brightness:1.0
                                alpha:1.0];
        [_mutableColorArr addObject:(id)[color CGColor]];
    }
    _layer = [CAGradientLayer layer];
    _layer.bounds = CGRectMake(0, 0, self.view.frame.size.width, 1);
    _layer.position = CGPointMake(self.view.frame.size.width/2, 64);
    NSArray *cArr = [NSArray arrayWithArray:_mutableColorArr];
    _layer.colors = cArr;
    _layer.startPoint = CGPointMake(0, 0);
    _layer.endPoint = CGPointMake(1, 0);
    
    
    CALayer *maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [[UIColor blackColor] CGColor];
    
    //设置layer的遮罩层
    //不太清楚为什么mask的长度要乘以2
    //比如，如果mask要占layer的 1/3的话，就需要_layer.frame.size.width/3 * 2
    //这里要区别开，mask的部分是layer显示的部分，如mask为1/3的话，那么layer就显示整个的1/3。
    maskLayer.bounds = CGRectMake(0, 0, self.view.frame.size.width/3 *2, _layer.bounds.size.height);
//    _layer.mask = maskLayer;
    
    [self.view.layer addSublayer:_layer];
    [self performAnimation];
}

- (void)performAnimation{
    
    CAGradientLayer *layer = self.layer;
    NSMutableArray *colorsArr = [layer.colors mutableCopy];
    id lastColor = [colorsArr lastObject];
    [colorsArr removeLastObject];
    [colorsArr insertObject:lastColor atIndex:0];
    NSArray *shiftedColors = [NSArray arrayWithArray:colorsArr];
    layer.colors = shiftedColors;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 0.08;
    animation.delegate = self;
    animation.removedOnCompletion = YES;
    animation.toValue = shiftedColors;
    [layer addAnimation:animation forKey:@"glayer_Animation"];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    [self performAnimation];
}

- (void)setProgress:(CGFloat)progress{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
