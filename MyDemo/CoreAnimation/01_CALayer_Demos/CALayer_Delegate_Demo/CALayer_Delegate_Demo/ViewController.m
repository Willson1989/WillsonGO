//
//  ViewController.m
//  CALayer_Delegate_Demo
//
//  Created by Willson on 16/4/12.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end


#define photo_width  200
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CALayer *layer = [[CALayer alloc]init];
    layer.delegate = self;
    layer.backgroundColor = [[UIColor whiteColor] CGColor];
    layer.bounds = CGRectMake(0, 0, photo_width, photo_width);
    layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3);
    
    //注意仅仅设置圆角，对于图形而言可以正常显示，但是对于图层中绘制的图片无法正确显示
    //如果想要正确显示则必须设置masksToBounds=YES，剪切子图层
    layer.cornerRadius  = photo_width/2;
    layer.masksToBounds = YES;
    layer.borderColor = [[UIColor whiteColor] CGColor];
    layer.borderWidth = 5;
    //可以使用layer的transform属性直接旋转layer，而不必使用图形上下文来让图片旋转
    //后边三个变量分别代表 x,y,z轴，取值为-1~1，代表按指定轴转动
    //layer.transform = CATransform3DMakeRotation(M_PI, 1, 0, 0);
    
    //也可以使用KVC的方式来进行形变操作，
    //在动画开发中形变往往不是直接设置transform，而是通过keyPath进行设置。
    [layer setValue:@M_PI forKeyPath:@"transform.rotation.x"];
    
    //阴影效果无法和masksToBounds同时使用，因为masksToBounds的目的就是剪切外边框，
    //而阴影效果刚好在外边框
    //layer.shadowColor=[UIColor grayColor].CGColor;
    //layer.shadowOffset=CGSizeMake(2, 2);
    //layer.shadowOpacity=1;
    
    //既然同一个layer不能同时设置圆角和masksToBounds
    //那就创建一个新的layer让其负责阴影的显示
    CALayer *shadowLayer = [[CALayer alloc]init];
    shadowLayer.backgroundColor = [[UIColor whiteColor] CGColor];
    shadowLayer.bounds = CGRectMake(0, 0, photo_width, photo_width);
    shadowLayer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/3);
    shadowLayer.cornerRadius = layer.cornerRadius;
    
    //阴影颜色
    shadowLayer.shadowColor = [[UIColor yellowColor] CGColor];
    
    //阴影透明度
    shadowLayer.shadowOpacity = 1;
    
    //阴影半径
    shadowLayer.shadowRadius = 10;
    
    //阴影偏移量
    shadowLayer.shadowOffset  = CGSizeMake(0,0);
    
    [self.view.layer addSublayer:shadowLayer];
    [self.view.layer addSublayer:layer];
    
    [layer setNeedsDisplay];
}

-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx{
    
    CGContextSaveGState(ctx);
    
    //可以直接对CALayer进行旋转操作，所以可以不必使用图形上下文来对图片进行旋转。
    //缩放，y轴为-1时，代表等比例水平方向翻转
    //CGContextScaleCTM(ctx, 1, -1);
    //平移，水平方向翻转之后，图片的位置就改变了，所以要向下平移图片高度的距离。
    //CGContextTranslateCTM(ctx, 0, -photo_width);
    UIImage *image = [UIImage imageNamed:@"photo.png"];
    CGContextDrawImage(ctx, CGRectMake(0, 0, photo_width, photo_width), image.CGImage);
    
    CGContextRestoreGState(ctx);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
