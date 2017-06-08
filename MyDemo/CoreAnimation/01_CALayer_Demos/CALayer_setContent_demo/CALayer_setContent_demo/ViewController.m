//
//  ViewController.m
//  CALayer_setContent_demo
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
    
    //如果只是单纯在layer上显示图片的话，直接设置CALayer的content就可以了
    //这样的话就不用考虑图片会倒过来的问题了
    UIImage *image = [UIImage imageNamed:@"photo.png"];
    [layer setContents:(id)image.CGImage];
    
    //阴影
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
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
