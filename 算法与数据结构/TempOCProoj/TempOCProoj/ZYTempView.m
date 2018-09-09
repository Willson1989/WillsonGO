//
//  ZYTempView.m
//  TempOCProoj
//
//  Created by 朱金倩 on 2018/8/30.
//  Copyright © 2018年 ZhengYi. All rights reserved.
//

#import "ZYTempView.h"

@implementation ZYSubView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"ZYSubView touchesBegan");
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL a = [super pointInside:point withEvent:event];
    return a;
}

@end

@implementation ZYTempView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"ZYTempView touchesBegan");
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    UIView *view = [super hitTest:point withEvent:event];
    return view;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    BOOL a = [super pointInside:point withEvent:event];
    return a;
}

@end
