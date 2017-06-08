//
//  ViewController.m
//  CALayer_001
//
//  Created by Willson on 16/4/12.
//  Copyright © 2016年 郑毅. All rights reserved.
//

#import "ViewController.h"


#define WIDTH  100
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self drawMyLayers];
}

- (void)drawMyLayers{
    CALayer * layer = [[CALayer alloc]init];
    layer.backgroundColor = [[UIColor blueColor] CGColor];
    layer.position = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    layer.bounds = CGRectMake(0, 0, WIDTH, WIDTH);
    layer.cornerRadius = WIDTH/2;
    layer.opacity = 0.6;
    
    [self.view.layer addSublayer:layer];
    NSLog(@"myLayer index : %li",[self.view.layer.sublayers indexOfObject:layer]);
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CALayer *tempLayer = self.view.layer.sublayers[2];
    UITouch *touch = [touches anyObject];
    CGPoint locationP = [touch locationInView:self.view];
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenH = [UIScreen mainScreen].bounds.size.height;

    if (locationP.x - WIDTH < 0) {
        locationP = CGPointMake(WIDTH/2, locationP.y);
    }
    if (locationP.x + WIDTH > screenW) {
        locationP = CGPointMake(screenW - WIDTH/2, locationP.y);
    }
    if (locationP.y - WIDTH < 0) {
        locationP = CGPointMake(locationP.x, WIDTH/2);
    }
    if (locationP.y + WIDTH > screenH) {
        locationP = CGPointMake(locationP.x, screenH - WIDTH/2);
    }
    
    tempLayer.position = locationP;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
